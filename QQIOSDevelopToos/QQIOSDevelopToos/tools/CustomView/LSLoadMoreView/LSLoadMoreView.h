//
//  LSLoadMoreView.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/18.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

// 默认的LoadingView的Class Name
static NSString *const kLSLoadMoreDefaultLoadingViewName = @"LSLoadMoreLoadingView";

@protocol LSLoadMoreViewDelegate;
@interface LSLoadMoreView : UIView

@property (nonatomic, weak) id<LSLoadMoreViewDelegate> delegate;

/**
 *  绑定的滚动视图
 */
@property (nonatomic, weak) UIScrollView *bindingScrollView;

/**
 *  是否使用自动加载 - 默认是自动加载的
 */
@property (nonatomic, assign) BOOL autoLoading;

/**
 *  创建一个LSLoadMoreView -  loadingView为kLSLoadMoreDefaultLoadingViewName
 *
 *  @param bindingScrollView LSLoadMoreView绑定的ScrollView
 */
+ (LSLoadMoreView *)CreateLoadMoreView:(UIScrollView *)bindingScrollView delegate:(id<LSLoadMoreViewDelegate>)delegate;

/**
 *  创建一个LSLoadMoreView 并设置一个自定义的LoadingView
 *
 *  @param bindingScrollView LSLoadMoreView绑定的ScrollView
 *  @param loadingViewName   自定义的LoadingView的ClassName
 */
+ (LSLoadMoreView *)CreateLoadMoreView:(UIScrollView *)bindingScrollView loadingViewName:(NSString *)loadingViewName delegate:(id<LSLoadMoreViewDelegate>)delegate;

/**
 *  首次记载数据 - 启动加载更多
 *  这个启动一般应该放在页面显示之后
 */
- (void)firstLoadMoreData;
 
/**
 *  设置LoadMoveView的加载是否可用
 *
 *  @param enable YES:可以继续加载更多 NO:不可用
 */
- (void)setLoadMoreViewLoadingEnable:(BOOL)enable;

#pragma mark - 主动调用，以便LoadMoreView更新状态
/**
 *  页面开始滚动了
 *
 *  @param scrollView LoadMore所在的视图
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

/**
 *  数据加载完成 - 刷新Frame
 */
- (void)dataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

@protocol LSLoadMoreViewDelegate <NSObject>

/**
 *  回调通知-开始加载数据
 */
- (void)loadMoreViewDidStartLoading:(LSLoadMoreView *)view;

/**
 *  加载数据是否是正在加载中
 *
 *  @return YES是正在请求，NO请求已经完成
 */
- (BOOL)loadMoreDataSourceIsLoading:(LSLoadMoreView *)view;

@end