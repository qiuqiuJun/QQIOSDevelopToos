//
//  LSRequestManager.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/25.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSRequestManager.h"

static NSUInteger const kMaxConcurrentOperationCount = 5;

@interface LSRequestManager ()

@property (nonatomic, strong) NSOperationQueue *requestQueue;
@property (nonatomic, assign) BOOL wifiOnly;

@end

@implementation LSRequestManager

+ (LSRequestManager *)requestManager
{
    static LSRequestManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LSRequestManager alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.requestQueue = [[NSOperationQueue alloc] init];
        [self.requestQueue setMaxConcurrentOperationCount:kMaxConcurrentOperationCount];
        self.wifiOnly = NO;
    }
    return self;
}

- (void)setRequestOnlyWifi:(BOOL)onlyWifi
{
    self.wifiOnly = onlyWifi;
}

#pragma mark Create Request
- (id<LSHttpRequestProtocol>)startHttpRequestWith:(NSString *)url params:(NSDictionary *)params delegate:(id<LSHttpRequestDelegate>)delegate identifier:(NSString *)identifier
{
    LSHttpRequestBase *request = [[LSHttpRequestBase alloc] initWithDelegate:delegate];
    request.wifiOnly = self.wifiOnly;
    if (identifier) {
        request.identifier = identifier;
    }
    [request setURLString:url
                   params:params];
    
    [self.requestQueue addOperation:request];
    return request;
}

- (id<LSHttpRequestProtocol>)startCustomRequestWith:(NSString *)className url:(NSString *)url params:(NSDictionary *)params delegate:(id<LSHttpRequestDelegate>)delegate identifier:(NSString *)identifier
{
    Class RequestClass = nil;
    
    if (className) {
        // 自定义了loadingView
        RequestClass = NSClassFromString(className);
    } else {
        // 使用默认的LoadingView
        RequestClass = NSClassFromString(@"LSHttpRequestBase");
    }
    
    if (RequestClass) {
        id request = [[RequestClass alloc] init];
        
        if ([request isKindOfClass:[LSHttpRequestBase class]]) {
            [request setDelegate:delegate];
            [request setWifiOnly:self.wifiOnly];
            if (identifier) {
                [request setIdentifier:identifier];
            }
            [request setURLString:url
                           params:params];
            
            [self.requestQueue addOperation:request];
             return request;
        }
    }
    return nil;
}

#pragma mark Request Operation
- (void)cancelRequestWithDelegate:(id<LSHttpRequestDelegate>)delegate
{
    @synchronized (self.requestQueue)
    {
        for (LSHttpRequestBase *request in self.requestQueue.operations)
        {
            if (delegate == request.delegate)
            {
                // 取消这个请求
                [request requestCancel];
            }
        }
    }
}
- (void)cancelRequestWithIdentifier:(NSString *)identifier
{
    @synchronized (self.requestQueue)
    {
        for (LSHttpRequestBase *request in self.requestQueue.operations)
        {
            if ([identifier isEqualToString:request.identifier])
            {
                // 取消这个请求
                [request requestCancel];
            }
        }
    }
}
- (void)cancelAllRequest
{
    [self.requestQueue cancelAllOperations];
}

@end
