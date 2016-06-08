//
//  LSFactory.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/15.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UI工厂，快速创建UI
 *  灵感源自于每次代码创建UI都要写很多重复的alloc,init,属性设置
 *  使用时，需要先导入LSStringKit
 */
@interface LSFactory : UIView

#pragma mark - UIButton
/**
 *  获取一个图片按钮
 */
+ (UIButton *)getImageButtonWithFrame:(CGRect)frame imageName:(NSString *)imageName target:(id)target action:(SEL)action;
+ (UIButton *)getImageButtonWithFrame:(CGRect)frame imageName:(NSString *)imageName highlightedImage:(NSString *)highlightedImageName target:(id)target action:(SEL)action;
/**
 *  获取一个文字按钮
 */
+ (UIButton *)getTitleButtonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)titleFont titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;

#pragma mark - UIImageView
+ (UIImageView *)getImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;

#pragma mark - UILabel
+ (UILabel *)getLabelWithFrame:(CGRect)labelFrame textFont:(UIFont*)textFont textColor:(UIColor*)textColor text:(NSString *)text;
+ (UILabel *)getLabelWithFrame:(CGRect)labelFrame textFont:(UIFont*)textFont textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text;
/**
 *  获取一个自动换行的label
 */
+ (UILabel *)getNoLimitLabelWithWidth:(CGFloat)limitWidth originPoint:(CGPoint)originPoint textFont:(UIFont*)textFont textColor:(UIColor*)textColor text:(NSString *)text;

#pragma mark - UITextField
+ (UITextField *)getTextFieldWithFrame:(CGRect)tfFrame placeholder:(NSString *)placeholder font:(UIFont *)font textColor:(UIColor *)textColor;
/**
 *  获取一个UITextField，快速设置UIKeyboardType,UIReturnKeyType
 */
+ (UITextField *)getTextFieldWithFrame:(CGRect)tfFrame placeholder:(NSString *)placeholder font:(UIFont *)font textColor:(UIColor *)textColor keyboardType:(UIKeyboardType)keyboardType returnType:(UIReturnKeyType)returnType delegate:(id<UITextFieldDelegate>)delegate;
/**
 *  获取一个自定义的TextField的方法 -- 这个只是个想法，未完成
 */
+ (id)getCustomTextFieldWith:(NSString *)customTFName frame:(CGRect)tfFrame placeholder:(NSString *)placeholder font:(UIFont *)font keyboardType:(UIKeyboardType)keyboardType returnType:(UIReturnKeyType)returnType delegate:(id<UITextFieldDelegate>)delegate;

#pragma mark - UITableView
+ (void)setTableView:(UITableView **)tableView frame:(CGRect)frame delegate:(id)delegate separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle needAutoresizing:(BOOL)needAutoresizing;

@end
