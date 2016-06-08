//
//  LSTableView.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/15.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSTableViewTouchesDelegate;
@interface LSTableView : UITableView

@property (nonatomic, weak) id<LSTableViewTouchesDelegate> touchDelegate;

@end

@protocol LSTableViewTouchesDelegate <NSObject>

/**
 *  点击事件回调
 *
 *  @param tableView 点击的TableView
 */
- (void)tableViewTouchUpInside:(LSTableView *)tableView;

@optional
/**
 *  点击了tableView上的某个点---注意这里是手指摁下，还没完成点击
 *
 *  @param tableView  点击的ScrollView
 *  @param touchPoint 点击的点
 */
- (void)tableViewWillTouch:(LSTableView *)tableView touchPoint:(CGPoint)touchPoint;

@end

