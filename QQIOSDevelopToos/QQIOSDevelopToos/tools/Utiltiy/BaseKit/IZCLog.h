//
//  IZCLog.h
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/16.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//
//  控制项目中的所有的输出

#import <Foundation/Foundation.h>

@interface IZCLog : NSObject

/*
 这里用来关闭log
 */
@property(nonatomic, assign) BOOL logClosed;

+ (IZCLog *)sharedLog;

// 输出标识符
- (void)printMark;

// 输出标识符
- (void)printCustomMark:(NSString *)symbol makLength:(NSInteger)length;

// 输出当前时间(精确到毫秒）
- (void)printCurrentTime;

@end

void IZCWriteBaseLog(NSString *format, ...);
void IZCWriteFuncLog(const char *func, int lineNumber, NSString *format, ...);

#define IZCLog(format,...) IZCWriteBaseLog(format,##__VA_ARGS__)
#define IZCFunction(format,...) IZCWriteFuncLog(__FUNCTION__,__LINE__,format,##__VA_ARGS__)