//
//  LSTextField.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/15.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSTextField.h"

#import "UIView+LSTextField.h"

static CGFloat const kLSTextFieldKeyboardSpace = 30;

@interface LSTextField ()

// 记录当前已经调整过的currentKeyboardHeight
@property (nonatomic, assign) CGFloat currentKeyboardHeight;

@end

@implementation LSTextField

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addNotification];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addNotification];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

- (void)textFieldTextDidBeginEditing:(NSNotification *)notification
{
    if (self == notification.object) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
}

- (void)textFieldTextDidEndEditing:(NSNotification *)notification
{
    if (self == notification.object) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
        self.currentKeyboardHeight = 0;
    }
}

#pragma mark - keyboardEventNotification
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self moveInputBarWithKeyboardHeight:CGRectGetHeight(keyboardRect) withDuration:animationDuration];
}
// 这里这个hide有可能是一个输入框取消第一响应，直接切换到另外一个输入框成为第一响应
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self moveInputBarWithKeyboardHeight:0.0 withDuration:animationDuration];
}

-(void)moveInputBarWithKeyboardHeight:(CGFloat)height withDuration:(NSTimeInterval)duration
{
    if (height == self.currentKeyboardHeight) {
        // 高度没有改变
        return;
    }
    
    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardChangeHeight:withDuration:)]) {
        [self.keyboardDelegate keyboardChangeHeight:height withDuration:duration];
    }
    // 如果设置了绑定视图
    if (self.bindingView) {
        self.currentKeyboardHeight = height;
        
//        if (self.bindingView.lsOriginYOffset>=0 && height>0) {
//            self.bindingView.lsOriginY = CGRectGetMinY(self.bindingView.frame);
//        }
        // 暂时通过这种方式保证只会记录一次lsOriginY
        if (!self.bindingView.lsOriginYHaved) {
            self.bindingView.lsOriginY = CGRectGetMinY(self.bindingView.frame);
            self.bindingView.lsOriginYHaved = YES;
        }
        
        
        CGRect targetRect = CGRectZero;
        BOOL needAniamtion = NO;
        if ( 0 == height) {
            //恢复bindingView的frame
            CGRect bindRect = self.bindingView.frame;
            bindRect.origin.y = self.bindingView.lsOriginY;
            targetRect = bindRect;
            needAniamtion = YES;
        } else {
            // 把textfield的frame转换到bindingView上
            CGRect inputInViewFrame = [self.bindingView convertRect:self.frame fromView:self.superview];
            // 计算出键盘高度加inputView的frame的高度
            CGFloat actulHeight = CGRectGetMinY(inputInViewFrame)+CGRectGetHeight(inputInViewFrame)+height;
            
            if (actulHeight > CGRectGetHeight(self.bindingView.frame)-kLSTextFieldKeyboardSpace)
            {// 需要调整
                CGRect bindRect = self.bindingView.frame;
                bindRect.origin.y = self.bindingView.lsOriginY - (actulHeight - CGRectGetHeight(self.bindingView.frame) + kLSTextFieldKeyboardSpace);
                targetRect = bindRect;
                needAniamtion = YES;
            } else {
                if (CGRectGetMinY(self.bindingView.frame)!=self.bindingView.lsOriginY) {
                    CGRect bindRect = self.bindingView.frame;
                    bindRect.origin.y = self.bindingView.lsOriginY;
                    targetRect = bindRect;
                    needAniamtion = YES;
                }
            }
        }
        
        if (needAniamtion) {
            // 记录这个修改的值
            self.bindingView.lsOriginYOffset = CGRectGetMinY(targetRect);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:duration animations:^{
                    self.bindingView.frame = targetRect;
                } completion:^(BOOL finished) {
                }];
            });
        }
    }
}

@end
