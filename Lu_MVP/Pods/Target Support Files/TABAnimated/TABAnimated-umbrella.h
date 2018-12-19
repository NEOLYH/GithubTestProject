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
#import "TABMethod.h"
#import "TABViewAnimated.h"
#import "UITableView+Animated.h"
#import "UITableViewCell+Animated.h"
#import "UIView+Animated.h"
#import "UIView+TABLayerout.h"

FOUNDATION_EXPORT double TABAnimatedVersionNumber;
FOUNDATION_EXPORT const unsigned char TABAnimatedVersionString[];

