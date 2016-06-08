//
//  LSStringKit.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  依赖NSString+LSExtension，要一起导入
 */
@interface LSStringKit : NSObject

/**
 *  获取字符串的最合适的Size
 *
 *  @param textString 需要获取size的文本
 *  @param font       文字大小
 *  @param width      长度限制
 *
 *  @return 对应的Size
 */
+ (CGSize)GetStringProperSize:(NSString *)textString
                         font:(UIFont *)font
                        width:(float)width;
/**
 *  获取字符串的最合适的Size
 *
 *  @param textString 需要获取size的文本
 *  @param font       文字大小
 *
 *  @return 对应的Size
 */
+ (CGSize)GetStringProperSize:(NSString *)textString
                         font:(UIFont *)font;

/**
 *  判断一个字符串是否包含另一个字符串
 *
 *  @param string 字符串
 *  @param target 是否包含的目标字符串
 *
 *  @return YES:包含 NO:不包含
 */
+ (BOOL)CheckString:(NSString *)string isContains:(NSString *)target;

@end

