//
//  UIView+LSToastView.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/14.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "UIView+LSToastView.h"

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#import "LSActivityIndicatorView.h"

static const CGFloat CSToastMaxWidth            = 0.8;      // 80% of parent view width
static const CGFloat CSToastMaxHeight           = 0.8;      // 80% of parent view height
static const CGFloat CSToastHorizontalPadding   = 30.0;//10Ô.0
static const CGFloat CSToastVerticalPadding     = 30.0;//10.0
static const CGFloat CSToastCornerRadius        = 10.0;

// 20150809
//static const CGFloat CSToastOpacity             = 0.7;

static const CGFloat CSToastFontSize            = 14.0;
static const CGFloat CSToastMaxTitleLines       = 0;
static const CGFloat CSToastMaxMessageLines     = 0;
static const CGFloat CSToastFadeDuration        = 0.1;

#define kBackGroundColour [UIColor colorWithRed:0 green:0 blue:0 alpha:.5]

// shadow appearanceÔ
static const CGFloat CSToastShadowOpacity       = 0.8;
static const CGFloat CSToastShadowRadius        = 6.0;
static const CGSize  CSToastShadowOffset        = { 4.0, 4.0 };
static const BOOL    CSToastDisplayShadow       = NO;

// display duration and position
static const CGFloat CSToastDefaultDuration     = 1.0;
static const NSString * CSToastDefaultPosition  = @"center";

// image view size
static const CGFloat CSToastImageViewWidth      = 80.0;
static const CGFloat CSToastImageViewHeight     = 80.0;

// 20150809
//static const CGFloat CSToastActivityWidth       = 100.0;
//static const CGFloat CSToastActivityHeight      = 100.0;
static const NSString * CSToastActivityDefaultPosition = @"center";
static const NSString * CSToastActivityViewKey  = @"CSToastActivityViewKey";
static const NSString * CSToastCSToastWrapperViewKey = @"CSToastWrapperViewKey";


NSString *const LSToastPositionTop = @"top";
NSString *const LSToastPositionCenter = @"center";
NSString *const LSToastPositionBottom = @"bottom";

@implementation UIView (ToastView)

- (void)makeToast:(NSString *)message
{
    [self makeToast:message duration:CSToastDefaultDuration position:CSToastDefaultPosition];
}

- (void)makeToast:(NSString *)message
         duration:(CGFloat)interval
{
    [self makeToast:message duration:interval position:CSToastDefaultPosition];
}
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position
{
    UIView *wrapperView = (UIView *)objc_getAssociatedObject(self, &CSToastCSToastWrapperViewKey);
    if (wrapperView)
    {
        [wrapperView removeFromSuperview];
        objc_setAssociatedObject(self, &CSToastCSToastWrapperViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UIView *toast = [self viewForMessage:message title:nil image:nil];
    
    toast.center = [self centerPointForPosition:position withToast:toast];
    toast.alpha = 0.0;
    [self addSubview:toast];
    
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:CSToastFadeDuration
                                               delay:interval
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              toast.alpha = 0.0;
                                          } completion:^(BOOL finished) {
                                              [toast removeFromSuperview];
                                          }];
                     }];
}

- (CGPoint)centerPointForPosition:(id)point withToast:(UIView *)toast
{
    if([point isKindOfClass:[NSString class]])
    {
        // convert string literals @"top", @"bottom", @"center", or any point wrapped in an NSValue object into a CGPoint
        if([point caseInsensitiveCompare:LSToastPositionTop] == NSOrderedSame)
        {
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + CSToastVerticalPadding);
        }
        else if([point caseInsensitiveCompare:LSToastPositionBottom] == NSOrderedSame)
        {
            return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - CSToastVerticalPadding);
        }
        else if([point caseInsensitiveCompare:LSToastPositionCenter] == NSOrderedSame)
        {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    }
    else if ([point isKindOfClass:[NSValue class]])
    {
        return [point CGPointValue];
    }
    
    return [self centerPointForPosition:CSToastDefaultPosition withToast:toast];
}

- (CGSize)getProperSize:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    CGSize textSize = CGSizeZero;
#if __IPHONE_7_0
    {
        // 计算文本的大小
        textSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                      options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制de时的附加选项
                                   attributes:@{NSFontAttributeName:font}        // 文字的属性
                                      context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    }
#else
    {
        textSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    }
#endif
    return textSize;
}


- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image
{
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;
    
    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = CSToastCornerRadius;
    objc_setAssociatedObject(self, &CSToastCSToastWrapperViewKey, wrapperView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (CSToastDisplayShadow)
    {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = CSToastShadowOpacity;
        wrapperView.layer.shadowRadius = CSToastShadowRadius;
        wrapperView.layer.shadowOffset = CSToastShadowOffset;
    }
    
    wrapperView.backgroundColor = kBackGroundColour;//[kBackGroundColour colorWithAlphaComponent:CSToastOpacity];
    
    if(image != nil)
    {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(CSToastHorizontalPadding, CSToastVerticalPadding, CSToastImageViewWidth, CSToastImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil)
    {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = CSToastHorizontalPadding;
    }
    else
    {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil)
    {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = CSToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:CSToastFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * CSToastMaxWidth) - imageWidth, self.bounds.size.height * CSToastMaxHeight);
        
        // 避免耦合
        CGSize expectedSizeTitle = [self getProperSize:title font:titleLabel.font width:maxSizeTitle.width];
        
        
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil)
    {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = CSToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:CSToastFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * CSToastMaxWidth) - imageWidth, self.bounds.size.height * CSToastMaxHeight);
        // 避免耦合
        CGSize expectedSizeMessage = [self getProperSize:message font:messageLabel.font width:maxSizeMessage.width];
        
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil)
    {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = CSToastVerticalPadding;
        titleLeft = imageLeft + imageWidth + CSToastHorizontalPadding;
    }
    else
    {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    
    if(messageLabel != nil)
    {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + CSToastHorizontalPadding;
        messageTop = titleTop + titleHeight + CSToastVerticalPadding;
    }
    else
    {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }
    
    
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (CSToastHorizontalPadding * 2)), (longerLeft + longerWidth + CSToastHorizontalPadding));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + CSToastVerticalPadding), (imageHeight + (CSToastVerticalPadding * 2)));
    
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil)
    {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil)
    {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil)
    {
        [wrapperView addSubview:imageView];
    }
    
    return wrapperView;
}

- (void)makeToastActivity
{
    [self makeToastActivityWithPosition:CSToastActivityDefaultPosition];
}


- (void)makeToastActivityWithIntercept:(BOOL)intercept
{
    [self makeToastActivity:CSToastActivityDefaultPosition intercept:intercept];
}

- (void)makeToastActivityWithPosition:(id)position
{
    [self makeToastActivity:position intercept:YES];
}
- (void)makeToastActivity:(id)position intercept:(BOOL)intercept
{
    // sanity
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &CSToastActivityViewKey);
    if (existingActivityView != nil) return;
    
    
    // 有需要添加到self上，用来拦截点击
    UIControl *interceptView = [[UIControl alloc] initWithFrame:self.bounds];
    interceptView.backgroundColor = [UIColor clearColor];
    interceptView.alpha = 0;
    interceptView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    interceptView.userInteractionEnabled = intercept;
    
    LSActivityIndicatorView *activityIndicatorView = [[LSActivityIndicatorView alloc] init];
    activityIndicatorView.tag = 147701;
    activityIndicatorView.backgroundColor = [UIColor clearColor];
    [activityIndicatorView startAnimating];
    
    // 20150809加入拦截事件视图
    objc_setAssociatedObject (self, &CSToastActivityViewKey, interceptView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [interceptView addSubview:activityIndicatorView];
    [self addSubview:interceptView];
    
    
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         interceptView.alpha = 1.0;
                     } completion:nil];
}

- (void)hideToastActivity
{
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &CSToastActivityViewKey);
    if (existingActivityView != nil) {
        [UIView animateWithDuration:CSToastFadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             existingActivityView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             
                             LSActivityIndicatorView * indicatorView = (LSActivityIndicatorView *)[existingActivityView viewWithTag:147701];
                             [indicatorView stopAnimating];
                             [indicatorView removeFromSuperview];
                             
                             [existingActivityView removeFromSuperview];
                             // 制空拦截视图
                             objc_setAssociatedObject (self, &CSToastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}

@end