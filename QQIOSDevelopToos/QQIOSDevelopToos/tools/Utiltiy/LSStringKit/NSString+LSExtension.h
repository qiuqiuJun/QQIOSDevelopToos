//
//  NSString+LSExtension.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - NSString扩展
@interface NSString(LSExtension)

/**
 *  获取字符串的最合适的Size
 *
 *  @param font  文字大小
 *  @param width 长度限制
 *
 *  @return 对应的Size
 */
- (CGSize)getProperSizeWithFont:(UIFont *)font width:(CGFloat)width;

/**
 *  获取字符串的最合适的Size -- 这里主要是自定义宽度
 *
 *  @param font 文字大小
 *
 *  @return 对应的Size
 */
- (CGSize)getProperSizeWithFont:(UIFont *)font;

/**
 *  是否包含某一个字符串
 *
 *  @param string 待检查是否包含的字符串
 *
 *  @return 包含返回YES，不包含返回NO
 */
- (BOOL)isContainsString:(NSString *)string;

@end