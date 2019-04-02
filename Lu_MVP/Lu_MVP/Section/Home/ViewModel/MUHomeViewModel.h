//
//  MUHomeViewModel.h
//  LUMVP
//
//  Created by Faith on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

///发起网络请求状态
typedef  enum : NSUInteger{
    RefreshPullUp = 0, //刷新
    RefreshPullDown,   //加载
    RefreshNoPull      //从缓存中获取数据
} RefreshPullStyle;

NS_ASSUME_NONNULL_BEGIN

@interface MUHomeViewModel : NSObject
///视图模型数组
@property(nonatomic, strong)NSMutableArray * listArray;

///轮播图数据源
@property(nonatomic, strong)NSMutableArray * bannerArray;
/**
 加载数据
 @param style 请求状态
 @param completed 完成回调
 */
-(void)loadDataWithState:(RefreshPullStyle)style completed:(void(^)(BOOL isSuccessed))completed;

@end

NS_ASSUME_NONNULL_END
