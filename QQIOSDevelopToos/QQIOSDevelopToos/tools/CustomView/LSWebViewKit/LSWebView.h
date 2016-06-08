//
//  LSWebView.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/14.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSWebViewProgressDelegate;
@interface LSWebView : UIWebView

@property (nonatomic) NSInteger resourceCount;
@property (nonatomic) NSInteger resourceCompletedCount;
@property (nonatomic, weak) id<LSWebViewProgressDelegate> progressDelegate;

- (void) cleanForDealloc;

@end


@protocol LSWebViewProgressDelegate <NSObject>

@optional
- (void) webView:(LSWebView*)webView didReceiveResourceNumber:(NSInteger)resourceNumber totalResources:(NSInteger)totalResources;

@end
