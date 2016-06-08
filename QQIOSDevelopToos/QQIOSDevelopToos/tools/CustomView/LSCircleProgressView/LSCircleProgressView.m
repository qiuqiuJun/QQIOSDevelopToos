//
//  LSCircleProgressView.m
//  iZichanSalary
//
//  Created by LoaforSpring on 16/5/9.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSCircleProgressView.h"


NSString * const LSCircleProgressViewAnimationKey = @"LSCircleProgressViewAnimationKey";

@interface LSCircleProgressView ()

/**
 *  底部圆的
 */
@property (nonatomic, strong) CAShapeLayer *bottomLayer;
/**
 *  线条图层
 */
@property (nonatomic, strong) CAShapeLayer *lineLayer;

@property (nonatomic, assign) int valueLabelProgressPercentDifference;
@property (nonatomic, strong) NSTimer *valueLabelUpdateTimer;

@end

@implementation LSCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupProgressView];
    }
    return self;
}

- (void)setupProgressView
{
    // 创建背景层
    self.bottomLayer = [CAShapeLayer layer];
    self.bottomLayer.frame = self.bounds;
    self.bottomLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:self.bottomLayer];
    
    // 创建线条层
    self.lineLayer = [CAShapeLayer layer];
    self.lineLayer.frame = self.bounds;
    self.lineLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:self.lineLayer];
}

- (void)updateBezierPath
{
    self.bottomLayer.path = [self layoutPath].CGPath;
    self.lineLayer.path = [self layoutPath].CGPath;
}

- (UIBezierPath *)layoutPath {
    const double TWO_M_PI = 2.0 * M_PI;
    const double startAngle = 0.75 * TWO_M_PI;
    const double endAngle = startAngle + TWO_M_PI;
    
    CGFloat width = self.frame.size.width;
    CGFloat borderWidth = self.lineWidth;
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0f, width/2.0f)
                                          radius:width/2.0f - borderWidth
                                      startAngle:startAngle
                                        endAngle:endAngle
                                       clockwise:YES];
}

#pragma mark - Set Property
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    
    self.bottomLayer.lineWidth = lineWidth;
    self.lineLayer.lineWidth = lineWidth;
    // 更新贝塞尔曲线
    [self updateBezierPath];
}

- (void)updateProgress:(CGFloat)progress {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.lineLayer.strokeEnd = progress;
    [CATransaction commit];
}

#pragma mark - Color

- (void)setBottomColor:(UIColor *)bottomColor
{
    _bottomColor = bottomColor;
    self.bottomLayer.strokeColor = bottomColor.CGColor;
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.lineLayer.strokeColor = lineColor.CGColor;
}

#pragma mark - Progress
- (void)setProgress:(CGFloat)progress
{
    // 没动画
    [self updateProgress:progress];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    
    progress = MAX( MIN(progress, 1.0), 0.0); // keep it between 0 and 1
    
    if (_progress == progress) {
        return;
    }
    
    if (animated) {
        
        [self animateToProgress:progress];
        
    } else {
        
        [self stopAnimation];
        _progress = progress;
        [self updateProgress:_progress];
    }
}

- (void)animateToProgress:(CGFloat)progress {
    [self stopAnimation];
    
    // Add shape animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.1;
    animation.fromValue = @(self.progress);
    animation.toValue = @(progress);
    animation.delegate = self;
    [self.lineLayer addAnimation:animation forKey:LSCircleProgressViewAnimationKey];
    
    // Add timer to update valueLabel
    _valueLabelProgressPercentDifference = (progress - self.progress) * 100;
    CFTimeInterval timerInterval =  0.1 / ABS(_valueLabelProgressPercentDifference);
    self.valueLabelUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:timerInterval
                                                                  target:self
                                                                selector:@selector(onValueLabelUpdateTimer:)
                                                                userInfo:nil
                                                                 repeats:YES];
    
    
    _progress = progress;
}

- (void)stopAnimation {
    // Stop running animation
    [self.lineLayer removeAnimationForKey:LSCircleProgressViewAnimationKey];
    
    // Stop timer
    [self.valueLabelUpdateTimer invalidate];
    self.valueLabelUpdateTimer = nil;
}

- (void)onValueLabelUpdateTimer:(NSTimer *)timer {
    if (_valueLabelProgressPercentDifference > 0) {
        _valueLabelProgressPercentDifference--;
    } else {
        _valueLabelProgressPercentDifference++;
    }
}


@end
