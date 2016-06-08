//
//  IZCDateKit.m
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/17.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import "IZCDateKit.h"

@implementation IZCDateKit

+ (NSString*)GetTimeSep
{
   UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeSp = [NSString stringWithFormat:@"%lld", recordTime];
    return timeSp;
}

+ (NSString *)descriptionDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    
    // 大写的HH表示强制的使用24小时制
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    
    return [formatter stringFromDate:date];
}

+ (NSString *)descriptionDateWithTimeSep:(int)timeSep
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSep];
    return [IZCDateKit descriptionDate:date];
}

+ (NSString *)descriptionDateNoTimeWithTimeSep:(NSTimeInterval)timeSep
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSep];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];// 大写的HH表示强制的使用24小时制
    
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    
    return [formatter stringFromDate:date];
}

+ (NSInteger)hourOfDate:(NSDate *)date
{
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *locationString = [formatter stringFromDate:date];
    NSInteger hour = [locationString integerValue];
    return hour;
}

+ (NSInteger)weekOfDate:(NSDate *)date tag:(DevDateTag)tag
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //[[NSDateComponents alloc] init]
    NSDateComponents *comps = nil;
    NSInteger unitFlags =NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    switch (tag) {
        case DevDateTag_Year:
        {
            return [comps year];
        }
            break;
            
        case DevDateTag_Mouth:
        {
            return [comps month];
        }
            break;
            
        case DevDateTag_Week:
        {
            return [comps weekday];
        }
            break;
            
        case DevDateTag_Day:
        {
            return [comps day];
        }
            break;
            
        case DevDateTag_Hour:
        {
            return [comps hour];
        }
            break;

            
        default:
            return [comps weekday];//星期日是1;
            break;
    }
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    
    return [IZCDateKit stringFromDate:date format:@"yyyy-MM-dd HH:mm"];
}
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
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


+ (NSDate *)dateForMSecsSince1970:(long long)ms
{

    //转化成秒
    NSTimeInterval sec = (ms + 28800)/1000;
    return [NSDate dateWithTimeIntervalSince1970:sec];
}

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:format];
    
    //    NSDate *destDate = [[NSDate alloc] init];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
}

+ (NSString *)stringForChatHistoryRecordTime:(NSDate *)date
{
    NSDate *msgDate = date;
    NSDate *currentDate = [NSDate date];
    if (!msgDate)
    {
        return nil;
    }
    NSInteger dayInt = [IZCDateKit weekOfDate:msgDate tag:DevDateTag_Day];
    NSInteger currentInt = [IZCDateKit weekOfDate:currentDate
                                              tag:DevDateTag_Day];
    
    NSString *hmString = [IZCDateKit stringFromDate:msgDate format:@"HH:mm"];
    if (currentInt == dayInt)
    {
        return hmString;
    }else if (currentInt == dayInt + 1)
    {
        return [NSString stringWithFormat:@"昨天 %@",hmString];
    }else if (currentInt > dayInt + 1 && currentInt < dayInt + 7)
    {
        return [IZCDateKit stringFromDate:msgDate format:@"EEEE HH:mm"];
    }else
    {
        return [IZCDateKit stringFromDate:msgDate format:@"yyyy年MM月dd日 HH:mm"];
    }
}

+ (NSString *)getMsgTimeStringWithDate:(NSDate *)date
{
    NSDate *msgDate = date;
    NSDate *currentDate = [NSDate date];
    if (!msgDate)
    {
        return nil;
    }
    NSInteger dayInt = [IZCDateKit weekOfDate:msgDate tag:DevDateTag_Day];
    NSInteger currentInt = [IZCDateKit weekOfDate:currentDate tag:DevDateTag_Day];
    
    if (currentInt == dayInt)
    {
        return [IZCDateKit stringFromDate:msgDate format:@"HH:mm"];
    }else if (currentInt == dayInt + 1)
    {
        return @"昨天";
    }else if (currentInt > dayInt + 1 && currentInt < dayInt + 7)
    {
        return [IZCDateKit stringFromDate:msgDate format:@"EEEE"];
    }else
    {
        return [IZCDateKit stringFromDate:msgDate format:@"yy/MM/dd"];
    }

}
+ (NSString *)getMsgTimeString:(NSString *)dateStr format:(NSString *)format
{//
    NSDate *msgDate = [IZCDateKit dateFromString:dateStr format:format];
    
    return [IZCDateKit getMsgTimeStringWithDate:msgDate];
}

+ (NSString *)getMsgTimeString:(NSString *)dateStr
{
    return [IZCDateKit getMsgTimeString:dateStr format:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)getMsgTimeStringWithSince1970:(NSTimeInterval)ti
{
    NSDate *date = [IZCDateKit dateForMSecsSince1970:ti];
    return [IZCDateKit getMsgTimeStringWithDate:date];
}

+ (NSString *)getMsgTimeStringWithSince1970ForString:(NSString *)tiString
{
    NSTimeInterval ti = [tiString doubleValue];
    return [IZCDateKit getMsgTimeStringWithSince1970:ti];
}


//Rachel add for email
//当前年、显示月和日  否则  显示年月日
+ (NSString *)getMsgTimeStringWithSince1970ForEmailList:(NSString *)tiString
{
    NSTimeInterval ti = [tiString doubleValue];
    NSDate *date = [IZCDateKit dateForMSecsSince1970:ti];
    return [IZCDateKit getMsgTimeStringWithDateForEmail:date];
}

//详细的日期+时间
+ (NSString *)getMsgTimeStringWithSince1970ForEmailDetail:(NSString *)tiString
{
    NSTimeInterval ti = [tiString doubleValue];
    NSDate *date = [IZCDateKit dateForMSecsSince1970:ti];
    return [IZCDateKit stringFromDate:date];
}

//date转年月日，为邮箱量身定制的
+ (NSString *)getMsgTimeStringWithDateForEmail:(NSDate *)date
{
    NSDate *msgDate = date;
    NSDate *currentDate = [NSDate date];
    if (!msgDate)
    {
        return nil;
    }
    NSInteger yearInt = [IZCDateKit weekOfDate:msgDate tag:DevDateTag_Year];
    NSInteger currentYearInt = [IZCDateKit weekOfDate:currentDate tag:DevDateTag_Year];
    
    NSInteger dayInt = [IZCDateKit weekOfDate:msgDate tag:DevDateTag_Day];
    NSInteger currentInt = [IZCDateKit weekOfDate:currentDate tag:DevDateTag_Day];
    
    NSInteger interactYear = currentYearInt - yearInt;
    NSInteger interactDay = currentInt - dayInt;
//    IZCLog(@"时间截止到现在是%ld年前",interactYear);
    if (interactYear)             //本年外，年月日
    {
        return [IZCDateKit stringFromDate:msgDate format:@"yy/MM/dd"];
    }
    else                //一开始interactDay < 3 现在更改为 == 1、 == 2，为了精确到昨天和前天,另外去掉秒 -- yly
    {
        if (!interactDay)         //当天，只显示时间
        {
            return[IZCDateKit stringFromDate:msgDate format:@"HH:mm"];
        }
        else if (interactDay == 1)  //三天内，显示月日+时间
        {
            return[IZCDateKit stringFromDate:msgDate format:@"昨天 HH:mm"];
        }
        else if (interactDay == 2)  //三天内，显示月日+时间
        {
            return[IZCDateKit stringFromDate:msgDate format:@"前天 HH:mm"];
        }
        else                     //三天后，显示月日
        {
            return [IZCDateKit stringFromDate:msgDate format:@"MM月dd日"];
        }
    }
    return @"";
}

@end
