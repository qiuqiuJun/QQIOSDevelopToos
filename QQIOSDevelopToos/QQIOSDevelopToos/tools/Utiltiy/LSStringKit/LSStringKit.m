//
//  LSStringKit.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSStringKit.h"
#import "NSString+LSExtension.h"

@implementation LSStringKit

+ (CGSize)GetStringProperSize:(NSString *)textString
                         font:(UIFont *)font
                        width:(float)width
{
    return [textString getProperSizeWithFont:font width:width];
}

+ (CGSize)GetStringProperSize:(NSString *)textString
                         font:(UIFont *)font
{
    return [textString getProperSizeWithFont:font];
}

+ (BOOL)CheckString:(NSString *)string isContains:(NSString *)target
{
    return [string isContainsString:target];
}

@end

