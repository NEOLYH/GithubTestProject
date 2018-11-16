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

@interface RootUIService ()
{
    NSArray * ViewControllerArray;
}
@end

@implementation RootUIService

ML_EXPORT_SERVICE(rootUI)


-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"123*****");
    self.shouldIgnorePushingViewControllers = NO;
    application.delegate.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    application.delegate.window.backgroundColor = [UIColor whiteColor];
    [application.delegate.window makeKeyAndVisible];
    
    if(!ISIOS7)
    {
        application.statusBarStyle = UIStatusBarStyleLightContent;
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    [self runApp];
    
    return YES;
}

-(void)runApp{
    NSLog(@"有没有执行了runapp");
    MVPTabBarController * vc = [[MVPTabBarController alloc ] init];
    LUSeverDelegate *delegate = (LUSeverDelegate*)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController =  vc;
    [self showTabBar];
}

- (void)showTabBar {
    
    [self createTab];
    
    LUAppDelegate * delegate          = (LUAppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.customTabBarController.tabBar.hidden = NO;
    delegate.window.rootViewController  = delegate.customTabBarController;
}

#pragma mark - tab
- (void)createTab {
    
    // 首页
//    ChannelBaseHomeVC *channelHomeController  = [[ChannelBaseHomeVC alloc]init];
//    SafeUINavigationController *navChannelHome = [[SafeUINavigationController alloc] initWithRootViewController:channelHomeController];
//    navChannelHome.delegate                    = self;
    
    
  
    
    LUAppDelegate * delegate          = (LUAppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.customTabBarController     = [[MVPTabBarController alloc] init];
//    delegate.customTabBarController.delegate = self;
    
    HomeViewController * homeVc  = [[HomeViewController alloc] init];
    MVPNavigationController * navHome = [[MVPNavigationController alloc] initWithRootViewController:homeVc];
    
    CenterViewController * centerVc = [[CenterViewController alloc] init];
    MVPNavigationController * navCenter = [[MVPNavigationController alloc] initWithRootViewController:centerVc];
    
    CommunityViewController * commVC = [[CommunityViewController alloc] init];
    MVPNavigationController * navComm  = [[MVPNavigationController alloc] initWithRootViewController:commVC];
    
    
    
    ViewControllerArray                 = [NSArray arrayWithObjects:navHome, navCenter, navComm, nil];
    
    delegate.customTabBarController.viewControllers = ViewControllerArray;
    
    [self refreshTabbarActivity];
}

- (void)refreshTabbarActivity {
    
    LUAppDelegate * delegate = (LUAppDelegate*)[UIApplication sharedApplication].delegate;
//    NSArray *dataImageArray = [[HomeDatabaseManager getDatabaseManager] getTabberImage];
    
    
    NSArray *dataImageArray = @[
    @{@"disableImage":@"tabbar_home",@"image":@"tabbar_home_selected"},@{@"disableImage":@"tabbar_message_center",@"image":@"tabbar_message_center_selected"},
@{@"disableImage":@"tabbar_profile",@"image":@"tabbar_profile_selected"}];
    
    if ([Utilities isValidArray:dataImageArray])
    {
        if ([Utilities isValidArray:delegate.customTabBarController.viewControllers])
        {
            __weak RootUIService *weakSelf = self;
            [dataImageArray enumerateObjectsUsingBlock:
             ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
             {
                 __strong RootUIService *strongSelf = weakSelf;
                 [strongSelf setTabberImageWithController:
                  delegate.customTabBarController.viewControllers[idx] array:dataImageArray index:idx];
             }];
        }
    }
}

- (void)setTabberImageWithController:(UIViewController *)controller
                               array:(NSArray *)array
                               index:(NSUInteger )index {
    
    LUAppDelegate * delegate          = (LUAppDelegate*)[UIApplication sharedApplication].delegate;
    if ([Utilities isValidArray:array]) {
        
        controller.tabBarItem.image = [[UIImage imageNamed:[array objectAtIndex:index][@"disableImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
        //选中
        controller.tabBarItem.selectedImage = [[UIImage imageNamed:[array objectAtIndex:index][@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
        controller.tabBarItem.title = [array objectAtIndex:index][@"name"];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor getColor:@"21c2b8"], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor getColor:@"7a7e82"], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [delegate.customTabBarController.tabBar setBackgroundColor:[UIColor whiteColor]];
        //            [delegate.customTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"nav_head"]];
        [delegate.customTabBarController.tabBar setClipsToBounds:YES];
    }
}
//- (nonnull NSString *)serviceName {
//    return nil;
//}

@end
