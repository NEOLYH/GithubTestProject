//
//  LUAppDelegate.m
//  Lu_MVP
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018 apple. All rights reserved.
//

#import "LUAppDelegate.h"
#import "JLRoutes.h"
#import <objc/runtime.h>
#import "MVPTabBarController.h"

@implementation LUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([super respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)])
    {
        [super application:application didFinishLaunchingWithOptions:launchOptions];
    }
     return YES;
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    return [[JLRoutes globalRoutes] routeURL:url];
}

#pragma mark - Service
// rootUI服务
+ (RootUIService*)getRootUIService
{
    return (RootUIService*)[[LUSeviceManager sharedManager] getAppService:@"rootUI"];
}

@end
