//
//  LSAlertContentView.h
//  iZichanSalary
//
//  Created by LoaforSpring on 16/5/12.
//  Copyright © 2016年 YiZhan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSAlertViewDelegate.h"

/**
 * 方便弹出一个自定义的view
 */
@interface LSAlertContentView : UIControl

@property (nonatomic, weak) id<LSAlertViewDelegate> delegate;

- (instancetype)initWithContentView:(UIView *)contentView;

/**
 *  显示
 */
- (void)show;

/**
 *  手动隐藏掉
 */
- (void)dismiss;

@end
