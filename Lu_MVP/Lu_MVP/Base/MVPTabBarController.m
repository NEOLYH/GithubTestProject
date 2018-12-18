//
//  MVPTabBarController.m
//  Lu_MVP
//
//  Created by apple on 2018/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MVPTabBarController.h"
#import "CenterViewController.h"
#import "HomeViewController.h"
#import "CommunityViewController.h"
#import "MVPNavigationController.h"
#import "LUAppDelegate.h"
#import "UIColor+categary.h"
#import "JLRoutes.h"
#import <objc/runtime.h>
#import "Utilities.h"

@interface MVPTabBarController ()

@end

@implementation MVPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    HomeViewController * homeVc  = [[HomeViewController alloc] init];
    MVPNavigationController * navHome = [[MVPNavigationController alloc] initWithRootViewController:homeVc];
    
    CenterViewController * centerVc = [[CenterViewController alloc] init];
    MVPNavigationController * navCenter = [[MVPNavigationController alloc] initWithRootViewController:centerVc];
  
    CommunityViewController * commVC = [[CommunityViewController alloc] init];
    MVPNavigationController * navComm  = [[MVPNavigationController alloc] initWithRootViewController:commVC];
    
    [self addChildViewController:navHome];
    [self addChildViewController:navCenter];
    [self addChildViewController:navComm];
    
    [[JLRoutes globalRoutes] addRoute:@"/:toController/:paramOne/:paramTwo/:paramThree/:paramFour" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        Class class = NSClassFromString(parameters[@"toController"]);
        UIViewController *vc = [[class alloc]init];
        NSURL *headUrl = parameters[JLRouteURLKey];
        NSString *head = [headUrl.absoluteString componentsSeparatedByString:@"://"].firstObject;
        if ([head isEqualToString:@"LUMVPOne"]) {
            
            [navHome pushViewController:vc animated:YES];
           
        }else if ([head isEqualToString:@"LUMVPTwo"]){
            [navCenter pushViewController:vc animated:YES];
            navCenter.hidesBottomBarWhenPushed = YES;
        }else if([head isEqualToString:@"LUMVPThree"]){
            [navComm pushViewController:vc animated:YES];
            navComm.hidesBottomBarWhenPushed = YES;
        }
        
        return YES;
    }];
    
    [self refreshTabbarActivity];
}

- (void)refreshTabbarActivity {
    
    
    NSArray *dataImageArray = @[
                                @{@"disableImage":@"tabbar_home",@"image":@"tabbar_home_selected"},@{@"disableImage":@"tabbar_message_center",@"image":@"tabbar_message_center_selected"},
  @{@"disableImage":@"tabbar_profile",@"image":@"tabbar_profile_selected"}];
    
    if ([Utilities isValidArray:dataImageArray])
    {
        if ([Utilities isValidArray:self.viewControllers])
        {
            __weak MVPTabBarController * weakSelf = self;
            [dataImageArray enumerateObjectsUsingBlock:
             ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
             {
                 [weakSelf setTabberImageWithController:
                  weakSelf.viewControllers[idx] array:dataImageArray index:idx];
             }];
        }
    }
}


- (void)setTabberImageWithController:(UIViewController *)controller
                               array:(NSArray *)array
                               index:(NSUInteger )index {
    
 
    if ([Utilities isValidArray:array]) {
        
        controller.tabBarItem.image = [[UIImage imageNamed:[array objectAtIndex:index][@"disableImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
        //选中
        controller.tabBarItem.selectedImage = [[UIImage imageNamed:[array objectAtIndex:index][@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
        controller.tabBarItem.title = [array objectAtIndex:index][@"name"];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor getColor:@"21c2b8"], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor getColor:@"7a7e82"], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [self.tabBar setBackgroundColor:[UIColor whiteColor]];
        [self.tabBar setClipsToBounds:YES];
    }
}

@end
