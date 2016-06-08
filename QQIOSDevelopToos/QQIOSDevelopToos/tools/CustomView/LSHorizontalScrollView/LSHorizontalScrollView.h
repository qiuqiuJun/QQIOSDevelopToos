//
//  UTHorizontalScrollView.h
//  TestHorizontalScroll
//
//  LoaforSpring 2013_02_22
//

#import <Foundation/Foundation.h>

#import "LSHorizontalScrollViewCell.h"

@protocol LSHorizontalScrollViewDelegate;
@protocol LSHorizontalScrollViewDataSource;

@interface LSHorizontalScrollView : UIScrollView
<UIScrollViewDelegate>

@property (nonatomic, weak) id<LSHorizontalScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<LSHorizontalScrollViewDelegate> horDelegate;
@property (nonatomic) CGFloat cellBlankSpace;

// 尝试获取一个空闲的LSHorizontalScrollViewCell
- (LSHorizontalScrollViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
// 根据index获取界面内的Cell
- (LSHorizontalScrollViewCell *)getVisibleCellAtIndex:(NSInteger)index;

- (void)reloadData;
- (NSInteger)currentShowIndex;

@end

@protocol LSHorizontalScrollViewDelegate <NSObject>

@optional
- (void)horizontalScrollViewWillBeginDragging:(LSHorizontalScrollView *)scrollView;
- (void)horizontalScrollViewDidScroll:(LSHorizontalScrollView *)scrollView;
- (void)horizontalScrollViewDidEndDragging:(LSHorizontalScrollView *)scrollView
                            willDecelerate:(BOOL)decelerate;

- (void)horizontalScrollView:(LSHorizontalScrollView*)ascrollView
        didSelectItemAtIndex:(NSInteger)aindex;
- (void)horizontalScrollView:(LSHorizontalScrollView*)ascrollView
      willDisplayCellAtIndex:(NSInteger)aindex;
@end

@protocol LSHorizontalScrollViewDataSource<NSObject>

@required
- (NSInteger)numberOfItems:(LSHorizontalScrollView*)ascrollView;
- (CGFloat)widthOfItems:(LSHorizontalScrollView*)ascrollView;
- (LSHorizontalScrollViewCell*) scrollView:(LSHorizontalScrollView*)ascrollView
                        cellForItemAtIndex:(NSInteger)aindex;


@end
