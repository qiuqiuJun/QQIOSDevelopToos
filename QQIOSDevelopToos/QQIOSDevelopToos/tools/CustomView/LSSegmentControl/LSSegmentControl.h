//
//  LSSegmentControl.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LSSegmentedControlStyle)
{
    LSSegmentedControlStylePlain,
    LSSegmentedControlStyleBordered,// Default
};

/**
 *  推荐的默认高度
 */
static CGFloat const kLSSegmentControlHeight = 28.0f;

@protocol LSSegmentControlDelegate;

/**
 *  自定义的SegmentControl，ios7风格
 *  支持自定义描边的颜色，默认色
 *  
 *  20160512 新增属性 - titleFont,
 *
 */
@interface LSSegmentControl : UIView

@property (nonatomic,assign) id<LSSegmentControlDelegate> delegate;

// 当前选中的索引
@property (nonatomic) NSInteger selectedSegmentIndex;
/**
 *  选中色默认为红色
 */
@property (nonatomic, strong) UIColor *selectedColor;
/**
 *  Segment标题字号
 */
@property (nonatomic, strong) UIFont  *titleFont;

// 设置风格
@property(nonatomic) LSSegmentedControlStyle segmentedControlStyle;

/**
 *  初始化SegmentControl
 *
 *  @param titles Segment上的按钮标题
 *
 *  @return 创建好的Segment
 */
- (id)initSegmentWithTitles:(NSArray *)titles;

/**
 *  这个方法用来重新设置segemnt的标题
 *  注意这里不会重置记录的Index，如果是全部重新设置，调用直接自己手动重置selectedSegmentIndex
 *
 *  @param titles 重新设置的标题
 */
- (void)setSegmentsWithTitles:(NSArray *)titles;

/**
 *  更新某一个Segment的标题 - 20160512新增方法
 *
 *  @param title 标题
 *  @param index Segment的所在位置
 */
- (void)updateSegmentTitle:(NSString *)title index:(NSUInteger)index;

@end

@protocol LSSegmentControlDelegate <NSObject>

@optional
// 是否允许选择
- (BOOL)segmentControl:(LSSegmentControl *)segmentControl willSelectedIndex:(NSInteger)selectedIndex;
//
- (void)segmentControl:(LSSegmentControl *)segmentControl didSelectedIndex:(NSInteger)selectedIndex;

@end

/**
 *  使用示例
 
LSSegmentControl *segment = [[LSSegmentControl alloc] initSegmentWithTitles:@[@"Title1", @"Title2", @"Title3"]];
segment.frame = CGRectMake(0, 0, 200, kLSSegmentControlHeight);
segment.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
[self.view addSubview:segment];
 
 */

