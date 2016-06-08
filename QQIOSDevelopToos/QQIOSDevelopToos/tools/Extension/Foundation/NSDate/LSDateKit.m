//
//  LSDateKit.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSDateKit.h"

@implementation LSDateKit

// 得到当前的时间戳
+ (NSString *)GetTimeSep
{
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeSp = [NSString stringWithFormat:@"%lld", recordTime];
    return timeSp;
}

// timeSep:把距离1970年的毫秒转换为真实时间
+ (NSString *)descriptionDateWithTimeSep:(NSUInteger)timeSep
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSep];
    return [LSDateKit descriptionDate:date];
}

+ (NSString *)descriptionDate:(NSDate *)date
{
    return [LSDateKit descriptionDate:date format:kLSDateFormatNormal];
}

+ (NSString *)descriptionDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:format];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    dateFormatter = nil;
    return destDateString;
}

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter dateFromString:dateString];
}
+ (NSDate *)dateForMSecsSince1970:(long long)ms
{
    //转化成秒
    NSTimeInterval sec = (ms + 28800)/1000;
    return [NSDate dateWithTimeIntervalSince1970:sec];
}

+ (NSString *)updateStringDate:(NSString *)dateString formFormat:(NSString *)format toFormat:(NSString *)toFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:toFormat];
    return [dateFormatter stringFromDate:date];
}

@end
