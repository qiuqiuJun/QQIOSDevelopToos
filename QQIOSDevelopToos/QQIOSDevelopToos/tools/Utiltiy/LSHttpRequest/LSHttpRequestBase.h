//
//  LSHttpRequestBase.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/25.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LSHttpRequestProtocol.h"

@protocol LSHttpRequestDelegate;
/**
 *  http请求类，可以单独发起请求，单独发起请求时，需手动调用requestStart方法
 *  推荐使用LSRequestManager来启动请求
 */
@interface LSHttpRequestBase : NSOperation
<LSHttpRequestProtocol>

@property (nonatomic, weak) id<LSHttpRequestDelegate> delegate;
/**
 *  是否正在请求
 */
@property (nonatomic, assign) BOOL requesting;

/**
 *  请求标始-默认为nil
 */
@property (nonatomic, strong) NSString *identifier;

/**
 *  是否只能在wifi下请求数据
 */
@property (nonatomic, assign) BOOL wifiOnly;

/**
 *  初始化一个request并且设置一个Delegate
 */
- (id)initWithDelegate:(id<LSHttpRequestDelegate>)delegate;

/**
 *  设置请求地址和参数
 *
 *  @param urlString 请求地址
 *  @param params    参数
 */
- (void)setURLString:(NSString *)urlString params:(NSDictionary *)params;

/**
 *  设置请求超时时间 -- 默认30秒
 *
 *  @param interval 超时时间
 */
- (void)setRequestTimeoutInterval:(NSTimeInterval)interval;

/**
 *  启动
 */
- (void)requestStart;
/**
 *  暂停
 */
- (void)requestSuspend;
/**
 *  取消
 */
- (void)requestCancel;

/**
 *  请求异常使用该方法进行异常通知
 *
 *  @param errorDesc 错误描述
 *  @param errorCode 错误码
 */
- (void)sendRequestErrorWithDesc:(NSString *)errorDesc errorCode:(NSInteger)errorCode;

@end


@protocol LSHttpRequestDelegate <NSObject>

@optional
/**
 *  请求开始
 *
 *  @param request <#request description#>
 */
- (void)httpRequestBegin:(id<LSHttpRequestProtocol>)request;
/**
 *  请求结束
 *
 *  @param request      <#request description#>
 *  @param responseDict <#responseDict description#>
 */
- (void)httpRequest:(id<LSHttpRequestProtocol>)request requestFinish:(NSDictionary *)responseDict;

- (void)httpRequest:(id<LSHttpRequestProtocol>)request requestError:(NSError *)error;

@end


/**
 
 今天更新了Xcode 7 正式版,App编译出现很多警告,在App运行的时候出现如下的提示.........
 
 the resource could not be loaded because the app transport security policy requires the use of a secure connection
 
 资源不能被加载，因为该应用程序传输的安全策略要求使用安全连接
 

 iOS9引入了新特性App Transport Security (ATS)。详情：App Transport Security (ATS)
 
 新特性要求App内访问的网络必须使用HTTPS协议。意思是Api接口以后必须是HTTPS
 但是现在公司的项目使用的是HTTP协议，使用私有加密方式保证数据安全。现在也不能马上改成HTTPS协议传输。
 
 暂时解决办法:
 
 在Info.plist中添加NSAppTransportSecurity类型Dictionary。
 在NSAppTransportSecurity下添加NSAllowsArbitraryLoads类型Boolean,值设为YES
 
 */

