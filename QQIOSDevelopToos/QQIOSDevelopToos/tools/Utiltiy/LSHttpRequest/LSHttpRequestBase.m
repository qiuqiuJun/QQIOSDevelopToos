//
//  LSHttpRequestBase.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/25.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSHttpRequestBase.h"

static NSTimeInterval const kRequestTimeoutInterval = 30;

@interface LSHttpRequestBase ()
<NSURLSessionDelegate>

/**
 *  请求配置
 
 NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
 
 // 不允许移动网络，只允许WIFI操作网络请求。
 sessionConfig.allowsCellularAccess = NO;
 
 // 只允许接受json数据
 [sessionConfig setHTTPAdditionalHeaders:@{@"Accept": @"application/json"}];

 // 设置请求的超时时间为30秒
 sessionConfig.timeoutIntervalForRequest = 30.0;

 //设置资源处理的最长时间
 sessionConfig.timeoutIntervalForResource = 60.0;
 
 //设置app对单一主机的最大的连接数
 sessionConfig.HTTPMaximumConnectionsPerHost = 1;
 */
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;

/**
 *  会话
 */
@property (nonatomic, strong) NSURLSession *session;

/**
 *  数据请求
 */
@property (nonatomic, strong) NSURLSessionDataTask *postDataTask;

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation LSHttpRequestBase

- (void)dealloc
{
    [self requestCancel];
}

- (id)initWithDelegate:(id<LSHttpRequestDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        self.wifiOnly = NO;
    }
    return self;
}

- (NSURLSessionConfiguration *)sessionConfiguration
{
    if (nil == _sessionConfiguration) {
        //会话配置，这里配置为短暂配置，还有默认配置和后台配置
        _sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        _sessionConfiguration.timeoutIntervalForRequest = kRequestTimeoutInterval;
    }
    return _sessionConfiguration;
}

#pragma mark LSHttpRequestProtocol
- (NSString *)getUserAgent
{
    NSDictionary *infoDict     = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier = infoDict[(NSString *)kCFBundleIdentifierKey]; /**< 包名*/
    NSString *bundleVersion    = infoDict[(NSString *)kCFBundleVersionKey];/**< 版本号*/
    NSString *userAgent        = [NSString stringWithFormat:@"%@-%@;", bundleIdentifier, bundleVersion];
    return userAgent;
}

- (NSMutableDictionary *)getHTTPAdditionalHeaders
{
    NSMutableDictionary *httpHeaders = [NSMutableDictionary dictionary];
    httpHeaders[@"User-Agent"] = [self getUserAgent];
    httpHeaders[@"Content-Type"] = @"application/x-www-form-urlencoded;charset=utf-8";
    return httpHeaders;
}

- (NSMutableDictionary *)getRequestParamsWith:(NSDictionary*)params
{
    NSMutableDictionary *paramsDic = nil;
    if (params)
    {
        paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    }
    else
    {
        paramsDic = [NSMutableDictionary dictionary];
    }
    
//    paramsDic[@"test"] = @"value";
    
    return paramsDic;
}

#pragma mark Request Init
- (void)setURLString:(NSString *)urlString params:(NSDictionary *)params
{
    // utf-8编码
    NSString *utf8UrlString = [[NSString stringWithFormat:@"%@", urlString]
                           stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 配置URL
    NSURL *url = [NSURL URLWithString:utf8UrlString];
    
    // 配置请求头 -- @"Content-Type":@"application/json"
    [self.sessionConfiguration setHTTPAdditionalHeaders:[self getHTTPAdditionalHeaders]];
    
    if (self.wifiOnly) {
        // 不允许移动网络，只允许WIFI操作网络请求。
        self.sessionConfiguration.allowsCellularAccess = NO;
    }
    
    NSDictionary *paramsDic = [self getRequestParamsWith:params];
    
    NSMutableString *postString = [NSMutableString string];
    if (paramsDic != nil)
    {
        NSArray *allkeys = [paramsDic allKeys];
        for (int i=0; i<[allkeys count]; i++)
        {
            NSString *value = [NSString stringWithFormat:@"%@",paramsDic[allkeys[i]]];
            
            [postString appendFormat:@"%@=%@", allkeys[i], value];
            if (i != [allkeys count]-1)
            {
                [postString appendFormat:@"&"];
            }
        }
    }
    
    NSLog(@"url=====%@?%@", urlString, postString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    /*
     // 这种编码方式和NSUTF8StringEncoding结果一样，记录一下有时间研究下他们的区别
     [postString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
     */
    request.HTTPBody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    // 创建会话对象
    self.session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    // 根据会话对象创建一个Task(发送请求）
    self.postDataTask = [self.session dataTaskWithRequest:request];
    
    // 初始化会话 -- 方法2
//    self.session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration];
//    self.postDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        // The server answers with an error because it doesn't receive the params
//    }];
}

- (void)setRequestTimeoutInterval:(NSTimeInterval)interval
{
    self.sessionConfiguration.timeoutIntervalForRequest = interval;
}

- (void)requestStart
{
    //启动任务
    [self.postDataTask resume];
}
- (void)requestSuspend
{
    [self.postDataTask suspend];
}

- (void)requestCancel
{
    if (self.session) {
        [self.session invalidateAndCancel];
    }
    self.session = nil;
    
    if (self.postDataTask) {
        [self.postDataTask cancel];
    }
    
    self.postDataTask = nil;
}

#pragma mark NSOperation
- (void)main
{
    // 经过线程队列启动的请求，外部不需要再调用requestStart
    if (self.postDataTask) {
        [self.postDataTask resume];
    }
    // 因为RequestBegin启动的较晚，所以这里手动赋值一个YES
    self.requesting = YES;
    while (self.requesting)
    {
        [NSThread sleepForTimeInterval:0.05];
    }
}

#pragma mark NSURLSessionDataDelegate
//1.接收到服务器响应的时候调用该方法
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    //在该方法中可以得到响应头信息，即response
    NSLog(@"didReceiveResponse--%@", [NSThread currentThread]);
    
    //注意：需要使用completionHandler回调告诉系统应该如何处理服务器返回的数据
    //默认是取消的
    /*
     NSURLSessionResponseCancel = 0,        默认的处理方式，取消
     NSURLSessionResponseAllow = 1,         接收服务器返回的数据
     NSURLSessionResponseBecomeDownload = 2,变成一个下载请求
     NSURLSessionResponseBecomeStream        变成一个流
     */
    
    completionHandler(NSURLSessionResponseAllow);
    self.responseData = [NSMutableData data];
    [self requestBegin];
}

//2.接收到服务器返回数据的时候会调用该方法，如果数据较大那么该方法可能会调用多次
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //拼接服务器返回的数据
    [self.responseData appendData:data];
}

//3.当请求完成(成功|失败)的时候会调用该方法，如果请求失败，则error有值
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {// 请求成功
        //解析数据,JSON解析请参考http://www.cnblogs.com/wendingding/p/3815303.html
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:nil];
        
        NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
        NSLog(@"request complete \n result:\n%@", responseString);
        // 检查是否有拦截方法
        if ([self respondsToSelector:@selector(checkResponseShouldInterceptWith:)]) {
            if ([self checkResponseShouldInterceptWith:dict]) {
                // 操作被拦截了，不再继续往下执行，由对应拦截方法执行相关逻辑
                self.requesting = NO;
                return;
            }
        }
        // 没有检查到数据拦截，正常回调。
        [self requestComplete:dict];
    }
    else
    {// 请求失败
        [self requestError:error];
    }
}

- (BOOL)checkResponseShouldInterceptWith:(NSDictionary *)responseDict
{
    if (nil == responseDict) {
        [self sendRequestErrorWithDesc:@"服务器返回数据异常" errorCode:-1000];
        return YES;
    }
    return NO;
}

- (void)sendRequestErrorWithDesc:(NSString *)errorDesc errorCode:(NSInteger)errorCode
{
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errorDesc};
    NSError *error = [NSError errorWithDomain:@"com.error" code:errorCode userInfo:userInfo];
    [self requestError:error];
}

#pragma mrak LSHttpRequestDelegate
- (void)requestBegin
{
    self.requesting = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(httpRequestBegin:)]) {
        [self.delegate httpRequestBegin:self];
    }
}
- (void)requestComplete:(NSDictionary *)responseDict
{
    self.requesting = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(httpRequest:requestFinish:)]) {
        [self.delegate httpRequest:self requestFinish:responseDict];
    }
}
- (void)requestError:(NSError *)error
{
    NSLog(@"%s : %@", __func__, [error description]);
    self.requesting = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(httpRequest:requestError:)]) {
        [self.delegate httpRequest:self requestError:error];
    }
}

@end
