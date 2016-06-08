//
//  LSCircleProgressView.h
//  iZichanSalary
//
//  Created by LoaforSpring on 16/5/9.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  名 字: 圆盘进度
 *  版 本: 1.0
 *  时 间: 2016-05-09
 */
@interface LSCircleProgressView : UIView

/**
 *  内侧圆环的宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 *  圆环的颜色
 */
@property (nonatomic, strong) UIColor *bottomColor;

/**
 *  线条的颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 *  进度
 */
@property (nonatomic, assign) CGFloat progress;

/**
 *  设置进度
 *
 *  @param progress 进度
 *  @param animated 选择是否需要动画增长
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
