//
//  UIView+LSToastView.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/14.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const LSToastPositionTop;
extern NSString *const LSToastPositionCenter;
extern NSString *const LSToastPositionBottom;


/**
 *  UIView 扩展
 */
@interface UIView (ToastView)

/**
 *  显示简单提示
 *  默认提示时间1秒，提示位置center
 *  @param message 提示内容
 */
- (void)makeToast:(NSString *)message;

/**
 *  显示简单提示
 *
 *  @param message  提示内容
 *  @param interval 展示时间
 */
- (void)makeToast:(NSString *)message
         duration:(CGFloat)interval;

/**
 *  显示简单提示
 *
 *  @param message  提示内容
 *  @param interval 展示时间
 *  @param position 所在view上的位置 top,center,bottom
 */
- (void)makeToast:(NSString *)message
         duration:(CGFloat)interval
         position:(id)position;

- (void)makeToastActivity;

// 20151126新加 标识是否需要拦截
- (void)makeToastActivityWithIntercept:(BOOL)intercept;

/**
 *  风火轮提示
 *
 *  @param position 所在view上的位置
 */
- (void)makeToastActivityWithPosition:(id)position;

/**
 *  隐藏风火轮
 */
- (void)hideToastActivity;


@end