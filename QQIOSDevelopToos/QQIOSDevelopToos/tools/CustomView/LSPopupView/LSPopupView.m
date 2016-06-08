//
//  LSPopupView.m
//  HLVoiceAssistant
//
//  Created by LoaforSpring on 14-4-1.
//  Copyright (c) 2014年 LoaforSpring. All rights reserved.
//

#import "LSPopupView.h"

#import <QuartzCore/QuartzCore.h>
#import "LSPopupOverlayView.h"

#define POPUP_ANIMATION_DURATION		0.3
#define DISMISS_ANIMATION_DURATION		0.2

#define HORIZONTAL_SAFE_MARGIN			30

// 用来计算显示空间是否足够
static CGFloat const kHorizontalSafeMargin = 30.0f;

// PopupView的朝向，默认朝上
typedef enum {
    LSPopupViewUp		= 1,
    LSPopupViewDown		= 2,
    LSPopupViewRight	= 1 << 8,
    LSPopupViewLeft		= 2 << 8,
} LSPopupViewDirection;

@interface LSPopupView ()
{
    // 绘制框体所需要的参数
    CGRect		contentRect;
	CGRect		contentBounds;
    
    CGRect		popupRect;
    CGPoint		pointToBeShown;
    
    float		horizontalOffset;
    LSPopupViewDirection	direction;
    
    BOOL		animatedWhenAppering;
}
// OverlayView拦截视图
@property (nonatomic, strong) LSPopupOverlayView *overlayView;

@end

@implementation LSPopupView

#pragma mark - Prepare

#pragma mark - dealloc
- (void)dealloc
{
    _delegate = nil;
    _contentView = nil;
    
//    CGGradientRelease();
}

- (void)setupGradientColors
{
//	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//    // 全部内容的颜色渐变
//    CGFloat colors[] =
//	{
//		69.0 / 255.0, 76.0 / 255.0, 85.0 / 255.0, 0.9,
//	};
//	gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
//	
//    //下半部分颜色渐变
//	CGFloat colors2[] =
//	{
//		20.0 / 255.0, 20.0 / 255.0, 20.0 / 255.0, ALPHA,
//		0.0 / 255.0, 0.0 / 255.0, 0.0 / 255.0, ALPHA,
//	};
//	gradient2 = CGGradientCreateWithColorComponents(rgb, colors2, NULL, sizeof(colors2)/(sizeof(colors2[0])*4));
//	CGColorSpaceRelease(rgb);
}

- (id) initWithContentView:(UIView*)newContentView contentSize:(CGSize)contentSize
{
	self = [super init];
	if (self != nil)
    {
		self.contentView = newContentView;
		
        // Initialization code
		[self setBackgroundColor:[UIColor clearColor]];
		
		contentBounds = CGRectMake(0, 0, 0, 0);
		contentBounds.size = contentSize;
        
        // 默认的背景色
        self.popupViewColor = [UIColor colorWithRed:69.0 / 255.0 green:76.0 / 255.0 blue:85.0 / 255.0 alpha:0.9];
        // 默认的描边色
        self.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        // 初始化绘制的相关默认参数
        // 描边偏移
        self.shadowOffset = CGSizeMake(10, 10);
        self.contentOffset = CGSizeMake(2, 2);
        self.arrowSize = CGSizeMake(20, 10);
        self.popupViewRadius = 6;
        
//		[self setupGradientColors];
	}
	return self;
}

#pragma mark - Show as normal view
- (void)showAtPoint:(CGPoint)p inView:(UIView*)inView
{
	[self showAtPoint:p inView:inView animated:NO];
}

- (void)showAtPoint:(CGPoint)p inView:(UIView*)inView animated:(BOOL)animated
{
    if (nil != self.overlayView)
    {
        self.overlayView = nil;
    }
    // OverlayView拦截点击
    self.overlayView = [[LSPopupOverlayView alloc] initWithFrame:inView.bounds];
    self.overlayView.popupView = self;
    if (self.overlayViewColor) {
        self.overlayView.backgroundColor = self.overlayViewColor;
    }
    [inView addSubview:self.overlayView];
    
    [self.overlayView addSubview:self];
    
    if(animated) {
        self.alpha = 0;
    }
    
    //
	CGRect		popupBounds;
	
	CGRect		viewRect;
	CGRect		viewBounds;
    
	if ((p.y - contentBounds.size.height - self.arrowSize.height - 2 * self.contentOffset.height - self.shadowOffset.height) < 0)
    {
		direction = LSPopupViewDown;
	}
	else {
		direction = LSPopupViewUp;
	}
	
	if (direction & LSPopupViewUp) {
        
		pointToBeShown = p;
		
		// calc content area
		contentRect.origin.x = p.x - (int)contentBounds.size.width/2;
		contentRect.origin.y = p.y - self.contentOffset.height - self.arrowSize.height - contentBounds.size.height;
		contentRect.size = contentBounds.size;
		
		// calc popup area
		popupBounds.origin = CGPointMake(0, 0);
		popupBounds.size.width = contentBounds.size.width + self.contentOffset.width + self.contentOffset.width;
		popupBounds.size.height = contentBounds.size.height + self.contentOffset.height + self.contentOffset.height + self.arrowSize.height;
		
		popupRect.origin.x = contentRect.origin.x - self.contentOffset.width;
		popupRect.origin.y = contentRect.origin.y - self.contentOffset.height;
		popupRect.size = popupBounds.size;
		
		// calc self size and rect
		viewBounds.origin = CGPointMake(0, 0);
		viewBounds.size.width = popupRect.size.width + self.shadowOffset.width + self.shadowOffset.width;
		viewBounds.size.height = popupRect.size.height + self.shadowOffset.height + self.shadowOffset.height;
		
		viewRect.origin.x = popupRect.origin.x - self.shadowOffset.width;
		viewRect.origin.y = popupRect.origin.y - self.shadowOffset.height;
		viewRect.size = viewBounds.size;
        
		float left_viewRect = viewRect.origin.x + viewRect.size.width;
		
		// calc horizontal offset
		if (viewRect.origin.x < 0) {
			direction = direction | LSPopupViewRight;
			horizontalOffset = viewRect.origin.x;
			
			if (viewRect.origin.x - horizontalOffset < pointToBeShown.x - kHorizontalSafeMargin) {
			}
			else {
				pointToBeShown.x = kHorizontalSafeMargin;
			}
			viewRect.origin.x -= horizontalOffset;
			contentRect.origin.x -= horizontalOffset;
			popupRect.origin.x -= horizontalOffset;
		}
		else if (left_viewRect > inView.frame.size.width) {
			direction = direction | LSPopupViewLeft;
			horizontalOffset = inView.frame.size.width - left_viewRect;
			
			if (left_viewRect + horizontalOffset > pointToBeShown.x + kHorizontalSafeMargin) {
			}
			else {
				pointToBeShown.x = inView.frame.size.width - kHorizontalSafeMargin;
			}
			viewRect.origin.x += horizontalOffset;
			contentRect.origin.x += horizontalOffset;
			popupRect.origin.x += horizontalOffset;
		}
	}
	else
    {
		pointToBeShown = p;
		
		// calc content area
		contentRect.origin.x = p.x - (int)contentBounds.size.width/2;
		contentRect.origin.y = p.y + self.contentOffset.height + self.arrowSize.height;
		contentRect.size = contentBounds.size;
		
		// calc popup area
		popupBounds.origin = CGPointMake(0, 0);
		popupBounds.size.width = contentBounds.size.width + self.contentOffset.width + self.contentOffset.width;
		popupBounds.size.height = contentBounds.size.height + self.contentOffset.height + self.contentOffset.height + self.arrowSize.height;
		
		popupRect.origin.x = contentRect.origin.x - self.contentOffset.width;
		popupRect.origin.y = contentRect.origin.y - self.contentOffset.height - self.arrowSize.height;
		popupRect.size = popupBounds.size;
		
		// calc self size and rect
		viewBounds.origin = CGPointMake(0, 0);
		viewBounds.size.width = popupRect.size.width + self.shadowOffset.width + self.shadowOffset.width;
		viewBounds.size.height = popupRect.size.height + self.shadowOffset.height + self.shadowOffset.height;
		
		viewRect.origin.x = popupRect.origin.x - self.shadowOffset.width;
		viewRect.origin.y = popupRect.origin.y - self.shadowOffset.height;
		viewRect.size = viewBounds.size;
		
		float left_viewRect = viewRect.origin.x + viewRect.size.width;
		
		// calc horizontal offset
		if (viewRect.origin.x < 0) {
			direction = direction | LSPopupViewRight;
			horizontalOffset = viewRect.origin.x;
			
			if (viewRect.origin.x - horizontalOffset < pointToBeShown.x - kHorizontalSafeMargin) {
			}
			else {
				pointToBeShown.x = kHorizontalSafeMargin;
			}
			viewRect.origin.x -= horizontalOffset;
			contentRect.origin.x -= horizontalOffset;
			popupRect.origin.x -= horizontalOffset;
		}
		else if (left_viewRect > inView.frame.size.width) {
			direction = direction | LSPopupViewLeft;
			horizontalOffset = inView.frame.size.width - left_viewRect;
			
			if (left_viewRect + horizontalOffset > pointToBeShown.x + kHorizontalSafeMargin)
            {
			}
			else
            {
				pointToBeShown.x = inView.frame.size.width - kHorizontalSafeMargin;
			}
			viewRect.origin.x += horizontalOffset;
			contentRect.origin.x += horizontalOffset;
			popupRect.origin.x += horizontalOffset;
		}
	}
	
	// offset
	contentRect.origin.x -= viewRect.origin.x;
	contentRect.origin.y -= viewRect.origin.y;
	popupRect.origin.x -= viewRect.origin.x;
	popupRect.origin.y -= viewRect.origin.y;
	pointToBeShown.x -= viewRect.origin.x;
	pointToBeShown.y -= viewRect.origin.y;
	
	BOOL isAlreadyShown = (self.superview == inView);
    
	if (isAlreadyShown)
    {
		[self setNeedsDisplay];
        
        self.frame = viewRect;
        [UIView animateWithDuration:animated?POPUP_ANIMATION_DURATION:0
                         animations:^{
                             self.alpha = 1;
                         }];
	}
	else
    {
		// set frame
		self.frame = viewRect;
		
		if (self.contentView) {
			[self addSubview:self.contentView];
			[self.contentView setFrame:contentRect];
		}
		
        [UIView animateWithDuration:animated?0.2:0
                         animations:^{
                             self.alpha = 1;
                         }];
	}
}

#pragma mark - Core Animation call back

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	[self removeFromSuperview];
}

#pragma mark - Popup and dismiss
- (void)dismiss:(BOOL)animtaed
{
    [UIView animateWithDuration:animtaed?DISMISS_ANIMATION_DURATION:0
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];

                         [self.overlayView removeFromSuperview];
                         
                         if (self.delegate && [self.delegate respondsToSelector:@selector(popupViewDidDismiss:)])
                         {//
                             [self.delegate popupViewDidDismiss:self];
                         }
                     }];
}

- (void)dismiss
{
	[self dismiss:YES];
}

#pragma mark - Drawing

- (void)makePathCircleCornerRect:(CGRect)rect
                          radius:(float)radius
                        popPoint:(CGPoint)popPoint
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (direction & LSPopupViewUp)
    {
		rect.size.height -= self.arrowSize.height;
		
		// get points
		CGFloat minx = CGRectGetMinX( rect ), midx = CGRectGetMidX( rect ), maxx = CGRectGetMaxX( rect );
		CGFloat miny = CGRectGetMinY( rect ), midy = CGRectGetMidY( rect ), maxy = CGRectGetMaxY( rect );
		
		CGFloat popRightEdgeX = popPoint.x + (int)self.arrowSize.width / 2;
		CGFloat popRightEdgeY = maxy;
		
		CGFloat popLeftEdgeX = popPoint.x - (int)self.arrowSize.width / 2;
		CGFloat popLeftEdgeY = maxy;
		
		CGContextMoveToPoint(context, minx, midy);
		CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
		CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
		
		
		CGContextAddArcToPoint(context, maxx, maxy, popRightEdgeX, popRightEdgeY, radius);
		CGContextAddLineToPoint(context, popRightEdgeX, popRightEdgeY);
		CGContextAddLineToPoint(context, popPoint.x, popPoint.y);
		CGContextAddLineToPoint(context, popLeftEdgeX, popLeftEdgeY);
		CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
		CGContextAddLineToPoint(context, minx, midy);
	}
	else
    {
		rect.origin.y += self.arrowSize.height;
		rect.size.height -= self.arrowSize.height;
		
		// get points
		CGFloat minx = CGRectGetMinX( rect ), midx = CGRectGetMidX( rect ), maxx = CGRectGetMaxX( rect );
		CGFloat miny = CGRectGetMinY( rect ), midy = CGRectGetMidY( rect ), maxy = CGRectGetMaxY( rect );
		
		CGFloat popRightEdgeX = popPoint.x + (int)self.arrowSize.width / 2;
		CGFloat popRightEdgeY = miny;
		
		CGFloat popLeftEdgeX = popPoint.x - (int)self.arrowSize.width / 2;
		CGFloat popLeftEdgeY = miny;
		
		CGContextMoveToPoint(context, minx, midy);
		CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
		CGContextAddLineToPoint(context, popLeftEdgeX, popLeftEdgeY);
		CGContextAddLineToPoint(context, popPoint.x, popPoint.y);
		CGContextAddLineToPoint(context, popRightEdgeX, popRightEdgeY);
		CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
		CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
		CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	}
}

- (void)makeGrowingPathCircleCornerRect:(CGRect)rect
                                 radius:(float)radius
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	rect.origin.y += 1;
	rect.origin.x += 1;
	rect.size.width -= 2;
	
	
    // get points
    CGFloat minx = CGRectGetMinX( rect ), midx = CGRectGetMidX( rect ), maxx = CGRectGetMaxX( rect );
    CGFloat miny = CGRectGetMinY( rect ), midy = CGRectGetMidY( rect );
	
	CGFloat rightEdgeX = minx;
	CGFloat rightEdgeY = midy - 10;
	
	CGFloat leftEdgeX = maxx;
	CGFloat leftEdgeY = midy - 10;
	
    CGContextMoveToPoint(context, rightEdgeX, rightEdgeY);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddLineToPoint(context, leftEdgeX, leftEdgeY);
}

#pragma mark - Override
- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// draw shadow, and base
	CGContextSaveGState(context);

    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    [self.popupViewColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    // 背景色
    CGContextSetRGBFillColor(context, red, green, blue, alpha);
    // 描边颜色
    CGContextSetShadowWithColor (context, CGSizeMake(0, 0), 2, [self.shadowColor CGColor]);
    
//    CGContextSetRGBFillColor(context, 69.0 / 255.0, 76.0 / 255.0, 85.0 / 255.0, 0.9);
//	CGContextSetShadowWithColor (context, CGSizeMake(0, 0), 2, [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] CGColor]);
    
	[self makePathCircleCornerRect:popupRect
                            radius:self.popupViewRadius
                          popPoint:pointToBeShown];
	CGContextClosePath(context);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
    
	// draw body
	CGContextSaveGState(context);
	[self makePathCircleCornerRect:popupRect
                            radius:self.popupViewRadius
                          popPoint:pointToBeShown];
	CGContextClip(context);
    
	CGContextRestoreGState(context);
}


@end

