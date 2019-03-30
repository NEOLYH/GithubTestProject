//
//  MURollScrollView.h
//  LUMVP
//
//  Created by Faith on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MURollScrollView;
NS_ASSUME_NONNULL_BEGIN

typedef  enum : NSUInteger{
    PageControlMiddle = 0,
    PageControlRight,
    PageControlLeft
} MUPageControlLocation;

@protocol MURollScrollViewDelegate <NSObject>
@optional

/**
 点击图片回调
 @param rollScrollView view
 @param index 点击索引
 */
-(void)rollScrollView:(MURollScrollView *)rollScrollView didSelectItemAtIndex:(NSInteger)index;


/**
 滚动图片代理
 @param rollScrollView view
 @param index 滚动处索引
 */
-(void)rollScrollView:(MURollScrollView *)rollScrollView didScrollToIndex:(NSInteger)index;


@end

@interface MURollScrollView : UIView

///本地图片数组
@property(nonatomic, strong)NSArray * locationImageArray;
///网络图片数组
@property(nonatomic, strong)NSArray * onlineImageArray;
///图片需要显示的文字数组
@property(nonatomic, strong)NSArray * titlesArray;

///是否无限循环默认YES
@property(nonatomic, assign)BOOL infiniteLoop;
///是否自动滚动默认为YES
@property(nonatomic, assign)BOOL autoScroll;
///图片滚动默认时间间隔默认2s
@property(nonatomic, assign)CGFloat autoScrollTimeInterval;
///图片滚动方向默认为水平方向
@property(nonatomic, assign)UICollectionViewScrollDirection scrollDirection;

///是否显示分页控件
@property(nonatomic, assign)BOOL showPageControl;
///未加载出网络图片时展示的展位图
@property(nonatomic, strong)UIImage * placeHolderImage;
///只有一张图是隐藏pageCotrol 默认为YES
@property(nonatomic, assign)BOOL hidesForSinglePage;
///控件位置
@property(nonatomic, assign)MUPageControlLocation pageControlLocation;
///代理
@property(nonatomic, weak)id<MURollScrollViewDelegate>delegate;

/**
 清楚图片缓存
 */
-(void)clearImageCache;

/**
 初始化轮播图
 @param frame 初始化方法
 @param delegate 代理
 @param placeHolderImage 占位图片
 @return 轮播图
 */
+(instancetype)rollScrollViewWithFrame:(CGRect)frame delegate:(id<MURollScrollViewDelegate>)delegate placeHolderImage:(UIImage *)placeHolderImage;

/** 解决viewWillAppear时出现时轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法 */
- (void)adjustWhenControllerViewWillAppera;

@end

NS_ASSUME_NONNULL_END
