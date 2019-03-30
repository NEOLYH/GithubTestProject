//
//  HomeViewController.m
//  Lu_MVP
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "JLRoutes.h"
#import "MVPNavigationController.h"
#import "MUHomeViewModel.h"
#import "MUHomeTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "MURollScrollView.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,MURollScrollViewDelegate>
@property(nonatomic, strong)MUHomeViewModel * muHomeViewModel;
@property(nonatomic, strong)UITableView * listTableView;
@property(nonatomic, strong)MURollScrollView * headBannerView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    [self.view addSubview:self.listTableView];
    self.listTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self loadDataWithStates:YES];
    }];
    self.listTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadDataWithStates:NO];
    }];
    [self loadDataWithStates:YES];
    
    [self initation];
}

-(void)initation{
    self.listTableView.tableHeaderView = self.headBannerView;
    self.headBannerView.onlineImageArray = @[@"https://p1.music.126.net/DRId4yElK6Po15SswbFvrA==/65970697683620.jpg?param=250y250",@"https://p1.music.126.net/suco52xu0lv3dhykrrL_vg==/65970697667610.jpg?param=250y250",@"https://p1.music.126.net/Ajn-819hYNmrj1Atan0UIg==/67070209295390.jpg?param=250y250"];
    self.headBannerView.autoScrollTimeInterval = 4.0;
}

-(void)loadDataWithStates:(BOOL)states{
    
    [self.muHomeViewModel loadDataWithState:states completed:^(BOOL isSuccessed) {
        if (isSuccessed) {
            
        }
        [self.listTableView.mj_header setState:MJRefreshStateIdle];
        [self.listTableView.mj_footer setState:MJRefreshStateIdle];
        [self.listTableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.muHomeViewModel.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MUHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MUHomeTableViewCellID forIndexPath:indexPath];
    MUHomeModel * viewModel = self.muHomeViewModel.listArray[indexPath.row];
    cell.viewModel = viewModel;
    return cell;
}

#pragma 懒加载属性
-(MUHomeViewModel *)muHomeViewModel{
    if(!_muHomeViewModel){
        _muHomeViewModel = [[MUHomeViewModel alloc] init];
    }
    return _muHomeViewModel;
}

-(UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_listTableView registerClass:[MUHomeTableViewCell class] forCellReuseIdentifier:MUHomeTableViewCellID];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.estimatedRowHeight = 100;
        _listTableView.rowHeight = UITableViewAutomaticDimension;
        _listTableView.tableFooterView = [[UIView alloc] init];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
    }
    return _listTableView;
}

-(MURollScrollView *)headBannerView{
    if (!_headBannerView) {
        _headBannerView = [MURollScrollView rollScrollViewWithFrame:CGRectMake(25, 0, [UIScreen mainScreen].bounds.size.width - 50, 100) delegate:self placeHolderImage:[UIImage imageNamed:@"back"]];
    }
    return _headBannerView;
}

@end
