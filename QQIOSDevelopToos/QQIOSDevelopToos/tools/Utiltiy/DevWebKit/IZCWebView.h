//
//  IZCWebView.h
//  iClapDemo
//
//  Created by LoaforSpring on 16/4/5.
//  Copyright © 2016年 iClap. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IZCWebViewProgressDelegate;
@interface IZCWebView : UIWebView

@property (nonatomic) NSInteger resourceCount;
@property (nonatomic) NSInteger resourceCompletedCount;
@property (nonatomic, weak) id<IZCWebViewProgressDelegate> progressDelegate;
- (void) cleanForDealloc;

@end


@protocol IZCWebViewProgressDelegate <NSObject>

@optional
- (void) webView:(IZCWebView*)webView didReceiveResourceNumber:(NSInteger)resourceNumber totalResources:(NSInteger)totalResources;

@end