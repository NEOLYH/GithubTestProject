//
//  CommunityViewController.m
//  Lu_MVP
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CommunityViewController.h"

@interface CommunityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * communityTableView;
@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableView *)communityTableView{
    if (!_communityTableView) {
        _communityTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _communityTableView.delegate = self;
        _communityTableView.dataSource = self;
    }
    return _communityTableView;
}


@end
