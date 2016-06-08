//
//  IZCStringKit.h
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/17.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IZCStringKit : NSObject

+ (CGSize)GetStringProperSize:(NSString *)textString
                         font:(UIFont *)font
                        width:(float)width;

+ (CGSize)GetStringProperSize:(NSString *)textString
                         font:(UIFont *)font;

// sha256加密方式
+ (NSString *)getSha256String:(NSString *)srcString;


/**
 *  此方法随机产生20位字符串， 修改代码红色数字可以改变 随机产生的位数
 *
 *  @return 20位随机数
 */
+ (NSString *)getRet20bitString;

/**
 *  字符串是否包含aString
 *
 *  @param mString 原字符串参数
 *  @param aString 包含字符串参数
 *
 *  @return 是否包含
 */
+ (BOOL)devString:(NSString *)mString containsString:(NSString *)aString;

/**
 *  知道一段文字，求导更改行高后的高度
 *  add by yly
 *  @param width 屏幕的宽
 *  @param string 更改行高的文字
 *
 *  @return 是否包含
 */
+ (CGSize)GetTheHeightOgTheUILabelWithTheWidth:(CGFloat)width andTheString:(NSString *)string;



/**
 *  @author Rain, 15-11-27 22:11:13
 *
 *  @brief  获得uuid
 *
 *  @return uuid
 */
+ (NSString*) getUUIDString;


@end
