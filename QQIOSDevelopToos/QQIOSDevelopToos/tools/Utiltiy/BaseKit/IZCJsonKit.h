//
//  IZCJsonKit.h
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/16.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//
//  基于系统的Json解析 5.0以上可用

#import <Foundation/Foundation.h>

//@interface IZCJsonKit : NSObject
//// 创建这个单例对象
//+ (id)sharedInstance;
//
//// 释放
//+ (void)releaseInstance;
//@end


@interface NSData (IZCJsonKit)
- (id)objectFromJSONData;
@end


@interface NSString (IZCJsonKit)
- (id)objectFromJSONString;
@end


@interface NSArray (IZCJsonKit)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end


@interface NSDictionary (IZCJsonKit)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end


@interface NSObject (IZCJsonKit)

// 这里的方法不要调用
- (id)objectFromJsonData:(NSData *)jsonData;
- (id)objectFromJsonString:(NSString *)jsonString;
- (NSData *)jsonDataFromObject:(id)obj;
- (NSString *)jsonStringFromObject:(id)obj;

@end
