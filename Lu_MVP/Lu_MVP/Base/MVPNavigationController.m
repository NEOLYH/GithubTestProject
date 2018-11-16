//
//  MVPNavigationController.m
//  Lu_MVP
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MVPNavigationController.h"
#import "LUAppDelegate.h"

@implementation MVPNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (animated) {
        
        if (![LUAppDelegate getRootUIService].shouldIgnorePushingViewControllers) {
            
            [super pushViewController:viewController animated:animated];
        }
        
        [LUAppDelegate getRootUIService].shouldIgnorePushingViewControllers = YES;
    }
    else {
        
        [super pushViewController:viewController animated:animated];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    
    return [super popToRootViewControllerAnimated:animated];
}

@end
