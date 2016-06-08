//
//  LSAlertContentView.m
//  iZichanSalary
//
//  Created by LoaforSpring on 16/5/12.
//  Copyright © 2016年 YiZhan. All rights reserved.
//

#import "LSAlertContentView.h"

@interface LSAlertContentView ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation LSAlertContentView

+ (UIWindow *)getApplicationWindow
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (nil==window || window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}

- (instancetype)initWithContentView:(UIView *)contentView
{
    UIWindow *keyWindow = [LSAlertContentView getApplicationWindow];
    self = [super initWithFrame:keyWindow.frame];
    if (self) {
        self.contentView = contentView;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        // 在自己内部添加一个点击事件用来dismiss
        [self addTarget:self action:@selector(clickAlertView) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

/**
 *  显示
 */
- (void)show
{
    UIWindow *keyWindow = [LSAlertContentView getApplicationWindow];
    [keyWindow addSubview:self];
    
    self.alpha = 0;
    
    self.contentView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame)+CGRectGetHeight(self.contentView.frame));
    [self addSubview:self.contentView];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.contentView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    }];
    
}

/**
 *  手动隐藏掉
 */
- (void)dismiss
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentViewWillDismiss:)]) {
        [self.delegate alertContentViewWillDismiss:self];
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame)+CGRectGetHeight(self.contentView.frame));
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.contentView = nil;
        [self removeFromSuperview];
    }];
}

- (void)clickAlertView
{
    [self dismiss];
}

@end
