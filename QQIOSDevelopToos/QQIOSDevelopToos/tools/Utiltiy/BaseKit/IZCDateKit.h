//
//  IZCDateKit.h
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/17.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DevMsgTimeFormat @"yyyy-MM-dd HH:mm:ss"
#define DevTimeFormatForAddReminderAboutCreateMemo @"yy/MM/dd EE HH:mm"
#define DevRemindTimeFormatAboutMemo @"yyyy年MM月dd日 HH:mm"
#define DevCreateTimeFormatAboutMemo @"MM月dd日 HH:mm"

typedef NS_ENUM(NSInteger,DevDateTag)
{
    DevDateTag_Year,
    DevDateTag_Mouth,
    DevDateTag_Day,
    DevDateTag_Hour,
    DevDateTag_Week,
};

@interface IZCDateKit : NSObject

// 得到当前的时间戳
+ (NSString *)GetTimeSep;

// 得到一个格式化后的时间
+ (NSString *)descriptionDate:(NSDate *)date;

// timeSep:把距离1970年的毫秒转换为真实时间
+ (NSString *)descriptionDateWithTimeSep:(int)timeSep;

//
+ (NSString *)descriptionDateNoTimeWithTimeSep:(NSTimeInterval)timeSep;

// 时间的小时
+ (NSInteger)hourOfDate:(NSDate *)date;

/**
 *  @brief  按照时间格式将 NSDate -> NSString
 *  @param  format @"yyyy-MM-dd"
 *  EEE简写星期几， EEEE全写星期几
 */

#pragma mark - 格式时间为字符串
+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

/**
 *  @brief  按照时间格式将 NSString -> NSDate
 *  @param  format @"yyyy-MM-dd"
 */
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;
+ (NSDate *)dateForMSecsSince1970:(long long)ms;

//默认格式化的时间字符串转化为要显示的时间格式字符串 默认格式:yyyy-MM-dd HH:mm:ss
+ (NSString *)getMsgTimeString:(NSString *)dateStr;
//根据传入时间格式转化为要显示的时间格式字符串
+ (NSString *)getMsgTimeString:(NSString *)dateStr format:(NSString *)format;
//根据传入时间转化为要显示的时间格式字符串
+ (NSString *)getMsgTimeStringWithDate:(NSDate *)date;
//根据传入时间戳转化为要显示的时间格式字符串
+ (NSString *)getMsgTimeStringWithSince1970:(NSTimeInterval)ti;
////根据传入时间戳字符串转化为要显示的时间格式字符串
+ (NSString *)getMsgTimeStringWithSince1970ForString:(NSString *)tiString;
//Rachel add for email
+ (NSString *)getMsgTimeStringWithSince1970ForEmailList:(NSString *)tiString;
+ (NSString *)getMsgTimeStringWithSince1970ForEmailDetail:(NSString *)tiString;

+ (NSString *)stringForChatHistoryRecordTime:(NSDate *)date;
/*
 格式化参数如下：
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan//跟系统语言版本有关系，中文显示“3月”，英文显示“Jan”
 MMMM: 月，显示为英文月份全称，如 Janualy//跟系统语言版本有关系，中文显示“3月”，英文显示“Jan”
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S: 毫秒
 */


@end
