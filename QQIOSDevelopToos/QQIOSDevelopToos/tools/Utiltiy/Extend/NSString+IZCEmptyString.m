//
//  NSString+IZCEmptyString.m
//  IZiChan
//
//  Created by 文夕 on 16/4/5.
//  Copyright © 2016年 danchwl. All rights reserved.
//

#import "NSString+IZCEmptyString.h"

@implementation NSString (IZCEmptyString)
- (BOOL)isEmptyString
{
    if ([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0)
    {
        return YES;
    }
    
    if ([self isEqualToString:@"<null>"] || [self isEqualToString:@"(null)"])
    {
        return YES;
    }
    
    return NO;
}
@end
