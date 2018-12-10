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

@implementation LUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([super respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)])
    {
        [super application:application didFinishLaunchingWithOptions:launchOptions];
    }
    
    [[JLRoutes routesForScheme:@"Lu_MVP"] addRoute:@"/push/:controller" handler:^BOOL(NSDictionary<NSString *,NSString *> * _Nonnull parameters) {
//        UIViewController *currentVc = [self currentViewController];
//        UIViewController *v = [[NSClassFromString(parameters[@"controller"]) alloc] init];
//        [self paramToVc:v param:parameters];
//        [currentVc.navigationController pushViewController:v animated:YES];
        Class class = NSClassFromString(parameters[@"controller"]);
        
        UIViewController *nextVC = [[class alloc] init];
        
        [self paramToVc:nextVC param:parameters];
        UIViewController *currentVc = [self currentViewController];
        [currentVc.navigationController pushViewController:nextVC animated:YES];
        return YES;
    }];
    
     return YES;
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [[JLRoutes routesForScheme:@"Lu_MVP"] routeURL:url];
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

#pragma mark - Service
// rootUI服务
+ (RootUIService*)getRootUIService
{
    return (RootUIService*)[[LUSeviceManager sharedManager] getAppService:@"rootUI"];
}

@end
