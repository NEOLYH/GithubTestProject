//
//  LUInteractiveTransition.m
//  Lu_MVP
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "LUInteractiveTransition.h"
#import <objc/runtime.h>

typedef struct {
    unsigned int willBegin : 1;
    unsigned int isUpdating : 1;
    unsigned int willBeginTimer: 1;
    unsigned int willEnd : 1;
} delegateFlag;

@interface LUInteractiveTransition()<UIGestureRecognizerDelegate>
@property(nonatomic,assign) LUInteractiveTransitionGestureDirection direction;
@property(nonatomic,copy) void(^config)(CGPoint startPoint);
@property(nonatomic,strong) CADisplayLink * timer;
@property(nonatomic,assign) CGFloat percent;
@property(nonatomic,assign) CGFloat timeDis;
@property(nonatomic,assign) delegateFlag delegateFlag;
@property(nonatomic,assign) BOOL vertical;
@property(nonatomic,assign) CGFloat edgeSpacing;
@end

@implementation LUInteractiveTransition

+ (instancetype)lu_interactiveTranstionWithDirection:(LUInteractiveTransitionGestureDirection)direction
                                              config:(void(^)(CGPoint startPoint))config edgeSpacing:(CGFloat)edgeSpacing{
    return [[self alloc] _initInteractiveTransitionWithDirection:direction config:config edgeSpacing:edgeSpacing];
}

-(instancetype)_initInteractiveTransitionWithDirection:(LUInteractiveTransitionGestureDirection)direction config:(void (^)(CGPoint startPoint))config edgeSpacing:(CGFloat)edgeSpacing{
    self = [super init];
    if (self) {
        _config = config;
        _direction = direction;
        _edgeSpacing = edgeSpacing;
        _vertical = direction == LUInteractiveTransitionGestureDirectionDown || direction == LUInteractiveTransitionGestureDirectionUp;
    }
    return  self;
}

-(void)setDelegate:(id<LUInteractiveTransitionDelegate>)delegate{
    _delegate = delegate;
    _delegateFlag.willBegin = _delegate && [_delegate respondsToSelector:@selector(lu_interactiveTransitionWillBegin:)];
    _delegateFlag.isUpdating = _delegate && [_delegate respondsToSelector:@selector(lu_interactiveTransition:isUpdating:)];
    _delegateFlag.willBeginTimer = _delegate && [_delegate respondsToSelector:@selector(lu_interactiveTransitionWillBeginTimerAnimation:)];
    _delegateFlag.willEnd = _delegate && [_delegate respondsToSelector:@selector(lu_interactiveTransition:willEndWithSuccessFlag:percent:)];
}

- (void)lu_addPanGestureForView:(UIView *)view to:(BOOL)flag{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_lu_handleGesture:)];
    pan.delegate = self;
    NSString * panType = flag ? @"lu_interactiveToPan": @"lu_interactiveBackPan";
    objc_setAssociatedObject(pan, "lu_interactivePanKey", panType, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [view addGestureRecognizer:pan];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (_edgeSpacing <= 0) {
        return YES;
    }
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    BOOL should = NO;
    switch (_direction) {
        case LUInteractiveTransitionGestureDirectionLeft:{
            should = point.x >= gestureRecognizer.view.frame.size.width - _edgeSpacing;
          break;
        }
        case LUInteractiveTransitionGestureDirectionRight:{
            should = point.x <= _edgeSpacing;
            break;
        }
        case LUInteractiveTransitionGestureDirectionUp:{
            should = point.y >= gestureRecognizer.view.frame.size.height - _edgeSpacing;
            break;
        }
        case LUInteractiveTransitionGestureDirectionDown:{
            should = point.y <= _edgeSpacing;
            break;
        }
    }
    return should;
}

/**
 *  手势过渡的过程
 */
- (void)_lu_handleGesture:(UIPanGestureRecognizer *)panGesture{
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            if (_delegateFlag.willBegin) {
                [_delegate lu_interactiveTransitionWillBegin:self];
            }
            CGPoint startPoint = [panGesture locationInView:panGesture.view];
            _interation = YES;
            if (_config) {
                _config(startPoint);
            }
            [self _lu_caculateMovePercentForGesture:panGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            [self _lu_caculateMovePercentForGesture:panGesture];
            [self _lu_updatingWithPercent:_percent];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //判断是否需要timer
            if (!_timerEable) {
                _percent >= 0.5 ? [self _lu_finish] : [self _lu_cancle];
                return;
            }
            //判断此时是否已经转场完成，大于1或者小于0
            BOOL canEnd = [self _lu_canEndInteractiveTransitionWithPercent:_percent];
            if (canEnd) return;
            //开启timer
            [self _lu_setEndAnimationTimerWithPercent:_percent];
            break;
        }
            
        default:
            break;
    }
}

- (BOOL)_lu_canEndInteractiveTransitionWithPercent:(CGFloat)percent{
    BOOL can = NO;
    if (percent >= 1) {
        [self _lu_finish];
        can = YES;
    }
    if (percent <= 0) {
        [self _lu_cancle];
        can = YES;
    }
    return can;
}

- (void)_lu_caculateMovePercentForGesture:(UIPanGestureRecognizer *)panGesture{
    static CGFloat baseValue = 0.0f;
    baseValue = _panRatioBaseValue > 0 ? _panRatioBaseValue : _vertical ? panGesture.view.frame.size.height : panGesture.view.frame.size.width;
    //手势百分比
    switch (_direction) {
        case LUInteractiveTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            _percent += transitionX / baseValue;
        }
            break;
        case LUInteractiveTransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            _percent += transitionX / baseValue;
        }
            break;
        case LUInteractiveTransitionGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            _percent += transitionY / baseValue;
        }
            break;
        case LUInteractiveTransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            _percent += transitionY / baseValue;
        }
            break;
    }
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}

//设置开启timer
- (void)_lu_setEndAnimationTimerWithPercent:(CGFloat)percent{
    _percent = percent;
    //根据失败还是成功设置刷新间隔
    if (percent > 0.5) {
        _timeDis = (1 - percent) / ((1 - percent) * 60);
    }else{
        _timeDis = percent / (percent * 60);
    }
    if (_delegateFlag.willBeginTimer) {
        [_delegate lu_interactiveTransitionWillBeginTimerAnimation:self];
    }
    //开启timer
    [self _lu_startTimer];
}

- (void)_lu_finish{
    if (_delegateFlag.willEnd) {
        [_delegate lu_interactiveTransition:self willEndWithSuccessFlag:YES percent:_percent];
    }
    [self finishInteractiveTransition];
    _percent = 0.0f;
    _interation = NO;
}

- (void)_lu_cancle{
    if (_delegateFlag.willEnd) {
        [_delegate lu_interactiveTransition:self willEndWithSuccessFlag:NO percent:_percent];
    }
    [self cancelInteractiveTransition];
    _percent = 0.0f;
    _interation = NO;
}

- (void)_lu_updatingWithPercent:(CGFloat)percent{
    [self updateInteractiveTransition:percent];
    if (_delegateFlag.isUpdating) {
        [_delegate lu_interactiveTransition:self isUpdating:_percent];
    }
}

- (void)_lu_startTimer{
    if (_timer) {
        return;
    }
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(_lu_timerEvent)];
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)_lu_stopTimer{
    if (!_timer) {
        return;
    }
    [_timer invalidate];
    _timer = nil;
    
}

//timer 事件
- (void)_lu_timerEvent{
    if (_percent > 0.5) {
        _percent += _timeDis;
    }else{
        _percent -= _timeDis;
    }
    //通过timer不断刷新转场进度
    [self _lu_updatingWithPercent:_percent];
    BOOL canEnd = [self _lu_canEndInteractiveTransitionWithPercent:_percent];
    if (canEnd) {
        [self _lu_stopTimer];
    }
}


@end
