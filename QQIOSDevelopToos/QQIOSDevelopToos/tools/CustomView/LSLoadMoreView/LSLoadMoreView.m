//
//  LSLoadMoreView.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/18.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSLoadMoreView.h"

#import "LSLoadMoreLoadingProtocol.h"

typedef NS_ENUM(NSInteger, LSLoadMoreState)
{
    LSLoadMoreNormal = 0,
    LSLoadMorePulling,
    LSLoadMoreLoading,
};

@interface LSLoadMoreView ()

@property (nonatomic, strong) id<LSLoadMoreLoadingProtocol> loadingView;

/**
 *  自定义的LoadingView的Class的名字 - 如果未设置，默认为LSLoadMoreLoadingView
 */
@property (nonatomic, copy) NSString *loadingViewClassName;


/**
 *  LoadMoreView的状态
 */
@property (nonatomic, assign) LSLoadMoreState state;
/**
 *  当前加载更多是否可用
 */
@property (nonatomic, assign) BOOL loadingEnable;

@end

@implementation LSLoadMoreView

#pragma mark - 初始化
+ (LSLoadMoreView *)CreateLoadMoreView:(UIScrollView *)bindingScrollView delegate:(id<LSLoadMoreViewDelegate>)delegate
{
    return [LSLoadMoreView CreateLoadMoreView:bindingScrollView loadingViewName:kLSLoadMoreDefaultLoadingViewName delegate:delegate];
}
+ (LSLoadMoreView *)CreateLoadMoreView:(UIScrollView *)bindingScrollView loadingViewName:(NSString *)loadingViewName delegate:(id<LSLoadMoreViewDelegate>)delegate
{
    LSLoadMoreView *loadMoreView = [[LSLoadMoreView alloc] init];
    // 记录绑定的视图
    loadMoreView.bindingScrollView = bindingScrollView;
    //
    loadMoreView.loadingViewClassName = loadingViewName;
    
    loadMoreView.delegate = delegate;
    
    [loadMoreView initLoadingView];
    
    return loadMoreView;
}

- (void)initLoadingView
{
    self.autoLoading = YES;
    
    UIView *loadingView = (UIView *)self.loadingView;
    
    loadingView.frame = CGRectMake(0, CGRectGetHeight(self.bindingScrollView.frame), CGRectGetWidth(self.bindingScrollView.frame), kLSLoadMoreViewHeight);
    loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self.bindingScrollView addSubview:loadingView];
    
    self.loadingEnable = YES;
    self.state = LSLoadMoreNormal;
}

- (void)setBindingScrollView:(UIScrollView *)bindingScrollView
{
    _bindingScrollView = bindingScrollView;
}

#pragma mark - 相关方法
- (void)firstLoadMoreData
{
    if (!self.loadingEnable)
    {
        [self setLoadMoreViewLoadingEnable:YES];
    }
    // 刷新一下UI
    [self dataSourceDidFinishedLoading:self.bindingScrollView];
    // 启动加载
    [self startLoading];
}

- (void)startLoading
{
    // 回调用户加载数据
    if ([self.delegate respondsToSelector:@selector(loadMoreViewDidStartLoading:)])
    {
        [self.delegate loadMoreViewDidStartLoading:self];
    }
    // 更新状态为加载中
    [self setState:LSLoadMoreLoading];
}

- (void)setLoadMoreViewLoadingEnable:(BOOL)enable
{
    self.loadingEnable = enable;
    
    UIView *loadingView = (UIView *)self.loadingView;
    loadingView.hidden = !enable;
}

- (void)setState:(LSLoadMoreState)state
{
    switch (state)
    {
        case LSLoadMorePulling:// 这个状态暂时屏蔽了
            [self.loadingView readyLoading];
            break;
        case LSLoadMoreNormal:
            [self.loadingView stopLoading];
            break;
        case LSLoadMoreLoading:
            [self.loadingView startLoading];
            break;
        default:
            break;
    }
    _state = state;
}
#pragma mark - 使用时主动回调方法
//手指屏幕上不断拖动调用此方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.loadingEnable)
    {
        return;
    }
    if (self.state == LSLoadMoreLoading)
    {// 当前数据正在加载中
        scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, kLSLoadMoreViewHeight, 0.0f);
    } else if (scrollView.isDragging) {
        BOOL _loading = NO;
        if ([self.delegate respondsToSelector:@selector(loadMoreDataSourceIsLoading:)])
        {// 检查当前是否是正在请求数据还未返回数据
            _loading = [self.delegate loadMoreDataSourceIsLoading:self];
        }
        
        if (self.state == LSLoadMorePulling && (scrollView.contentOffset.y + (scrollView.frame.size.height) < scrollView.contentSize.height + kLSLoadMoreViewHeight) && scrollView.contentOffset.y > 0.0f && !_loading)
        {// 恢复正常状态
            self.state = LSLoadMoreNormal;
        }
        else if (!self.autoLoading && self.state == LSLoadMoreNormal && scrollView.contentOffset.y + (scrollView.frame.size.height) > scrollView.contentSize.height + kLSLoadMoreViewHeight  && !_loading)
        {// 松开刷新 -- 不是自动加载的时候才走这里
            [self setState:LSLoadMorePulling];
        }
        else if (self.state == LSLoadMoreNormal && !_loading)
        {// 这里修改为拉到底部就去调用刷新
            if (scrollView.contentOffset.y + (scrollView.frame.size.height) > scrollView.contentSize.height) {
                // 启动加载
                [self startLoading];
                
                [UIView animateWithDuration:.25 animations:^{
                    self.bindingScrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, kLSLoadMoreViewHeight, 0.0f);
                }];
            }
        }
        
        if (scrollView.contentInset.bottom != 0)
        {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
        
    } else {
        if (!self.autoLoading) {
            // 松开之后
            BOOL _loading = NO;
            
            if ([self.delegate respondsToSelector:@selector(loadMoreDataSourceIsLoading:)])
            {// 检查当前是否是正在请求数据还未返回数据
                _loading = [self.delegate loadMoreDataSourceIsLoading:self];
            }
            if (!_loading && (scrollView.contentOffset.y + (scrollView.frame.size.height) > scrollView.contentSize.height + kLSLoadMoreViewHeight)) {
            
                // 启动加载
                [self startLoading];
                
                [UIView animateWithDuration:.25 animations:^{
                    self.bindingScrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, kLSLoadMoreViewHeight, 0.0f);
                }];
            }
        }
    }
}

- (void)dataSourceDidFinishedLoading:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:.25 animations:^{
        [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    }];
    
    UIView *loadingView = (UIView *)self.loadingView;
    
    CGRect selfFrame = loadingView.frame;
    selfFrame.origin.y = scrollView.contentSize.height;
    loadingView.frame = selfFrame;
    
    [self setState:LSLoadMoreNormal];
}

#pragma mark - 懒加载创建LoadingView
- (id)loadingView
{
    if (nil == _loadingView) {
        Class loadingClass = nil;
        
        if (self.loadingViewClassName) {
            // 自定义了loadingView
            loadingClass = NSClassFromString(self.loadingViewClassName);
        } else {
            // 使用默认的LoadingView
            loadingClass = NSClassFromString(kLSLoadMoreDefaultLoadingViewName);
        }

        if (loadingClass) {
            id loadingView = [[loadingClass alloc] init];
            _loadingView = loadingView;
        }
    }
    
    return _loadingView;
}

@end
