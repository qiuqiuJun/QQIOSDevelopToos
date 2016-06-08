//
//  LSAlertViewKit.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/15.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSAlertViewKit : NSObject

+ (void)showAlert:(NSString *)message;

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;

@end
