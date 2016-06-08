//
//  LSMacro_NSString.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#ifndef LSMacro_NSString_h
#define LSMacro_NSString_h

#pragma mark - NSStringUtility
/**
 *  判断字符串是否为空
 */
#define LSNSStringIsEmpty(str) ((str==nil)||([str length]==0)||[str isEqualToString:@""]||[str isEqualToString:@"(null)"])
/**
 *  获取utf-8编码的str
 */
#define LSGetStringUTF8Encoding(str)  [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

#pragma mark - Convert
#define DevIntToString(i) [NSString stringWithFormat:@"%ld", i]


#endif /* LSMacro_NSString_h */
