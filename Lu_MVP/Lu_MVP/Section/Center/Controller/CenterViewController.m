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
