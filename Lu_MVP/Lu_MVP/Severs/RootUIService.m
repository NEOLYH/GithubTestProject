//
//  RootUIService.m
//  Lu_MVP
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018 apple. All rights reserved.
//
#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define ISIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define ISIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define ISIOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

#import "RootUIService.h"
#import "MVPTabBarController.h"
#import "LUAppDelegate.h"
#import "HomeViewController.h"
#import "CommunityViewController.h"
#import "CenterViewController.h"
#import "MVPNavigationController.h"
#import "UIColor+categary.h"
#import "Utilities.h"
#import "JLRoutes.h"
#import <objc/runtime.h>

@interface RootUIService ()
{
    NSArray * ViewControllerArray;
}
@end

@implementation RootUIService

ML_EXPORT_SERVICE(rootUI)


-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.shouldIgnorePushingViewControllers = NO;
    application.delegate.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    application.delegate.window.backgroundColor = [UIColor whiteColor];
    [self runApp];
    [application.delegate.window makeKeyAndVisible];
    
    if(!ISIOS7)
    {
        application.statusBarStyle = UIStatusBarStyleLightContent;
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    return YES;
}


-(void)runApp{
    [self showTabBar];
}

- (void)showTabBar {
    
    LUAppDelegate * delegate          = (LUAppDelegate*)[UIApplication sharedApplication].delegate;
    MVPTabBarController * customTabBarController = [[MVPTabBarController alloc] init];
    delegate.window.rootViewController  = customTabBarController;
}

- (void)showHome
{
    // 首页
    LUAppDelegate *appDelegate = (LUAppDelegate *)[UIApplication sharedApplication].delegate;
     MVPTabBarController * customTabBarController = [appDelegate customTabBarController];
    for (int i = 0; i < appDelegate.customTabBarController.viewControllers.count; i++) {
        UINavigationController *nav =
        [appDelegate.customTabBarController.viewControllers objectAtIndex:i];
        [nav popToRootViewControllerAnimated:NO];
    }
    customTabBarController.selectedIndex = 0;
}

//- (nonnull NSString *)serviceName {
//    return nil;
//}

@end
