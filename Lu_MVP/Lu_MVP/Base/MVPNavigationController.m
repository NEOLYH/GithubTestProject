//
//  MVPNavigationController.m
//  Lu_MVP
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MVPNavigationController.h"
#import "LUAppDelegate.h"

@interface MVPNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation MVPNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        NSString *title = @"";
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
        viewController.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back"];
        [viewController.navigationItem.leftBarButtonItem setTintColor:[UIColor blackColor]];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)goBack{
    [self popViewControllerAnimated:YES];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count > 1;
}
@end
