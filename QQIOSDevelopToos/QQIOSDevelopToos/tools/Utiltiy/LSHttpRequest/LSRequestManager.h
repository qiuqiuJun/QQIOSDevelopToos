//
//  LSRequestManager.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/25.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSHttpRequestBase.h"

@interface LSRequestManager : NSObject

/**
 *  可同时进行的下载个数
 */
@property (nonatomic, assign) NSInteger maxConcurrentRequest;

/**
 *  获取RequestManager
 */
+ (LSRequestManager *)requestManager;

/**
 *  设置请求是否只允许在wifi下请求 - 这个是全局设置，默认为NO
 *
 *  @param onlyWifi YES:只能wifi NO:wifi/移动网络都可以
 */
- (void)setRequestOnlyWifi:(BOOL)onlyWifi;

/**
 *  启动一个Request请求
 *
 *  @param url      请求地址
 *  @param params   请求参数
 *  @param delegate 回调对象
 *
 *  @return 返回这个Request对象
 */
- (id<LSHttpRequestProtocol>)startHttpRequestWith:(NSString *)url params:(NSDictionary *)params delegate:(id<LSHttpRequestDelegate>)delegate identifier:(NSString *)identifier;

/**
 *  启动一个自定义的请求
 *
 *  @param className 自定义的Class的名字
 *  @param url       请求地址
 *  @param params    请求参数
 *  @param delegate  回调对象
 *
 *  @return 返回这个Request对象
 */
- (id<LSHttpRequestProtocol>)startCustomRequestWith:(NSString *)className url:(NSString *)url params:(NSDictionary *)params delegate:(id<LSHttpRequestDelegate>)delegate identifier:(NSString *)identifier;

/**
 *  取消一个下载
 */
- (void)cancelRequestWithDelegate:(id<LSHttpRequestDelegate>)delegate;
- (void)cancelRequestWithIdentifier:(NSString *)identifier;

/**
 *  取消全部的下载
 */
- (void)cancelAllRequest;

@end
