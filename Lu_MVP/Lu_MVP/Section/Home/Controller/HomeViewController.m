//
//  HomeViewController.m
//  Lu_MVP
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "AnimateView.h"

@interface HomeViewController ()
@property(nonatomic,strong) AnimateView * animateView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
//    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 110)];
//    button.backgroundColor = [UIColor redColor];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.animateView];
}

-(void)go{
    NSString * url = JLRoutesJumpUrl(@"LUMVPOne", @"HomeDetailViewController", @"123", nil, nil, nil);
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{@"name":@"456"} completionHandler:nil];
    }
}

#pragma mark --lazy--
-(AnimateView *)animateView{
    if (!_animateView) {
        _animateView = [[AnimateView alloc] initWithFrame:self.view.bounds];
        _animateView.backgroundColor = [UIColor whiteColor];
    }
    return _animateView;
}

@end
