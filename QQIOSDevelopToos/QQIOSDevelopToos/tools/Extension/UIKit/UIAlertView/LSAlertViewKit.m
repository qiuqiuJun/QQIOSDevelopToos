//
//  LSAlertViewKit.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/15.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSAlertViewKit.h"

@implementation LSAlertViewKit

+ (void)showAlert:(NSString *)message
{
    [LSAlertViewKit showAlertWithTitle:@"提示" message:message cancelButtonTitle:@"确定"];
}


+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    [alert show];
    [LSAlertViewKit showAlertWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitle:nil];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
//#if __IPHONE_8_0
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil];
//    
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:nil];
//    
//    [alertController addAction:cancelAction];
//    
//    [alertController addAction:okAction];
//    
////    [self presentViewController:alertController animated:YES completion:nil];
//#else
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    [alert show];
//#endif
}

@end
