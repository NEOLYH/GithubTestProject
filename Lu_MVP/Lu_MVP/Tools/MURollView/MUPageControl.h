//
//  MUPageControl.h
//  LUMVP
//
//  Created by Faith on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MUPageControl;
NS_ASSUME_NONNULL_BEGIN

@protocol MUPageControlDelegate <NSObject>
@optional
/**
 选中control代理方法
 @param pageControl 控件
 @param index select item
 */
-(void)pageControl:(MUPageControl *)pageControl selectedItem:(NSInteger)index;

@end

@interface MUPageControl : UIControl

///其他点是高度的倍数,默认1
@property(nonatomic) NSInteger otherMultiple;
///当前点h是高度的倍数,默认2
@property(nonatomic) NSInteger currentMultiple;

///分页数量
@property(nonatomic) NSInteger numberOfPages;

///当前点所在下标
@property(nonatomic) NSInteger currentPage;

///点的大小
@property(nonatomic) NSInteger controlSize;

///点的间距
@property(nonatomic) NSInteger controlSpacing;

///其他未选中点颜色
@property(nonatomic,strong) UIColor *otherColor;

/// 当前点颜色
@property(nonatomic,strong) UIColor *currentColor;

///当前点背景图片
@property(nonatomic,strong) UIImage *currentBkImg;

///其他点背景图片
@property(nonatomic,strong) UIImage *otherBkImg;

///选中代理
@property(nonatomic, weak)id<MUPageControlDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
