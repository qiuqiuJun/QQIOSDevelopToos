//
//  LSPopupView.h
//  HLVoiceAssistant
//
//  Created by LoaforSpring on 14-4-1.
//  Copyright (c) 2014年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SHADOW_OFFSET					CGSizeMake(10, 10)
#define CONTENT_OFFSET					CGSizeMake(0, 0)
#define POPUP_ROOT_SIZE					CGSizeMake(20, 10)

/**
 *  20160601 版本修改
 *  去掉了PopupView的背景色分层显示
 *  提供自定义属性，实现自定义PopupView的样式
 */
@protocol LSPopupViewDelegate;
@interface LSPopupView : UIView
{}

@property (nonatomic, weak) id<LSPopupViewDelegate> delegate;
@property (nonatomic, strong) UIView		*contentView;

/**
 *  背景色
 *  默认[UIColor colorWithRed:69.0 / 255.0 green:76.0 / 255.0 blue:85.0 / 255.0 alpha:0.9];
 */
@property (nonatomic, strong) UIColor *popupViewColor;
/**
 *  描边颜色 
 *  默认[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
 */
@property (nonatomic, strong) UIColor *shadowColor;

/**
 * 描边的大小
 *  默认CGSizeMake(10, 10);
 */
@property (nonatomic, assign) CGSize shadowOffset;
/**
 * 内容空隙
 *  CGSizeMake(2, 2);
 */
@property (nonatomic, assign) CGSize contentOffset;
/**
 * 箭头的大小
 *  CGSizeMake(20, 10);
 */
@property (nonatomic, assign) CGSize arrowSize;
/**
 *  圆角弧度
 *  6
 */
@property (nonatomic, assign) CGFloat popupViewRadius;

/**
 * 设置OverlayView的颜色
 *  默认[UIColor clearColor]
 */
@property (nonatomic, strong) UIColor *overlayViewColor;


- (id)initWithContentView:(UIView*)newContentView contentSize:(CGSize)contentSize;

- (void)showAtPoint:(CGPoint)p inView:(UIView*)inView;
- (void)showAtPoint:(CGPoint)p inView:(UIView*)inView animated:(BOOL)animated;

- (void)dismiss;
- (void)dismiss:(BOOL)animtaed;
@end

@protocol LSPopupViewDelegate <NSObject>

- (void)popupViewDidDismiss:(LSPopupView *)popupView;

@end
