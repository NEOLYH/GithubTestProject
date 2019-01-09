//
//  HomeDetailViewController.m
//  Lu_MVP
//
//  Created by apple on 2018/11/30.
//  Copyright © 2018 apple. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "JLRoutes.h"
#import "JLRRouteResponse.h"

@interface HomeDetailViewController ()<JLRRouteHandlerTarget>
@property (nonatomic, copy) NSDictionary <NSString *, id> *parameters;

@end

@implementation HomeDetailViewController

- (instancetype)initWithRouteParameters:(NSDictionary <NSString *, id> *)parameters
{
    self = [super init];
    
    _parameters = [parameters copy]; // hold on to do something with later on
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    NSDictionary * dict =  JLRoutes.allRoutes;
    NSArray * Arr = [[JLRoutes globalRoutes] routes];
    NSLog(@"kkk:%@",dict);
    NSLog(@"jjjj:%@",Arr);
    JLRRouteResponse * response =  [JLRRouteResponse invalidMatchResponse];
   NSDictionary * dict1 =  response.parameters;
     NSLog(@"qqq:%@",dict1);
    
    NSLog(@"llll:%@",self.parameters);
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
