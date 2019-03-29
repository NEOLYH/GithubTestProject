//
//  MUHomeViewModel.h
//  LUMVP
//
//  Created by Faith on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUHomeViewModel : NSObject

///视图模型数组
@property(nonatomic, strong)NSMutableArray * listArray;

/**
 加载数据
 @param isPullUp 加载动作刷新 加载
 @param completed 完成回调
 */
-(void)loadDataWithState:(BOOL)isPullUp completed:(void(^)(BOOL isSuccessed))completed;

@end

NS_ASSUME_NONNULL_END
