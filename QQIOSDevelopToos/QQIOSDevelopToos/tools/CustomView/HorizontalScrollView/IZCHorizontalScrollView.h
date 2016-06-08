//
//  UTHorizontalScrollView.h
//  TestHorizontalScroll
//
//  LoaforSpring 2013_02_22
//

#import <Foundation/Foundation.h>

#import "IZCHorizontalScrollViewCell.h"

@protocol IZCHorizontalScrollViewDelegate;
@protocol IZCHorizontalScrollViewDataSource;

@interface IZCHorizontalScrollView : UIScrollView
<UIScrollViewDelegate>

@property (nonatomic, weak) id<IZCHorizontalScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<IZCHorizontalScrollViewDelegate> horDelegate;
@property (nonatomic) CGFloat cellBlankSpace;

- (IZCHorizontalScrollViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (IZCHorizontalScrollViewCell *)getVisibleCellAtIndex:(NSInteger)index;
- (void)reloadData;
- (NSInteger)currentShowIndex;

@end

@protocol IZCHorizontalScrollViewDelegate <NSObject>

@optional
- (void)horizontalScrollViewWillBeginDragging:(IZCHorizontalScrollView *)scrollView;
- (void)horizontalScrollViewDidScroll:(IZCHorizontalScrollView *)scrollView;
- (void)horizontalScrollViewDidEndDragging:(IZCHorizontalScrollView *)scrollView
                            willDecelerate:(BOOL)decelerate;

- (void)horizontalScrollView:(IZCHorizontalScrollView*)ascrollView
        didSelectItemAtIndex:(NSInteger)aindex;
- (void)horizontalScrollView:(IZCHorizontalScrollView*)ascrollView
      willDisplayCellAtIndex:(NSInteger)aindex;
@end

@protocol IZCHorizontalScrollViewDataSource<NSObject>

@required
- (NSInteger)numberOfItems:(IZCHorizontalScrollView*)ascrollView;
- (CGFloat)widthOfItems:(IZCHorizontalScrollView*)ascrollView;
- (IZCHorizontalScrollViewCell*) scrollView:(IZCHorizontalScrollView*)ascrollView
                        cellForItemAtIndex:(NSInteger)aindex;


@end
