//
//  UIView+LSTextField.h
//  iZichanSalary
//
//  Created by LoaforSpring on 16/5/17.
//  Copyright © 2016年 YiZhan. All rights reserved.
//

/**
 *  UIView+LSTextField.h
 */

#import <UIKit/UIKit.h>

/**
 *  为LSTextField服务，用来支持LSTextField的自动化调整View的frame
 */
@interface UIView (LSTextField)

// 用来记录UIView的OriginY
@property (nonatomic, assign) CGFloat lsOriginY;
// 是否已经设置过lsOriginY了
@property (nonatomic, assign) BOOL lsOriginYHaved;

// 对UIView扩展出来一个属性-用来记录当前这个view的originYOffset
@property (nonatomic, assign) CGFloat lsOriginYOffset;

@end