//
//  MUHomeViewModel.m
//  LUMVP
//
//  Created by Faith on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MUHomeViewModel.h"
#import "PPNetworkHelper.h"
#import "MJExtension.h"
#import "MUHomeModel.h"

#define weakSelf(weakSelf)  __weak typeof(self) weakself = self;

@interface MUHomeViewModel ()

/// 上拉加载page
@property (nonatomic, assign) NSInteger pulldownPage;

@end

@implementation MUHomeViewModel

-(instancetype)init{
    if (self = [super init]) {
        //加载page默认为1
        self.pulldownPage = 1;
    }
    return self;
}

-(void)loadDataWithState:(BOOL)isPullUp completed:(void(^)(BOOL isSuccessed))completed{
    
    //刷新时清空数据源或者将数据插入到第一的位置
    if(isPullUp){
        [self.listArray removeAllObjects];
        self.pulldownPage = 1;
    }else{
        self.pulldownPage += 1;
    }
    
    NSString * urlString =  @"https://music-api-jwzcyzizya.now.sh/api/search/song/netease";
    NSString * page = [NSString stringWithFormat:@"%ld",self.pulldownPage];
    weakSelf(weakSelf);
    [PPNetworkHelper GET:urlString parameters:@{@"key":@"beyand",@"limit":@"10",@"page": page} responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *array = responseObject[@"songList"];
        if (array == nil) {
            //显示数据错误
            //回调
            completed(NO);
            return;
        }
        
        //josn数组转模型数组
        NSArray * modelArray = [MUHomeModel mj_objectArrayWithKeyValuesArray:array];
        if (isPullUp && self.pulldownPage == 1) {
            // 如果是 下拉／默认 刷新，将数据插入到数组的前面
//            NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)];
//            [self.listArray insertObjects:array atIndexes:indexes];
            [weakself.listArray addObjectsFromArray:modelArray];
        }else{
            [weakself.listArray addObjectsFromArray:modelArray];
        }
        
        completed(YES);
        
    } failure:^(NSError *error) {
        
        //显示网络错误提示
        //回调
        completed(NO);
    }];
}

-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

@end
