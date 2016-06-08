//
//  LSTextField.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/15.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 自定义的输入框，自带键盘监听
 * 增加LSTextFieldKeyboardDelegate，对键盘的变化进行回调
 * 当前版本: 1.0
 */
@protocol LSTextFieldKeyboardDelegate;
@interface LSTextField : UITextField

/**
 *  代替原有的delegate
 */
@property (nonatomic, weak) id<LSTextFieldKeyboardDelegate> keyboardDelegate;

/**
 *  绑定视图
 *  当你设置这个bindingView之后，LSTextField会自动判断是否被键盘覆盖，并调整bindView的frame
 *  bindingView一般都应设置为视图控制器的self.view，当TextField在UIScrollView和UITableView上的时候也可以设置为这些大容器
 *  即：当存在一个和self.view等大小，并且是LSTextField的直接或者间接SuperView，应设置为这个View
 */
@property (nonatomic, weak) UIView *bindingView;

@end


@protocol LSTextFieldKeyboardDelegate <NSObject>

@optional
/**
 *  当键盘出现/消失/大小改变的时候回调
 *
 *  @param height   键盘的目标高度
 *  @param duration 键盘的动画时间
 */
- (void)keyboardChangeHeight:(CGFloat)height withDuration:(NSTimeInterval)duration;

@end

