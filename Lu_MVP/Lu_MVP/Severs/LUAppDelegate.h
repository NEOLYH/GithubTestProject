//
//  LUAppDelegate.h
//  Lu_MVP
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootUIService.h"

NS_ASSUME_NONNULL_BEGIN

@class MVPTabBarController;

@interface LUAppDelegate : LUSeverDelegate <UIApplicationDelegate>
@property(nonatomic, strong) MVPTabBarController * customTabBarController;
// rootUI服务
+ (RootUIService*)getRootUIService;

@end

NS_ASSUME_NONNULL_END
