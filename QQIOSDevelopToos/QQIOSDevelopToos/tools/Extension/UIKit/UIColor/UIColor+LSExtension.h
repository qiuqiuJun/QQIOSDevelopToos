//
//  UIColor+Extension.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

/**
 *  根据RGB获取颜色
 *
 *  @param red   red
 *  @param green green
 *  @param blue  blue
 *
 *  @return 返回对应颜色
 */
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;


/**
 *  根据十六进制获取颜色
 *
 *  @param hexValue 十六进制数字
 *
 *  @return 返回对应颜色
 */
+ (UIColor *)colorWithHex:(NSInteger)hexValue;
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;

/**
 *  根据十六进制获取颜色
 *
 *  @param stringToConvert 颜色的十六进制值-字符串
 *
 *  @return 返回对应颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end

