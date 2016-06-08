//
//  IZCJsonKit.m
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/16.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import "IZCJsonKit.h"
#import <UIKit/UIKit.h>
#import "QQDefine.h"
#import "IZCLog.h"

//@implementation IZCJsonKit
/*
 -(void) parseJsonData:(NSData *)data
 {
 NSError *error;
 NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
 if (json == nil) {
 IZCLog(@"json parse failed \r\n");
 return;
 }
 NSArray *songArray = [json objectForKey:@"song"];
 IZCLog(@"song collection: %@\r\n",songArray);
 
 _song = songArray;
 self.songIndex = 0;
 NSDictionary *song = [songArray objectAtIndex:0];
 IZCLog(@"song info: %@\t\n",song);
 }
 
 
 Foundation对象转换为json数据
 NSDictionary *song = [NSDictionary dictionaryWithObjectsAndKeys:@"i can fly",@"title",@"4012",@"length",@"Tom",@"Singer", nil];
 if ([NSJSONSerialization isValidJSONObject:song])
 {
 NSError *error;
 NSData *jsonData = [NSJSONSerialization dataWithJSONObject:song options:NSJSONWritingPrettyPrinted error:&error];
 NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 IZCLog(@"json data:%@",json);
 }
 */


//static IZCJsonKit *sharedInstance;
//static dispatch_once_t pred = 0;

// 创建这个单例对象
//+ (IZCJsonKit *)sharedInstance
//{
//    dispatch_once(&pred, ^{
//        sharedInstance = [[self alloc] init];
//    });
//
//    return sharedInstance;
//}
//
//// 释放
//+ (void)releaseInstance
//{
//    pred = 0 ;
//    sharedInstance = nil;
//}
//
//
//@end


@implementation NSObject (IZCJsonKit)

- (id)objectFromJsonData:(NSData *)jsonData
{
    NSCParameterAssert(jsonData);
    if (Dev_IOS_5_0)
    {
        NSError *error;
        id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:kNilOptions
                                                      error:&error];
        if (object == nil) {
            IZCLog(@"%s json parse failed !!!", __func__);
            return nil;
        }
        return object;
    }
    IZCLog(@"5.0以下不能使用这个方法:%s", __func__);
    return nil;
}
- (id)objectFromJsonString:(NSString *)jsonString
{
    NSCParameterAssert(jsonString);
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [self objectFromJsonData:jsonData];
}
- (NSData *)jsonDataFromObject:(id)obj
{
    NSCParameterAssert(obj);
    if (Dev_IOS_5_0)
    {
        if ([NSJSONSerialization isValidJSONObject:obj])
        {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:&error];
            if (error != nil)
            {
                IZCLog(@"");
            }
            return jsonData;
        }
        return nil;
    }
    IZCLog(@"5.0以下不能使用这个方法:%s", __func__);
    return nil;
}
- (NSString *)jsonStringFromObject:(id)obj
{
    NSData *jsonData = [self jsonDataFromObject:obj];
    if (nil != jsonData) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return nil;
}
@end

@implementation NSData (IZCJsonKit)
- (id)objectFromJSONData
{
    return [self jsonDataFromObject:self];
}
@end

@implementation NSString (IZCJsonKit)
- (id)objectFromJSONString
{
    return [self objectFromJsonString:self];
}
@end

@implementation NSArray (IZCJsonKit)
- (NSData *)JSONData
{
    return [self jsonDataFromObject:self];
}
- (NSString *)JSONString
{
    return [self jsonStringFromObject:self];
}
@end

@implementation NSDictionary (IZCJsonKit)
- (NSData *)JSONData
{
    return [self jsonDataFromObject:self];
}
- (NSString *)JSONString
{
    return [self jsonStringFromObject:self];
}

@end

