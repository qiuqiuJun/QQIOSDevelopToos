//
//  QQCustomSegmentView.h
//  iZichanTask
//  自定义segment
//  Created by quanqi on 16/5/28.
//  Copyright © 2016年 iZichan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQCustomSegmentViewDelegate;

@interface QQCustomSegmentView : UIView

@property (nonatomic, weak) id<QQCustomSegmentViewDelegate>delegate;/**< */
//初始化
- (id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;
@end

@protocol QQCustomSegmentViewDelegate <NSObject>

@optional

- (void)itemAction:(QQCustomSegmentView *)segment itemIndex:(NSInteger)index;

@end