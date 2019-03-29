#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TABAnimated.h"
#import "TABAnimatedObject.h"
#import "TABAnimationMethod.h"
#import "TABBaseCollectionViewCell.h"
#import "TABBaseTableViewCell.h"
#import "TABManagerMethod+ManagerCALayer.h"
#import "TABManagerMethod.h"
#import "TABViewAnimated.h"
#import "UICollectionView+Animated.h"
#import "UICollectionViewCell+TABLayoutSubviews.h"
#import "UITableView+Animated.h"
#import "UITableViewCell+TABLayoutSubviews.h"
#import "UIView+Animated.h"
#import "UIView+TABControlAnimation.h"
#import "UIView+TABLayoutSubviews.h"

FOUNDATION_EXPORT double TABAnimatedVersionNumber;
FOUNDATION_EXPORT const unsigned char TABAnimatedVersionString[];

