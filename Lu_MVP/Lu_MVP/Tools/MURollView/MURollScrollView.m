//
//  MURollScrollView.m
//  LUMVP
//
//  Created by Faith on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MURollScrollView.h"
#import "MUPageControl.h"
#import "MURollCollectionViewCell.h"
#import "UIView+Extention.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

@interface MURollScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource,MUPageControlDelegate>

///显示图片的collection
@property(nonatomic, strong)UICollectionView * mainCollectionView;
///collectionView布局样式
@property(nonatomic, strong)UICollectionViewFlowLayout * flowLayout;
/// 当imageURLs为空时的背景图
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) NSArray *imagePathsGroup;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property(nonatomic, strong) MUPageControl * pageControl;
@end

@implementation MURollScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initialization];
        [self setupMainView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initialization];
    [self setupMainView];
}

-(void)initialization{
    _autoScrollTimeInterval = 2.0;
    _pageControlLocation = PageControlRight;
    _autoScroll = YES;
    _infiniteLoop = YES;
    _showPageControl = YES;
    _hidesForSinglePage = YES;
    self.backgroundColor = [UIColor lightGrayColor];
}

+(instancetype)rollScrollViewWithFrame:(CGRect)frame delegate:(id<MURollScrollViewDelegate>)delegate placeHolderImage:(UIImage *)placeHolderImage{
   MURollScrollView * rollScrollView = [[self alloc] initWithFrame:frame];
    rollScrollView.delegate = delegate;
    rollScrollView.placeHolderImage = placeHolderImage;
    return rollScrollView;
}

///布局展示图片
-(void)setupMainView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[MURollCollectionViewCell class] forCellWithReuseIdentifier:MURollCollectionViewCellID];
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.scrollsToTop = YES;
    [self addSubview:mainView];
    _mainCollectionView = mainView;
}

#pragma properties

-(void)setPlaceHolderImage:(UIImage *)placeHolderImage{
    _placeHolderImage = placeHolderImage;
    if (!self.backgroundImageView) {
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self insertSubview:bgImageView belowSubview:self.mainCollectionView];
        self.backgroundImageView = bgImageView;
    }
    self.backgroundImageView.image = placeHolderImage;
}

-(void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl = showPageControl;
    _pageControl.hidden = !showPageControl;
}

- (void)setInfiniteLoop:(BOOL)infiniteLoop
{
    _infiniteLoop = infiniteLoop;
    
    if (self.imagePathsGroup.count) {
        self.imagePathsGroup = self.imagePathsGroup;
    }
}

-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    
    if (_autoScroll) {
        [self setupTimer];
    }
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    
    _flowLayout.scrollDirection = scrollDirection;
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setAutoScroll:self.autoScroll];
}

- (void)setImagePathsGroup:(NSArray *)imagePathsGroup
{
    [self invalidateTimer];
    
    _imagePathsGroup = imagePathsGroup;
    
    _totalItemsCount = self.infiniteLoop ? self.imagePathsGroup.count * 100 : self.imagePathsGroup.count;
    
    if (imagePathsGroup.count > 1) { // 由于 !=1 包含count == 0等情况
        self.mainCollectionView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        self.mainCollectionView.scrollEnabled = NO;
        [self invalidateTimer];
    }
    
    [self setupPageControl];
    [self.mainCollectionView reloadData];
}

- (void)setOnlineImageArray:(NSArray *)onlineImageArray
{
    _onlineImageArray = onlineImageArray;
    
    NSMutableArray *temp = [NSMutableArray new];
    [_onlineImageArray enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * stop) {
        NSString *urlString;
        if ([obj isKindOfClass:[NSString class]]) {
            urlString = obj;
        } else if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            urlString = [url absoluteString];
        }
        if (urlString) {
            [temp addObject:urlString];
        }
    }];
    self.imagePathsGroup = [temp copy];
}

- (void)setLocationImageArray:(NSArray *)locationImageArray
{
    _locationImageArray = locationImageArray;
    self.imagePathsGroup = [locationImageArray copy];
}

- (void)setTitlesArray:(NSArray *)titlesArray
{
    _titlesArray = titlesArray;
}

- (void)disableScrollGesture {
    self.mainCollectionView.canCancelContentTouches = NO;
    for (UIGestureRecognizer *gesture in self.mainCollectionView.gestureRecognizers) {
        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.mainCollectionView removeGestureRecognizer:gesture];
        }
    }
}

- (void)setupPageControl
{
    // 重新加载数据时调整
    if (_pageControl) [_pageControl removeFromSuperview];
    
    if (self.imagePathsGroup.count == 0) return;
    
    if ((self.imagePathsGroup.count == 1) && self.hidesForSinglePage) return;
    
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:[self currentIndex]];
    
    MUPageControl *pageControl = [[MUPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20)];
    pageControl.numberOfPages  = self.imagePathsGroup.count;
    pageControl.otherMultiple = 1;
    //设置选中点的宽度是高度的倍数(设置长条形状)
    pageControl.currentMultiple = 2;
    
    //非选中点的颜色
    pageControl.otherColor=[UIColor grayColor];
    //选中点的颜色
    pageControl.currentColor=[UIColor orangeColor];
    //代理
    pageControl.delegate = self;
    //标记
    _pageControl = pageControl;
    
    pageControl.tag = 902;
    [self addSubview:pageControl];
}


-(void)pageControl:(MUPageControl *)pageControl selectedItem:(NSInteger)index{
    
}


///创建定时器
-(void)setupTimer{
    // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
     [self invalidateTimer];
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    //添加到runloop
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

///销毁定时器
-(void)invalidateTimer{
    [_timer invalidate];
    _timer = nil;
}

-(void)automaticScroll{
    if (_totalItemsCount == 0) {
        return;
    }
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

- (void)scrollToIndex:(int)targetIndex
{
    if (targetIndex >= _totalItemsCount) {
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
            [_mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        return;
    }
    [_mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

-(int)currentIndex{
    
    if (_mainCollectionView.width == 0 || _mainCollectionView.height == 0) {
        return 0;
    }
    
    int index = 0;
    
    //（移送的距离+ 间隔） / 滚动的宽度
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
         index = (_mainCollectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    }else{
         index = (_mainCollectionView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    return MAX(0, index);
}

- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.imagePathsGroup.count;
}

///清除缓存
-(void)clearImageCache{
     [[[SDWebImageManager sharedManager] imageCache] clearDiskOnCompletion:nil];
}

-(void)layoutSubviews{
    self.delegate = self.delegate;
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    _mainCollectionView.frame = self.bounds;
    
    //
    if (_mainCollectionView.contentOffset.x == 0 &&  _totalItemsCount) {
        int targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        }else{
            targetIndex = 0;
        }
        [_mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize size = CGSizeZero;
//    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
//        TAPageControl *pageControl = (TAPageControl *)_pageControl;
//        if (!(self.pageDotImage && self.currentPageDotImage && CGSizeEqualToSize(kCycleScrollViewInitialPageControlDotSize, self.pageControlDotSize))) {
//            pageControl.dotSize = self.pageControlDotSize;
//        }
//        size = [pageControl sizeForNumberOfPages:self.imagePathsGroup.count];
//    } else {
//        size = CGSizeMake(self.imagePathsGroup.count * self.pageControlDotSize.width * 1.5, self.pageControlDotSize.height);
//    }
//    CGFloat x = (self.sd_width - size.width) * 0.5;
//    if (self.pageControlAliment == SDCycleScrollViewPageContolAlimentRight) {
//        x = self.mainView.sd_width - size.width - 10;
//    }
//    CGFloat y = self.mainView.sd_height - size.height - 10;
//
//    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
//        TAPageControl *pageControl = (TAPageControl *)_pageControl;
//        [pageControl sizeToFit];
//    }
//
//    CGRect pageControlFrame = CGRectMake(x, y, size.width, size.height);
//    pageControlFrame.origin.y -= self.pageControlBottomOffset;
//    pageControlFrame.origin.x -= self.pageControlRightOffset;
//    self.pageControl.frame = pageControlFrame;
//    self.pageControl.hidden = !_showPageControl;
    
    if (self.backgroundImageView) {
        self.backgroundImageView.frame = self.bounds;
    }
}

#pragma mark datasoure
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MURollCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:MURollCollectionViewCellID forIndexPath:indexPath];
    long itemIndex = [self pageControlIndexWithCurrentCellIndex:indexPath.row];
     NSString *imagePath = self.imagePathsGroup[itemIndex];
    
    //网络图片
    if ([imagePath isKindOfClass:[NSString class]]) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeHolderImage];
    }else if([imagePath isKindOfClass:[UIImage class]]){
        cell.imageView.image = (UIImage *)imagePath;
    }else{
        NSLog(@"图片数组不合法");
    }
    //设置cell
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(rollScrollView:didSelectItemAtIndex:)]) {
        [self.delegate rollScrollView:self didSelectItemAtIndex:[self pageControlIndexWithCurrentCellIndex:indexPath.item]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 解决清除timer时偶尔会出现的问题
    if (!self.imagePathsGroup.count) return;
    int itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    if ([self.pageControl isKindOfClass:[MUPageControl class]]) {
        MUPageControl *pageControl = _pageControl;
        pageControl.currentPage = indexOnPageControl;
    } else {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPage = indexOnPageControl;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self setupTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.mainCollectionView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    if ([self.delegate respondsToSelector:@selector(rollScrollView:didScrollToIndex:)]) {
        [self.delegate rollScrollView:self didScrollToIndex:indexOnPageControl];
    }
}

- (void)makeScrollViewScrollToIndex:(NSInteger)index{
    if (self.autoScroll) {
        [self invalidateTimer];
    }
    if (0 == _totalItemsCount) return;
    
    [self scrollToIndex:(int)(_totalItemsCount * 0.5 + index)];
    
    if (self.autoScroll) {
        [self setupTimer];
    }
}


#pragma mark 优化 bug解决
///卡顿问题解决方案
- (void)adjustWhenControllerViewWillAppera{
    long targetIndex = [self currentIndex];
    if (targetIndex < _totalItemsCount) {
        [_mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _mainCollectionView.delegate = nil;
    _mainCollectionView.dataSource = nil;
}

#pragma lazy
 
@end
