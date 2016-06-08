//
//  LSScrollView.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/15.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSScrollView.h"

// 点击区域限制-即如果点击一个点只允许移动很少的部分才算是点击
#define kLSTouchAreLimit 10

@interface LSScrollView ()

@property (nonatomic, assign) CGPoint touchPoint;

@end

@implementation LSScrollView

#pragma mark touches event
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 1) {
        self.touchPoint = [touch locationInView:self];
        if (self.touchDelegate && [self.touchDelegate respondsToSelector:@selector(scrollViewWillTouch:touchPoint:)]) {
            [self.touchDelegate scrollViewWillTouch:self touchPoint:self.touchPoint];
        }
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    if (!self.dragging) {
        if (touch.tapCount == 1) {
            
            CGPoint endWinPoint = [touch locationInView:self];
            CGFloat offsetX = fabs(endWinPoint.x-self.touchPoint.x);
            CGFloat offsetY = fabs(endWinPoint.y-self.touchPoint.y);
            
            if (offsetX<kLSTouchAreLimit&&offsetY<kLSTouchAreLimit)
            {// 限定像素内的小偏移认为是点击
                [self performSelector:@selector(touchScrollView) withObject:nil afterDelay:.2];
            }
        }
    }
}

- (void)touchScrollView
{
    if (self.touchDelegate && [self.touchDelegate respondsToSelector:@selector(scrollViewTouchUpInside:)]) {
        [self.touchDelegate scrollViewTouchUpInside:self];
    }
}

@end
