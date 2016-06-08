//
//  UTHorizontalScrollView.m
//  TestHorizontalScroll
//
//  LoaforSpring 2013_02_22
//

#import "IZCHorizontalScrollView.h"
#import "IZCLog.h"

static inline NSString * LSHorizontalKeyForIndex(NSInteger index) {
    return [NSString stringWithFormat:@"%d", (int)index];
}

//static inline NSInteger LSHorizontalIndexForKey(NSString *key) {
//    return [key integerValue];
//}

@interface IZCHorizontalScrollView ()
<UIGestureRecognizerDelegate>
{
    NSInteger currentShowPage;
    NSInteger numOfItems;
    CGFloat itemsWidth;
    
    CGFloat contentOffsetRage;// 偏移率没有偏移0，contentOffsetX/contentSizeWidth
}
@property(nonatomic) UIInterfaceOrientation orientation;
@property(nonatomic, strong) NSMutableDictionary *indexToRectMap;

@property(nonatomic, strong) NSMutableDictionary* dequeDictionary;	//
@property(nonatomic, strong) NSMutableDictionary* visibleCellDictionary;//

@end

// This is just so we know that we sent this tap gesture recognizer in the delegate
@interface IZCHorizontalScrollViewTapGestureRecognizer : UITapGestureRecognizer
@end

@implementation IZCHorizontalScrollViewTapGestureRecognizer
@end


@implementation IZCHorizontalScrollView

@synthesize orientation = _orientation;
@synthesize indexToRectMap = _indexToRectMap;
@synthesize cellBlankSpace = _cellBlankSpace;


- (void)reloadData
{
    for(id key in [self.visibleCellDictionary allKeys])
    {
        UIView* v=[self.visibleCellDictionary objectForKey:key];
        [v removeFromSuperview];
    }
    [self.visibleCellDictionary removeAllObjects];
    
    numOfItems = [self.dataSource numberOfItems:self];
    itemsWidth = [self.dataSource widthOfItems:self];
    
    self.contentSize = CGSizeMake(numOfItems*itemsWidth+(numOfItems-1)*self.cellBlankSpace, self.bounds.size.height);
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)dealloc
{
    _dataSource = nil;
    _horDelegate = nil;
    
    _indexToRectMap = nil;
    _dequeDictionary = nil;
    _visibleCellDictionary = nil;
}

- (NSInteger)currentShowIndex
{
    return currentShowPage;
}
- (void)internalInit
{
    self.cellBlankSpace = 0.1f;
    self.visibleCellDictionary=[[NSMutableDictionary  alloc] init];// 当前显示单元格字典
    self.dequeDictionary=[[NSMutableDictionary alloc] init];// 队列字典
    self.clipsToBounds=YES;
    self.delegate=self;
    
    currentShowPage = 0;
    self.orientation = [UIApplication sharedApplication].statusBarOrientation;
    self.indexToRectMap = [NSMutableDictionary dictionary];// Rect和Index映射表
    
    numOfItems = -1;// 总Items
    itemsWidth = -1;// Item宽度
}
- (id)initWithFrame:(CGRect)frame
{
    if((self=[super initWithFrame:frame]))
    {
        [self internalInit];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self=[super initWithCoder:aDecoder]))
    {
        [self internalInit];
    }
    return self;
}
- (void)setDataSource:(id<IZCHorizontalScrollViewDataSource>)dataSource
{
    _dataSource = dataSource;
}
- (IZCHorizontalScrollViewCell *)getVisibleCellAtIndex:(NSInteger)index
{
    return [self.visibleCellDictionary objectForKey:LSHorizontalKeyForIndex(index)];
}

- (void)setFrame:(CGRect)frame
{
    if (!CGRectEqualToRect(self.frame, frame))
    {
        [super setFrame:frame];
        [self reloadData];
    }
}

//布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    @autoreleasepool
    {
        if (-1 == numOfItems)
        {// 第一次加载这个view
            numOfItems = [self.dataSource numberOfItems:self];
            itemsWidth = [self.dataSource widthOfItems:self];
            self.contentSize = CGSizeMake(numOfItems*itemsWidth+(numOfItems-1)*self.cellBlankSpace, self.bounds.size.height);
        }
        
        [self.indexToRectMap removeAllObjects];
        
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        
        if (self.orientation != orientation)
        {
            self.orientation = orientation;
            // 刷新itemsWidth
            itemsWidth = [self.dataSource widthOfItems:self];
            
            self.contentSize = CGSizeMake(numOfItems*itemsWidth+(numOfItems-1)*self.cellBlankSpace, self.bounds.size.height);
            
            // 修正偏移
            self.contentOffset = CGPointMake(contentOffsetRage*self.contentSize.width, 0);
        }
        
        CGRect visibleRect;
        visibleRect.origin=self.contentOffset;
        visibleRect.size=self.bounds.size;
        
        CGFloat x = 0;
        CGFloat y = 0;
        
        for(NSInteger i=0; i<numOfItems; ++i)
        {
            @autoreleasepool {
                CGFloat width = itemsWidth;
                CGRect cellFrame=CGRectMake(x, y, width, self.bounds.size.height);
                x += (width + self.cellBlankSpace);
                id indexKey = LSHorizontalKeyForIndex(i);
                
                IZCHorizontalScrollViewCell* cell=[self.visibleCellDictionary objectForKey:indexKey];
                if(CGRectIntersectsRect(visibleRect, cellFrame))
                {//在可视区域
                    if(nil==cell)
                    {
                        cell=[self.dataSource scrollView:self cellForItemAtIndex:i];
                        [self addSubview:cell];
                        [self sendSubviewToBack:cell];
                    }
                    assert(cell!=nil);
                    cell.cellIndex = i;
                    cell.frame=cellFrame;
                    
                    // Add to index rect map
                    [self.indexToRectMap setObject:NSStringFromCGRect(cellFrame) forKey:indexKey];
                    [self.visibleCellDictionary setObject:cell forKey:indexKey];
                    
                    if ([cell.gestureRecognizers count] == 0)
                    {
                        IZCHorizontalScrollViewTapGestureRecognizer *tapGesture = [[IZCHorizontalScrollViewTapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectCell:)];
                        tapGesture.delegate = self;
                        [cell addGestureRecognizer:tapGesture];
                        cell.userInteractionEnabled = YES;
                    }
                    
                    assert(cell.superview==self);
                }
                else
                {//不在可视区域
                    if(cell!=nil)
                    {
                        id identifier=[cell reuseIdentifier];
                        if(identifier!=nil)
                        {
                            NSMutableSet* dequeCellSet=(NSMutableSet*)[self.dequeDictionary objectForKey:identifier];
                            if(dequeCellSet==nil)
                            {
                                dequeCellSet = [[NSMutableSet alloc] init];
                                [self.dequeDictionary setObject:dequeCellSet
                                                         forKey:identifier];
                            }
                            
                            if ([cell respondsToSelector:@selector(prepareForReuse)])
                            {// 准备重用
                                [cell performSelector:@selector(prepareForReuse)];
                            }
                            [dequeCellSet addObject:cell];
                        }
                        
                        [cell removeFromSuperview];
                        [self.visibleCellDictionary removeObjectForKey:indexKey];
                    }
                }
            }
        }
        
    }
    
    // 纪录这个偏移率
    contentOffsetRage = self.contentOffset.x/self.contentSize.width;
}

- (IZCHorizontalScrollViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    IZCHorizontalScrollViewCell* ret=nil;
    @autoreleasepool
    {
        NSMutableSet* dequeCellSet=(NSMutableSet*)[self.dequeDictionary objectForKey:identifier];
        if(dequeCellSet!=nil )
        {
            if([dequeCellSet count]>0)
            {
                ret=(IZCHorizontalScrollViewCell*)[dequeCellSet anyObject];
                [dequeCellSet removeObject:ret];
            }
        }
    }
    return ret;
}

#pragma marks UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.horDelegate!=nil && [self.horDelegate respondsToSelector:@selector(horizontalScrollViewDidScroll:)])
    {
        [self.horDelegate horizontalScrollViewDidScroll:self];
    }
    
    CGSize pageSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    // 滚动到了第几页
    NSInteger page = floor((scrollView.contentOffset.x - pageSize.width / 2) / pageSize.width) + 1;
    
    if (currentShowPage == page || page > numOfItems - 1 || page < 0)
    {
        return;
    }
    
    if (currentShowPage + 1 == page)
    {// 向前滑动一屏
    }
    else
    {// 后退一屏
    }
    
    currentShowPage = page;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(self.horDelegate!=nil && [self.horDelegate respondsToSelector:@selector(horizontalScrollViewWillBeginDragging:)])
    {
        [self.horDelegate horizontalScrollViewWillBeginDragging:self];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.horDelegate!=nil && [self.horDelegate respondsToSelector:@selector(horizontalScrollViewDidEndDragging:willDecelerate:)])
    {
        [self.horDelegate horizontalScrollViewDidEndDragging:self willDecelerate:decelerate];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    currentShowPage = floor((self.contentOffset.x - self.frame.size.width / 2) / self.frame.size.width) + 1;
    
    if(self.horDelegate!=nil && [self.horDelegate respondsToSelector:@selector(horizontalScrollView:willDisplayCellAtIndex:)])
    {
        [self.horDelegate horizontalScrollView:self willDisplayCellAtIndex:currentShowPage];
    }
//    IZCLog(@"currentShowPage:%ld", (int)currentShowPage);
}

//^ 设置contentoffset且animation为yes时执行
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    currentShowPage = floor((self.contentOffset.x - self.frame.size.width / 2) / self.frame.size.width) + 1;
    
    if(self.horDelegate!=nil && [self.horDelegate respondsToSelector:@selector(horizontalScrollView:willDisplayCellAtIndex:)])
    {
        [self.horDelegate horizontalScrollView:self willDisplayCellAtIndex:currentShowPage];
    }
}

- (void)touchScrollView:(IZCHorizontalScrollViewCell *)cell
{
    IZCLog(@"touchScrollView : %ld",  (int)cell.cellIndex);
    
}







#pragma mark -
#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 1)
    {
        
    } else if (touch.tapCount == 2) {
        
    }
}
#pragma mark Touches UIGestureRecognizerDelegate

- (void)didSelectCell:(UITapGestureRecognizer *)gestureRecognizer
{
    IZCLog(@"didSelectCell gestureRecognizer");
    NSString *rectString = NSStringFromCGRect(gestureRecognizer.view.frame);
    NSArray *matchingKeys = [self.indexToRectMap allKeysForObject:rectString];
    NSString *key = [matchingKeys lastObject];
    
    if ([gestureRecognizer.view isMemberOfClass:[[self.visibleCellDictionary objectForKey:key] class]])
    {
        if(self.horDelegate!=nil && [self.horDelegate respondsToSelector:@selector(horizontalScrollView:didSelectItemAtIndex:)])
        {
            IZCHorizontalScrollViewCell *cell = (IZCHorizontalScrollViewCell *)gestureRecognizer.view;
            [self.horDelegate horizontalScrollView:self didSelectItemAtIndex:cell.cellIndex];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
   // IZCLog(@"gestureRecognizer:%@--touch:%@", gestureRecognizer, touch );
    if (![gestureRecognizer isMemberOfClass:[IZCHorizontalScrollViewTapGestureRecognizer class]])
        return YES;
    
    NSString *rectString = NSStringFromCGRect(gestureRecognizer.view.frame);
    NSArray *matchingKeys = [self.indexToRectMap allKeysForObject:rectString];
    NSString *key = [matchingKeys lastObject];
    
   // IZCLog(@"key:%@--%ld", key, [touch.view isMemberOfClass:[[self.visibleCellDictionary objectForKey:key] class]]);
  //  IZCLog(@"touch.view:%@--%@", touch.view, [self.visibleCellDictionary objectForKey:key]);
    
    if ([touch.view isMemberOfClass:[[self.visibleCellDictionary objectForKey:key] class]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end

