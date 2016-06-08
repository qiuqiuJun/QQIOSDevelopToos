//
//  NSString+LSExtension.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "NSString+LSExtension.h"

#pragma mark - NSString扩展

@implementation NSString(LSExtension)

- (CGSize)getProperSizeWithFont:(UIFont *)font width:(CGFloat)width
{
    CGSize textSize = CGSizeZero;
#if __IPHONE_7_0
    {
        // NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
        // NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
        // 计算文本的大小
        textSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                      options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制de时的附加选项
                                   attributes:@{NSFontAttributeName:font}        // 文字的属性
                                      context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    }
#else
    {
        textSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    }
#endif
    return textSize;
}

- (CGSize)getProperSizeWithFont:(UIFont *)font
{
    CGSize textSize = CGSizeZero;
    
#if __IPHONE_7_0
    {
        textSize = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    }
#else
    {
        textSize = [self sizeWithFont:font];
    }
#endif
    
    return textSize;
}

- (BOOL)isContainsString:(NSString *)string
{
    if ([self respondsToSelector:NSSelectorFromString(@"containsString:")]) {
        return [self containsString:string];
    } else {
        //判断mString 是否含有aString
        if([self rangeOfString:string].location !=NSNotFound)//_roaldSearchText
        {
            return YES;
        }
    }
    return NO;
}

@end