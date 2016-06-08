//
//  IZCWebView.m
//  iClapDemo
//
//  Created by LoaforSpring on 16/4/5.
//  Copyright © 2016年 iClap. All rights reserved.
//

#import "IZCWebView.h"

@interface UIWebView ()
-(id)webView:(id)view identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource;
-(void)webView:(id)view resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource;
-(void)webView:(id)view resource:(id)resource didFailLoadingWithError:(id)error fromDataSource:(id)dataSource;
@end

@interface IZCWebView ()

@end

@implementation IZCWebView

- (void)dealloc
{
    _progressDelegate = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

- (void)cleanForDealloc
{
    [self loadHTMLString:@"" baseURL:nil];
    [self stopLoading];
    
    self.delegate = nil;
    [self removeFromSuperview];
}

-(id)webView:(id)view identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource
{
    [super webView:view identifierForInitialRequest:initialRequest fromDataSource:dataSource];
    return [NSNumber numberWithInt:(int)(self.resourceCount)++];
}

- (void)webView:(id)view resource:(id)resource didFailLoadingWithError:(id)error fromDataSource:(id)dataSource
{
    [super webView:view resource:resource didFailLoadingWithError:error fromDataSource:dataSource];
    
    self.resourceCompletedCount++;
    if ([self.progressDelegate respondsToSelector:@selector(webView:didReceiveResourceNumber:totalResources:)])
    {
        [self.progressDelegate webView:self
              didReceiveResourceNumber:self.resourceCompletedCount
                        totalResources:self.resourceCount];
    }
}

-(void)webView:(id)view resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource
{
    [super webView:view resource:resource didFinishLoadingFromDataSource:dataSource];
    self.resourceCompletedCount++;
    
    if ([self.progressDelegate respondsToSelector:@selector(webView:didReceiveResourceNumber:totalResources:)])
    {
        [self.progressDelegate webView:self
              didReceiveResourceNumber:self.resourceCompletedCount
                        totalResources:self.resourceCount];
    }
}

@end
