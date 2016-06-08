//
//  LSActivityIndicatorView.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/14.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSActivityIndicatorView.h"


@interface LSActivityIndicatorView ()

@property(nonatomic, assign) BOOL animating;
//@property(nonatomic, strong) UIImageView *loadingImagView;
@property(nonatomic, strong) UIView *grayBgView;

@property(nonatomic, assign) CGFloat angle;

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation LSActivityIndicatorView

- (void)dealloc
{
    self.grayBgView = nil;
    self.animating = NO;
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;   //Rachel test
    if (self)
    {
        self.grayBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.grayBgView.backgroundColor = [UIColor blackColor];
        self.grayBgView.alpha = 0.6;
        self.grayBgView.layer.cornerRadius = 5;
        self.grayBgView.layer.masksToBounds = YES;
        [self addSubview:self.grayBgView];
        
//        self.loadingImagView = [[UIImageView alloc] initWithFrame:self.bounds];
//        self.loadingImagView.image = [UIImage imageNamed:@"dev_icon_little"];
//        self.loadingImagView.hidden = YES;
//        [self addSubview:self.loadingImagView];
        
        self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.loadingView.tag = 147701;
        self.loadingView.backgroundColor = [UIColor clearColor];
        self.loadingView.center = CGPointMake(self.grayBgView.bounds.size.width*0.5, self.grayBgView.bounds.size.height*0.5);
        self.loadingView.hidesWhenStopped = YES;
        [self.grayBgView addSubview:self.loadingView];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect superBounds = self.superview.bounds;
//    self.loadingImagView.center = CGPointMake(superBounds.size.width * 0.5, superBounds.size.height * 0.5);
    self.grayBgView.center = CGPointMake(superBounds.size.width * 0.5, superBounds.size.height * 0.5);
    [self.loadingView startAnimating];
}

- (void)startAnimating
{
//    self.loadingImagView.hidden = NO;
    self.animating = YES;
    
//    CABasicAnimation *rotationAnimation;
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
//    rotationAnimation.duration = 0.6;
//    rotationAnimation.cumulative = YES;
//    rotationAnimation.repeatCount = CGFLOAT_MAX;
//
//    [self.loadingImagView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
- (void)stopAnimating
{
    self.animating = NO;
//    self.loadingImagView = nil;
//    [self.loadingImagView.layer removeAllAnimations];
    [self.loadingView stopAnimating];
}

- (BOOL)isAnimating
{
    return self.animating;
}

@end
