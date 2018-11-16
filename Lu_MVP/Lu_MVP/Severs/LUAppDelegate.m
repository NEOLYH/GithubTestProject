//
//  LUAppDelegate.m
//  Lu_MVP
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018 apple. All rights reserved.
//

#import "LUAppDelegate.h"

@implementation LUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([super respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)])
    {
        [super application:application didFinishLaunchingWithOptions:launchOptions];
    }
    
    NSLog(@"////////");
     return YES;
}

//- (UIInterfaceOrientationMask)application:(UIApplication *)application
//  supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
//{
//    if ([super respondsToSelector:@selector(application:supportedInterfaceOrientationsForWindow:)])
//    {
//        return [super application:application supportedInterfaceOrientationsForWindow:window];
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}


#pragma mark - Service
// rootUI服务
+ (RootUIService*)getRootUIService
{
    return (RootUIService*)[[LUSeviceManager sharedManager] getAppService:@"rootUI"];
}

@end
