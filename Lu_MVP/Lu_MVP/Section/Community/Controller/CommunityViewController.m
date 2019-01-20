//
//  CommunityViewController.m
//  Lu_MVP
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityViewModel.h"
#import "Community.h"
#import "CommunityCellData.h"
#import "CommunityModel.h"
#import "CommunityEngine.h"

@interface CommunityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * communityTableView;
@property(nonatomic,strong)WMGBaseViewModel * viewModel;
@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.communityTableView];
    _viewModel = [[CommunityViewModel alloc] init];
    __weak typeof(self) weakSelf = self;
    [_viewModel reloadDataWithParams:@{} completion:^(NSArray<WMGBaseCellData *> *cellLayouts, NSError *error) {
        if (weakSelf) {
            [weakSelf.communityTableView reloadData];
        }
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WMGBaseCellData * cellData = [_viewModel.arrayLayouts objectAtIndex:indexPath.row];
    
    return cellData.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WMGBaseCellData * cellData = [_viewModel.arrayLayouts objectAtIndex:indexPath.row];
    WMGBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellData.cellClass)];
    if (!cell) {
        cell = [(WMGBaseCell *)[cellData.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(cellData.cellClass)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (!cell) {
        cell = [[WMGBaseCell alloc] init];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.arrayLayouts.count;
}

-(UITableView *)communityTableView{
    if (!_communityTableView) {
        _communityTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _communityTableView.delegate = self;
        _communityTableView.dataSource = self;
        _communityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _communityTableView.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
    }
    return _communityTableView;
}


@end
