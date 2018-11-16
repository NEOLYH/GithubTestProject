//
//  RootUIService.h
//  Lu_MVP
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUSeverDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface RootUIService : NSObject <LUService,UINavigationControllerDelegate>


@property(nonatomic,assign) BOOL shouldIgnorePushingViewControllers;
@property(nonatomic,assign) BOOL isFull;// 是否全屏

-(void)showTabBar;

-(void)showTabBarWithIndex:(int)index;

- (void)showWelcome;
- (void)showLogin;
- (void)showHome;

@end

NS_ASSUME_NONNULL_END
