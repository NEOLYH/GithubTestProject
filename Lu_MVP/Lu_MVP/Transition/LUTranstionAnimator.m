//
//  LUTranstionAnimator.m
//  Lu_MVP
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "LUTranstionAnimator.h"
#import <objc/runtime.h>
#import <objc/message.h>

#pragma mark - 私有转场动画管理者
typedef void  (^LUTransitionAnimationConfig)(id<UIViewControllerContextTransitioning> transitionContext);

@interface _LUTransitionObject : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype)_initObjectWithDuration:(NSTimeInterval)duration animationBlock:(void(^)(id<UIViewControllerContextTransitioning> transitionContext)) config;
@end

@implementation _LUTransitionObject{
    NSTimeInterval _duration;
    LUTransitionAnimationConfig _config;
}

- (instancetype)_initObjectWithDuration:(NSTimeInterval)duration animationBlock:(LUTransitionAnimationConfig)config{
    self = [super init];
    if (self) {
        _duration = duration;
        _config = config;
    }
    return self;
}

#pragma mark - <UIViewControllerAnimatedTransitioning>
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _duration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (_config) {
        _config(transitionContext);
    }
}

@end

@interface LUTranstionAnimator ()
@property (nonatomic, strong) _LUTransitionObject * toTransition;
@property (nonatomic, strong) _LUTransitionObject * backTransition;
@property (nonatomic, strong) LUInteractiveTransition *toInteractive;
@property (nonatomic, strong) LUInteractiveTransition *backInteractive;
@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, assign) BOOL toType;
@end

@implementation LUTranstionAnimator

- (instancetype)init{
    self = [super init];
    if (self) {
        _toDuration = _backDuration = 0.5f;
    }
    return self;
}

- (_LUTransitionObject *)toTransition{
    if (!_toTransition) {
        __weak typeof(self)weakSelf = self;
        _toTransition = [[_LUTransitionObject alloc] _initObjectWithDuration:_toDuration animationBlock:^(id<UIViewControllerContextTransitioning> transitionContext) {
            [weakSelf lu_setToAnimation:transitionContext];
        }];
    }
    return _toTransition;
}

- (_LUTransitionObject *)backTransition{
    if (!_backTransition) {
        __weak typeof(self)weakSelf = self;
        _backTransition = [[_LUTransitionObject alloc] _initObjectWithDuration:_backDuration animationBlock:^(id<UIViewControllerContextTransitioning> transitionContext) {
            [weakSelf lu_setBackAnimation:transitionContext];
        }];
    }
    return _backTransition;
}

- (void)setToInteractive:(LUInteractiveTransition *)toInteractive{
    _toInteractive = toInteractive;
    toInteractive.delegate = self;
    toInteractive.timerEable = _needInteractiveTimer;
}

- (void)setBackInteractive:(LUInteractiveTransition *)backInteractive{
    _backInteractive = backInteractive;
    backInteractive.delegate = self;
    backInteractive.timerEable = _needInteractiveTimer;
}

-(void)lu_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
//    交给子类实现
}

-(void)lu_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
//    交给子类实现
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.toTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.backTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.backInteractive.interation ? self.backInteractive : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.toInteractive.interation ? self.toInteractive : nil;
}

#pragma mark - <UINavigationControllerDelegate>

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _operation = operation;
    return operation == UINavigationControllerOperationPush ? self.toTransition : self.backTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    LUInteractiveTransition *inter = _operation == UINavigationControllerOperationPush ? self.toInteractive : self.backInteractive;
    return inter.interation ? inter : nil;
}


@end
