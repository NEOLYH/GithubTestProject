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

/**
 主窗口展示tabBar
 */
-(void)showTabBar;

/**
 主窗口展示tabBar
 
 @param index tabBar需要选中的item索引
 */
-(void)showTabBarWithIndex:(int)index;


/**
 主窗口展示欢迎页面
 */
- (void)showWelcome;

/**
 主窗口展示登录页面
 */
- (void)showLogin;


/**
 展示首页
 */
- (void)showHome;

@end


NS_ASSUME_NONNULL_END
