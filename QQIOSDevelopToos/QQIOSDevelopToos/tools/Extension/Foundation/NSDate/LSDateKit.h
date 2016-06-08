//
//  LSDateKit.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LSDateKit : NSObject

// 得到当前的时间戳
+ (NSString *)GetTimeSep;

// timeSep:把距离1970年的毫秒转换为真实时间
+ (NSString *)descriptionDateWithTimeSep:(NSUInteger)timeSep;

/**
 *  得到一个格式化的时间 - 格式化类型为：yyyy-MM-dd HH:mm:ss
 *
 *  @param date 需要格式化的时间
 *
 *  @return 格式化之后的字符串
 */
+ (NSString *)descriptionDate:(NSDate *)date;

/**
 *  根据指定的格式格式化的时间
 *
 *  @param date   需要格式化的时间
 *  @param format 格式化格式
 *
 *  @return 格式化之后的字符串
 */
/**
 *  常用格式说明
 *  具体格式参数见下面详解
 yyyy-MM-dd HH:mm:ss  2016-05-12 19:30:30
 yyyy-MM-dd HH:mm  2016-05-12 19:30
 yyyy-MM-dd     2016-05-12
 yyyy年MM月dd日  2016年5月12日
 MM月dd日 HH:mm  5月12日 19:30
 */
#define kLSDateFormatNormal @"yyyy-MM-dd HH:mm:ss"
#define kLSDateFormatType1  @"yyyy-MM-dd HH:mm"
#define kLSDateFormatType2  @"yyyy-MM-dd"
#define kLSDateFormatType3  @"yyyy年MM月dd日"

+ (NSString *)descriptionDate:(NSDate *)date format:(NSString *)format;

/**
 *  根据一定格式的字符串转换为Date对象
 *
 *  @param dateString 日期格式的字符串
 *  @param format     格式
 *
 *  @return Date对象
 */
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;
+ (NSDate *)dateForMSecsSince1970:(long long)ms;

/**
 *  将一个格式化之后的字符串换成另外一个格式
 *
 *  @param dateString 格式化过的字符串日期
 *  @param format     该字符串的format格式
 *  @param toFormat   目标格式
 *
 *  @return 目标格式的字符串
 */
+ (NSString *)updateStringDate:(NSString *)dateString formFormat:(NSString *)format toFormat:(NSString *)toFormat;

@end

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
