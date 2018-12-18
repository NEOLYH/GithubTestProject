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
     [self jumpRoutes];
    
    [[JLRoutes routesForScheme:@"RootMvp"] addRoute:@"/push/:controller" handler:^BOOL(NSDictionary<NSString *,NSString *> * _Nonnull parameters) {
        UIViewController *currentVc = [self currentViewController];
        UIViewController *v = [[NSClassFromString(parameters[@"controller"]) alloc] init];
        [self paramToVc:v param:parameters];
        [currentVc.navigationController pushViewController:v animated:YES];
        return YES;
    }];
    [self runApp];
    
    return YES;
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [[JLRoutes routesForScheme:@"RootMvp"] routeURL:url];
}

-(void)jumpRoutes{
    
//    //    app启动时资源占用率大，如果不异步执行，openUrl会延迟大约10s才被执行
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
//        NSString *customURL = @"Lu_MVP://Tabbar/CenterViewController/CommunityViewController/HomeViewController";
//        dispatch_async(dispatch_get_main_queue(), ^{
//             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
//        });
//    });
//
    [[JLRoutes routesForScheme:@"RootMvp"] addRoute:@"/:tab" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        return YES;
    }];
//
    //    navigation Push规则
    [[JLRoutes routesForScheme:@"RootMvp"] addRoute:@"/push/:controller" handler:^BOOL(NSDictionary<NSString *,NSString *> * _Nonnull parameters) {
        UIViewController *currentVc = [self currentViewController];
        UIViewController *v = [[NSClassFromString(parameters[@"controller"]) alloc] init];
        [self paramToVc:v param:parameters];
        [currentVc.navigationController pushViewController:v animated:YES];
        return YES;
    }];
    
//    //    StoryBoard Push规则
//    [[JLRoutes routesForScheme:@"Lu_MVP"] addRoute:@"/StoryBoardPush" handler:^BOOL(NSDictionary<NSString *,NSString *> * _Nonnull parameters) {
//        UIViewController *currentVc = [self currentViewController];
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:parameters[@"sbname"] bundle:nil];
//        UIViewController *v  = [storyboard instantiateViewControllerWithIdentifier:parameters[@"bundleid"]];
//        [self paramToVc:v param:parameters];
//        [currentVc.navigationController pushViewController:v animated:YES];
//        return YES;
//    }];
}

-(void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
    //        runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}

/**
 *          获取当前控制器
 */
-(UIViewController *)currentViewController{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
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
