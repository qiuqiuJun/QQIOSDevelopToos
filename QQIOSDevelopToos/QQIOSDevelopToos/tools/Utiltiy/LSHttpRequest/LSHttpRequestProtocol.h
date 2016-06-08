//
//  LSHttpRequestProtocol.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/25.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#ifndef LSHttpRequestProtocol_h
#define LSHttpRequestProtocol_h

#import <Foundation/Foundation.h>

@protocol LSHttpRequestProtocol <NSObject>

@optional
/**
 *  用来自定义UserAgent
 *  如果需要特殊的UserAgent，可以继承该方法[super getUserAgent]之后添加自己需要的参数
 *
 *  @return 默认UserAget格式是"包名-版本号"
 */
- (NSString *)getUserAgent;

/**
 *  用来自定义Http Header
 *
 *  @return 默认的Header @"User-Agent":[self getUserAgent] @"Content-Type":@"application/x-www-form-urlencoded;charset=utf-8"
 */
- (NSMutableDictionary *)getHTTPAdditionalHeaders;

/**
 *  用来获取参数 - 实现此方法进行一些默认参数的增加
 *
 *  @param params 用户设置的参数
 *
 *  @return 一个完整的参数
 */
- (NSMutableDictionary *)getRequestParamsWith:(NSDictionary*)params;
/*
 // 先super拿到Base类的参数数组
 NSMutableDictionary *paramsDic = [super getRequestParamsWith:params];
 // 这里是你可以新加参数
 paramsDic[@"paraName"] = @"value";
 */

/**
 *  这是一个拦截方法 - 自定义Request主要针对该方法对返回数据进行处理
 *  对返回数据进行检查，判断是否进行拦截 - 需要对返回数据进行处理的，实现这个方法
 *
 *  @param responseDict 返回的数据
 *
 *  @return YES-需要拦截下来，不允许正常返回，，，NO-正常返回
 */
- (BOOL)checkResponseShouldInterceptWith:(NSDictionary *)responseDict;

/**
 *  请求完成
 *
 *  @param responseDict 返回结果
 */
- (void)requestComplete:(NSDictionary *)responseDict;

/**
 *  请求失败
 *
 *  @param error 失败信息
 */
- (void)requestError:(NSError *)error;

@end

#endif /* LSHttpRequestProtocol_h */
