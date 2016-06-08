//
//  LSSegmentControl.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSSegmentControl.h"

//import "DevUIImage-Extend.h"

#import <QuartzCore/QuartzCore.h>


#define LSSegmentWidth (self.segmentsCount==0?0:(CGRectGetWidth(self.bounds)/self.segmentsCount))
#define LSSegmentHeight CGRectGetHeight(self.bounds)

#define kDevSegmentButtonBaseTag 122111

#define kDevDefaultSegmentCornerRadius 4.0f
#define kDevDefaultSegmentBorderWidth 1.0f
#define kDevDefaultSegmentButtonWidth 0.5f

@interface LSSegmentControl ()

@property(nonatomic) NSInteger segmentsCount;
@property(nonatomic, strong) NSMutableArray *segmentButtons;


@end

@implementation LSSegmentControl

- (id)initSegmentWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        [self setSegmentsWithTitles:titles];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setDefaultProperty];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setDefaultProperty];
    }
    return self;
}

- (void)setDefaultProperty
{
    self.backgroundColor = [UIColor clearColor];
    
    self.segmentButtons = [[NSMutableArray alloc] init];
    // 设置一个默认选中色
    self.selectedColor = [UIColor redColor];
    
    // 默认title
    self.titleFont = [UIFont systemFontOfSize:14];
    // 默认是0
    self.selectedSegmentIndex = 0;
    // 默认圆角
    self.segmentedControlStyle = LSSegmentedControlStyleBordered;
}

#pragma mark - Setter
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    // 调整下frame
    for (int i=0; i<[self.segmentButtons count]; i++)
    {
        UIButton *button = self.segmentButtons[i];
        button.frame = CGRectMake(i*LSSegmentWidth, 0, LSSegmentWidth, LSSegmentHeight);
    }
}

- (void)setSegmentedControlStyle:(LSSegmentedControlStyle)segmentedControlStyle
{
    NSInteger tempStyle = segmentedControlStyle;
    if (tempStyle<LSSegmentedControlStylePlain)
    {
        tempStyle = LSSegmentedControlStylePlain;
    }
    else if (segmentedControlStyle>LSSegmentedControlStyleBordered)
    {
        tempStyle =LSSegmentedControlStyleBordered;
    }
    
    if (LSSegmentedControlStyleBordered == segmentedControlStyle)
    {
        // 这里设置圆角
        self.layer.cornerRadius = kDevDefaultSegmentCornerRadius;
        self.layer.borderColor = self.selectedColor.CGColor;
        self.layer.borderWidth = kDevDefaultSegmentBorderWidth;
    }
    else if (LSSegmentedControlStylePlain == segmentedControlStyle)
    {
        self.layer.cornerRadius = 0.01f;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = kDevDefaultSegmentBorderWidth;
    }
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    _segmentedControlStyle = tempStyle;
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    if (selectedSegmentIndex != _selectedSegmentIndex)
    {
        [self selectIndex:selectedSegmentIndex];
        _selectedSegmentIndex = selectedSegmentIndex;
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    // 设置边框的颜色
    self.layer.borderColor = self.selectedColor.CGColor;
    // 更新下按钮的颜色
    for (UIButton *segmentButton in self.segmentButtons)
    {
        [segmentButton setTitleColor:self.selectedColor forState:UIControlStateNormal];
        [segmentButton setBackgroundImage:[self imageWithColor:self.selectedColor] forState:UIControlStateSelected];
        segmentButton.layer.borderColor = self.selectedColor.CGColor;
    }
}

- (void)segmentButtonClick:(UIButton *)segmentButton
{
    NSInteger clickIndex = segmentButton.tag - kDevSegmentButtonBaseTag;
    [self selectIndex:clickIndex];
}

- (void)selectIndex:(NSInteger)clickIndex
{
    BOOL canSelected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControl:willSelectedIndex:)])
    {
        canSelected = [self.delegate segmentControl:self willSelectedIndex:clickIndex];
    }
    
    if (canSelected)
    {
        if (clickIndex != self.selectedSegmentIndex)
        {
            UIButton *segmentButton = (UIButton *)[self viewWithTag:clickIndex+kDevSegmentButtonBaseTag];
            segmentButton.selected = YES;
            [(UIButton *)[self viewWithTag:self.selectedSegmentIndex+kDevSegmentButtonBaseTag] setSelected:NO];
            
            // 更新选中索引
            _selectedSegmentIndex = clickIndex;
            if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControl:didSelectedIndex:)])
            {
                [self.delegate segmentControl:self didSelectedIndex:self.selectedSegmentIndex];
            }
        }
    }
}

#pragma mark - Public Method
- (void)setSegmentsWithTitles:(NSArray *)titles
{
    if ([self.segmentButtons count]>0)
    {
        // 简单粗暴的删除
        for (UIView *subView in self.segmentButtons)
        {
            [subView removeFromSuperview];
        }
    }
    [self.segmentButtons removeAllObjects];
    // 循环创建按钮
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        segmentButton.frame = CGRectMake(idx*LSSegmentWidth, 0, LSSegmentWidth, LSSegmentHeight);
        segmentButton.tag = kDevSegmentButtonBaseTag + idx;
        [segmentButton setTitleColor:self.selectedColor forState:UIControlStateNormal];
        [segmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        segmentButton.titleLabel.font = self.titleFont;
        [segmentButton setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [segmentButton setBackgroundImage:[self imageWithColor:self.selectedColor] forState:UIControlStateSelected];
        [segmentButton setTitle:obj
                       forState:UIControlStateNormal];
        [segmentButton addTarget:self action:@selector(segmentButtonClick:)
                forControlEvents:UIControlEventTouchUpInside];
        segmentButton.selected = (idx==self.selectedSegmentIndex);
        segmentButton.layer.borderColor = self.selectedColor.CGColor;
        segmentButton.layer.borderWidth = kDevDefaultSegmentButtonWidth;
        [self addSubview:segmentButton];
        [self.segmentButtons addObject:segmentButton];
    }];
    self.segmentsCount = [titles count];
}

- (void)updateSegmentTitle:(NSString *)title index:(NSUInteger)index
{
    UIButton *segmentButton = [self viewWithTag:kDevSegmentButtonBaseTag+index];
    if (segmentButton) {
        [segmentButton setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark -
// 这里避免类的过多引用，直接放置一个冗余的方法
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
