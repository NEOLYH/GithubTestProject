//
//  CircleSpreadAnimator.h
//  Lu_MVP
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "LUTranstionAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleSpreadAnimator : LUTranstionAnimator
/**
 *  返回一个小圆点扩散转场效果器
 *
 *  @param point  扩散开始中心
 *  @param radius 扩散开始的半径
 *
 *  @return 小圆点扩散转场效果器
 */
+ (instancetype)lu_animatorWithStartCenter:(CGPoint)point radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
