//
//  LSPopupOverlayView.m
//  HLVoiceAssistant
//
//  Created by LoaforSpring on 14-4-1.
//  Copyright (c) 2014年 LoaforSpring. All rights reserved.
//

#import "LSPopupOverlayView.h"

#import "LSPopupView.h"

@implementation LSPopupOverlayView

- (void)dealloc
{
    _popupView = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    if ([view isMemberOfClass:[UIButton class]])
    {
        
    }
    else if([view isMemberOfClass:[LSPopupOverlayView class]])
    {
        if (self.popupView)
        {
            [self.popupView dismiss];
        }
    }
}

@end