//
//  LSLoadMoreLoadingView.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/18.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSLoadMoreLoadingView.h"

@interface LSLoadMoreLoadingView ()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation LSLoadMoreLoadingView

- (id)init
{
    self = [super init];
    if (self) {
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityView.center = CGPointMake(30, 22);
        self.activityView.hidesWhenStopped = YES;
        [self addSubview:self.activityView];
        
        self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 200, 24)];
        self.tipsLabel.textColor = [UIColor grayColor];
        self.tipsLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.tipsLabel];
    }
    return self;
}

- (void)readyLoading
{
    self.tipsLabel.text = @"释放开始加载";
}
- (void)startLoading
{
    [self.activityView startAnimating];
    self.tipsLabel.text = @"数据加载中...";
}
- (void)stopLoading
{
    [self.activityView stopAnimating];
    self.tipsLabel.text = @"上拉加载更多";
}

@end
