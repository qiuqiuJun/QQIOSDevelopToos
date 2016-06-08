//
//  LSFactory.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/15.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSFactory.h"

#import "LSStringKit.h"

@implementation LSFactory

#pragma mark - UIButton
+ (UIButton *)getImageButtonWithFrame:(CGRect)frame imageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    return [LSFactory getImageButtonWithFrame:frame imageName:imageName highlightedImage:nil target:target action:action];
}
+ (UIButton *)getImageButtonWithFrame:(CGRect)frame imageName:(NSString *)imageName highlightedImage:(NSString *)highlightedImageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (highlightedImageName) {
        [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateNormal];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (UIButton *)getTitleButtonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)titleFont titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - UIImageView
+ (UIImageView *)getImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

#pragma mark - UILabel
+ (UILabel *)getLabelWithFrame:(CGRect)labelRect textFont:(UIFont*)textFont textColor:(UIColor*)textColor text:(NSString *)text
{
    return [LSFactory getLabelWithFrame:labelRect textFont:textFont textColor:textColor textAlignment:NSTextAlignmentLeft text:text];
}

+ (UILabel *)getLabelWithFrame:(CGRect)labelRect textFont:(UIFont*)textFont textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = textFont;
    label.text = text;
    return label;
}

+ (UILabel *)getNoLimitLabelWithWidth:(CGFloat)limitWidth originPoint:(CGPoint)originPoint textFont:(UIFont*)textFont textColor:(UIColor*)textColor text:(NSString *)text
{
    CGSize properSize = [LSStringKit GetStringProperSize:text font:textFont width:limitWidth];
    
    UILabel *label = [LSFactory getLabelWithFrame:CGRectMake(originPoint.x, originPoint.y, limitWidth, properSize.height) textFont:textFont textColor:textColor text:text];
    label.numberOfLines = 0;
    return label;
}

#pragma mark - UITextField
+ (UITextField *)getTextFieldWithFrame:(CGRect)tfFrame placeholder:(NSString *)placeholder font:(UIFont *)font textColor:(UIColor *)textColor
{
    return [LSFactory getTextFieldWithFrame:tfFrame placeholder:placeholder font:font textColor:textColor keyboardType:UIKeyboardTypeDefault returnType:UIReturnKeyDefault delegate:nil];
}
+ (UITextField *)getTextFieldWithFrame:(CGRect)tfFrame placeholder:(NSString *)placeholder font:(UIFont *)font textColor:(UIColor *)textColor keyboardType:(UIKeyboardType)keyboardType returnType:(UIReturnKeyType)returnType delegate:(id<UITextFieldDelegate>)delegate
{
    UITextField *textField = [[UITextField alloc] initWithFrame:tfFrame];
    textField.delegate = delegate;
    textField.placeholder = placeholder;
    textField.font = font;
    if (textColor) {
        textField.textColor = textColor;
    }
    textField.keyboardType = keyboardType;
    textField.returnKeyType = returnType;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}
+ (id)getCustomTextFieldWith:(NSString *)customTFName frame:(CGRect)tfFrame placeholder:(NSString *)placeholder font:(UIFont *)font keyboardType:(UIKeyboardType)keyboardType returnType:(UIReturnKeyType)returnType delegate:(id<UITextFieldDelegate>)delegate
{
    Class tfClass = NSClassFromString(customTFName);
    UITextField *textField = nil;
    if (tfClass) {
        textField = [[tfClass alloc] initWithFrame:tfFrame];
        textField.delegate = delegate;
        textField.placeholder = placeholder;
        textField.font = font;
        textField.keyboardType = keyboardType;
        textField.returnKeyType = returnType;
    }
    
    return textField;
}

#pragma mark - UITableView
+ (void)setTableView:(UITableView **)tableView frame:(CGRect)frame delegate:(id)delegate separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle needAutoresizing:(BOOL)needAutoresizing
{
    UITableView *tempTableView = *tableView;
    tempTableView.frame = frame;
    tempTableView.delegate = delegate;
    tempTableView.dataSource = delegate;
    tempTableView.separatorStyle = separatorStyle;
    if (needAutoresizing) {
        tempTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
}

@end
