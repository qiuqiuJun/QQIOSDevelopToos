//
//  LSWebProgressBar.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/14.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSWebProgressBar.h"

@implementation LSWebProgressBar

- (void)dealloc
{
    _progressColor  = nil;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect progressRect = rect;
    
    //change bar width on progress value (%)
    progressRect.size.width *= [self progress];
    
    //Fill color
    CGContextSetFillColorWithColor(ctx, [self.progressColor CGColor]);
    CGContextFillRect(ctx, progressRect);
    
    //Hide progress with fade-out effect
    if (self.progress == 1.0f)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideWithFadeOut];
        });
    }
}

- (void)hideWithFadeOut
{
    //initialize fade animation
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.5;
    [self.layer addAnimation:animation forKey:nil];
    
    //Do hide progress bar
    self.hidden = YES;
}

- (void)setProgress:(CGFloat)value animated:(BOOL)animated
{
    if ((!animated && value > self.progress) || animated)
    {
        self.progress = value;
        [self setNeedsDisplay];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.6];
        //set bar color
        self.progressColor = [UIColor colorWithRed:0.0f/255.0f green:191.0f/255.0f blue:18.0f/255.0f alpha:1];
        self.progress = 0;
    }
    
    return self;
}

@end
