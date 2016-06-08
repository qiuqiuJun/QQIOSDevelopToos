//
//  LSLoadMoreLoadingProtocol.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/18.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#ifndef LSLoadMoreLoadingProtocol_h
#define LSLoadMoreLoadingProtocol_h

static CGFloat const kLSLoadMoreViewHeight = 44.0f;

/**
 *  当自定义一个LoadingView时按照协议实现下面三个方法
 *  注:初始化方法应该使用init
 *  LoadingView的高度限制为44像素
 */
@protocol LSLoadMoreLoadingProtocol <NSObject>

/**
 *  可以加载更多了 - tips:释放开始加载
 *  对应状态 -> LSLoadMorePulling
 *  当前都是自动加载，这个方法目前可以先不写内容
 */
- (void)readyLoading;

/**
 *  开始加载数据  - tips:数据加载中...
 *  对应状态 -> LSLoadMoreLoading
 */
- (void)startLoading;

/**
 *  结束加载数据  - tips:上拉加载更多
 *  对应状态 -> LSLoadMoreNormal
 */
- (void)stopLoading;

@end

#endif /* LSLoadMoreLoadingProtocol_h */
