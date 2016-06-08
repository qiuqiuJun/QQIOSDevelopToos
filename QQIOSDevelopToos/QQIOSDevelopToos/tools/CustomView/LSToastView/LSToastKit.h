//
//  LSToastKit.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/14.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSToastKit : UIView

// 默认在界面的最上层window上显示
+ (void)makeToast:(NSString *)message;

+ (void)makeToastActivity;

+ (void)hideToastActivity;

// 在指定的view上显示
+ (void)makeToast:(NSString *)message inView:(UIView *)view;

+ (void)makeToastActivityInView:(UIView *)view;

+ (void)hideToastActivityFromView:(UIView *)view;

@end
