//
//  MusicListView.m
//  LUMVP
//
//  Created by apple on 2018/12/20.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MusicListView.h"
#import "MusicListTableViewCell.h"

@interface MusicListView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong) NSArray * data;
@end

@implementation MusicListView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tableView];
        
    }
    return self;
}

-(void)configTableViewWithData:(NSArray *)data{
    self.data = data;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MusicEntity * model = self.data[indexPath.row];
    MusicListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MusicListTableViewCellID forIndexPath:indexPath];
    [cell setCellWithModle:model];
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MusicListTableViewCell class] forCellReuseIdentifier:MusicListTableViewCellID];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

-(void)setData:(NSArray *)data{
    _data = data;
}

@end
