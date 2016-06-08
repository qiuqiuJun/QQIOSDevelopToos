//
//  LSScrollView.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/15.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  对UIScrollView扩展出点击事件的支持
 */
@protocol LSScrollViewTouchesDelegate;
@interface LSScrollView : UIScrollView

@property (nonatomic, weak) id<LSScrollViewTouchesDelegate> touchDelegate;

@end

@protocol LSScrollViewTouchesDelegate <NSObject>

/**
 *  点击事件回调
 *
 *  @param scrollView 点击的ScrollView
 */
- (void)scrollViewTouchUpInside:(LSScrollView *)scrollView;

@optional
/**
 *  点击了scrollView上的某个点---注意这里是手指摁下，还没完成点击
 *
 *  @param scrollView 点击的ScrollView
 *  @param touchPoint 点击的点
 */
- (void)scrollViewWillTouch:(LSScrollView *)scrollView touchPoint:(CGPoint)touchPoint;

@end
