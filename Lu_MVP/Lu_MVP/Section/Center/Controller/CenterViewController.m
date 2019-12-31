//
//  CenterViewController.m
//  Lu_MVP
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CenterViewController.h"
#import "MusicPresenter.h"
#import "MusicEntity.h"
#import "MJExtension.h"
#import "MusicListView.h"
#import "MUPopupView.h"

@interface CenterViewController ()<MusicProtocol>
@property(nonatomic, strong) MusicPresenter * musicPresenter;
@property(nonatomic, strong) MusicListView * MusicListView;
@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.musicPresenter getMusicListWithUrlString:@"" param:@{}];
    [self.view addSubview:self.MusicListView];
    
//    UIImageView * img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sey-more"]];

    UIButton * button = [[UIButton alloc] init];
    [button setTitle:@"论言" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
}

-(void)moreAction{
    
    MUPopupView *popupView = [[MUPopupView alloc]initWithItemButton:self.navigationItem.rightBarButtonItem modelArray:@[@{@"text":@"月上枝头",@"image":@"modify"},@{@"text":@"人月黄昏",@"image":@"New-addition"}]];//初始化
    
    popupView.renderCellBlock = ^(UITableViewCell *cell, id model, NSIndexPath *indexPath) {//菜单样式
        
        NSDictionary *dict = model;
        cell.textLabel.text = dict[@"text"];
        cell.textLabel.font = [UIFont systemFontOfSize:12.];
        cell.imageView.image = [UIImage imageNamed:dict[@"image"]];
    };
    popupView.selectedCellBlock = ^(id model, NSIndexPath *indexPath) {//选择菜单后
        if (indexPath.row == 0) {
            
        }else{
            
        }
    };
    [popupView showView];
}

- (void)onGetMusicListSuccess:(id)model{
    [self.MusicListView configTableViewWithData:model];
}

-(MusicPresenter *)musicPresenter{
    if (!_musicPresenter) {
        _musicPresenter = [[MusicPresenter alloc] init];
        _musicPresenter.delegate = self;
    }
    return _musicPresenter;
}

-(MusicListView *)MusicListView{
    if (!_MusicListView) {
        _MusicListView = [[MusicListView  alloc] initWithFrame:self.view.bounds];
    }
    return _MusicListView;
}

@end
