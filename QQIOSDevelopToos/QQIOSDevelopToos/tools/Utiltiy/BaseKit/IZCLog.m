//
//  IZCLog.m
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/16.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import "IZCLog.h"

static IZCLog *sharedInstance = nil;

@implementation IZCLog

+ (IZCLog *)sharedLog
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

// 输出标识符
- (void)printMark
{
    [self printCustomMark:@"!@" makLength:20];
}

- (void)printCustomMark:(NSString *)symbol makLength:(NSInteger)length
{
    NSMutableString *logMark = [[NSMutableString alloc] initWithCapacity:length];
    for (NSInteger i=0; i<length; i++) {
        [logMark appendString:symbol];
    }
    IZCLog(logMark);
}

- (void)printCurrentTime
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    NSString *timeNow = [formatter stringFromDate:[NSDate date]];
    IZCLog(@"%@", timeNow);
}

@end

void IZCWriteBaseLog(NSString *format, ...)
{
    #ifdef DEBUG
        va_list args;
        va_start(args, format);
        NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
        
        NSLog(@"%@", string);
    #else
    
    #endif
}

void IZCWriteFuncLog(const char *func, int lineNumber, NSString *format, ...)
{
    #ifdef DEBUG
        va_list args;
        va_start(args, format);
        NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
        
        NSString *logFormat = [NSString stringWithFormat:@"%@%s, %@%i, ---\n %@%@",@"Function: ", func,@"Line: ",lineNumber, @": ",string];
        
        NSString * strModelName = @"IZCLog"; //模块名
        
        NSLog(@"%@: %@", strModelName, logFormat);
    #else
    
    #endif
}




