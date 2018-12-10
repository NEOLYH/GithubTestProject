//
//  LUTranstionAnimator.h
//  Lu_MVP
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LUInteractiveTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface LUTranstionAnimator : NSObject<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate,UITabBarControllerDelegate,LUInteractiveTransitionDelegate>
//to转场时间 默认0.5
@property(nonatomic,assign)NSTimeInterval toDuration;

//back转场时间 默认0.5
@property (nonatomic, assign) NSTimeInterval backDuration;

//是否需要开启手势timer，某些转场如果在转成过程中所开手指，不会有动画过渡，显得很生硬，开启timer后，松开手指，会用timer不断的刷新转场百分比，消除生硬的缺点
@property (nonatomic, assign) BOOL needInteractiveTimer;

/**
 *  配置To过程动画(push, present),自定义转场动画应该复写该方法
 */
- (void)lu_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;
/**
 *  配置back过程动画（pop, dismiss）,自定义转场动画应该复写该方法
 */
- (void)lu_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

@end

NS_ASSUME_NONNULL_END
