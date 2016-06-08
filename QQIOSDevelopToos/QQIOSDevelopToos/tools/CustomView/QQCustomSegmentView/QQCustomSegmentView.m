//
//  QQCustomSegmentView.m
//  iZichanTask
//
//  Created by quanqi on 16/5/28.
//  Copyright © 2016年 iZichan. All rights reserved.
//

#import "QQCustomSegmentView.h"
#import "QQDefine.h"
#define DefaultTitleColor DevGetColorFromHex(0x666666)
#define SelectTitleColor DevGetColorFromHex(0x2da5ff)
#define DefaultSepLineColor DevGetColorFromHex(0xdedede)
#define DefaultMarkViewColor DevGetColorFromHex(0x31a0fb)
#define DefaultMarkViewHeight 3
#define DefaultMarkViewToLeft 20
#define DefaultTitleFont 16
#define DefaultSepLineToTop 7


@interface QQCustomSegmentView ()

@property (nonatomic, assign) NSInteger itemAcount;/**< 选项卡的个数*/
@property (nonatomic, strong) NSArray *titleArray;/**< title数组*/
@property (nonatomic, strong) UIView *markView;/**< 选择后标记的view*/
@property (nonatomic, strong) NSMutableArray *titleLabelArray;/**< 标题label数组*/
@property (nonatomic, assign) NSInteger lastSelectIndex;/**< 上一次选择的index*/
@end

@implementation QQCustomSegmentView
- (void)dealloc
{
    self.titleArray = nil;
    self.markView = nil;
    self.titleLabelArray = nil;
}
//初始化
- (id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        if (!titleArray)
        {
            NSLog(@"数组为空~");
            return self;
        }
        self.titleArray = titleArray;
        self.itemAcount = titleArray.count;
        
        [self basicSeting];
        [self basicView];
    }
    return self;
}
- (void)basicSeting
{
    if (!self.titleLabelArray)
    {
        self.titleLabelArray = [NSMutableArray arrayWithCapacity:0];
    }
}
//初始化view
- (void)basicView
{
    //item宽度
    CGFloat itemWidth = CGRectGetWidth(self.frame)/self.itemAcount;
    //item高度
    CGFloat itemHeight = CGRectGetHeight(self.frame);
    
    for (NSInteger i = 0; i < self.titleArray.count; i++)
    {
        //control
        UIControl *itemControl = [[UIControl alloc] init];
        itemControl.backgroundColor = [UIColor clearColor];
        itemControl.frame  = CGRectMake(itemWidth * i, 0, itemWidth, itemHeight);
        itemControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [itemControl addTarget:self action:@selector(itemControlAction:) forControlEvents:UIControlEventTouchUpInside];
        itemControl.tag = i + 100;
        [self addSubview:itemControl];
        
        //label
        UILabel *titleLa = [[UILabel alloc] init];
        titleLa.backgroundColor = [UIColor clearColor];
        titleLa.textColor = DefaultTitleColor;
        titleLa.font = DevSystemFontOfSize(DefaultTitleFont);
        titleLa.textAlignment = NSTextAlignmentCenter;
        titleLa.frame = CGRectMake(0, 0, CGRectGetWidth(itemControl.frame), CGRectGetHeight(itemControl.frame));
        titleLa.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        titleLa.text = [self.titleArray objectAtIndex:i];
        titleLa.tag = i+1000;
        [itemControl addSubview:titleLa];
        //加入到数组
        [self.titleLabelArray addObject:titleLa];
        
        //line
        if (i < self.titleArray.count-1)
        {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = DefaultSepLineColor;
            line.frame = CGRectMake(itemWidth-1, DefaultSepLineToTop, 1, itemHeight-DefaultSepLineToTop*2);
            line.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            [itemControl addSubview:line];
        }
    }
    //底部的线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = DevGetColorFromHex(0xdddddd);
    line.frame = CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1);
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:line];
    
    //标记的view
    self.markView = [[UIView alloc] init];
    self.markView.backgroundColor = DefaultMarkViewColor;
    self.markView.frame = CGRectMake(DefaultMarkViewToLeft, itemHeight-DefaultMarkViewHeight, itemWidth-DefaultMarkViewToLeft*2, DefaultMarkViewHeight);
    [self addSubview:self.markView];

    //默认选中第一个
    self.lastSelectIndex = 0;
    [self changeItemStateWithControlTag:100];

}
//item点击事件
- (void)itemControlAction:(UIControl *)control
{
    //点击回调
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemAction:itemIndex:)])
    {
        [self.delegate itemAction:self itemIndex:control.tag-100];
    }
    //改变状态
    [self changeItemStateWithControlTag:control.tag];
}
//改变选择的item的状态
- (void)changeItemStateWithControlTag:(NSInteger)controlTag
{
    if (self.lastSelectIndex == controlTag)
    {
        NSLog(@"重选点击~");
        return;
    }
    //记录当前选择的index
    self.lastSelectIndex = controlTag;
    //title
    for (UILabel *view in self.titleLabelArray)
    {
        if ([view isKindOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel *)view;
            
            if (label.tag == controlTag-100+1000)
            {
                label.textColor = SelectTitleColor;
            }else
            {
                label.textColor = DefaultTitleColor;
            }
        }
    }
    UIControl *selectControl = (UIControl *)[self viewWithTag:controlTag];
    
    CGRect markViewFrame = self.markView.frame;
    
    [UIView animateWithDuration:0.2 animations:^
     {
         
         self.markView.frame = CGRectMake(DefaultMarkViewToLeft+(selectControl.tag-100)*CGRectGetWidth(selectControl.frame), markViewFrame.origin.y, markViewFrame.size.width, markViewFrame.size.height);
         
     } completion:^(BOOL finished)
     {
     }];
}
@end
