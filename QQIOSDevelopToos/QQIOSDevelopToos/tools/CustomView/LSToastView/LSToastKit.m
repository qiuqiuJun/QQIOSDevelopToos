//
//  LSToastKit.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/14.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSToastKit.h"

#import "UIView+LSToastView.h"

@implementation LSToastKit

+ (UIWindow *)GetTopWindow
{
    __block UIWindow* tempWindow = nil;
    
    [[[UIApplication sharedApplication] windows] enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")]||[obj isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
            tempWindow = obj;
        }
    }];
    if (tempWindow) {
        // 键盘
        return tempWindow;
    } else {
        // 普通window上显示
        return [[UIApplication sharedApplication] keyWindow];
    }
}

// 默认在界面的最上层window上显示
+ (void)makeToast:(NSString *)message
{
    [[LSToastKit GetTopWindow] makeToast:message];
}

+ (void)makeToastActivity
{
    [[LSToastKit GetTopWindow] makeToastActivity];
}
/**
 *  理论上这里存在一个隐患，就是有可能makeToastActivity和hideToastActivity获取的不是一个window
 */
+ (void)hideToastActivity
{
    [[LSToastKit GetTopWindow] hideToastActivity];
}

// 在指定的view上显示
+ (void)makeToast:(NSString *)message inView:(UIView *)view
{
    [view makeToast:message];
}

+ (void)makeToastActivityInView:(UIView *)view
{
    [view makeToastActivity];
}

+ (void)hideToastActivityFromView:(UIView *)view
{
    [view hideToastActivity];
}

@end
