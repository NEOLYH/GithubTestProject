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

-(void)loadDataWithState:(RefreshPullStyle)isPullUp completed:(void(^)(BOOL isSuccessed))completed{
    
    NSArray * cacheArray = [PPNetworkCache httpCacheForURL:@"key" parameters:@{}];
    //刷新时清空数据源或者将数据插入到第一的位置
    if(isPullUp == RefreshPullUp){
        [self.listArray removeAllObjects];
        self.pulldownPage = 1;
    }else if(isPullUp == RefreshPullDown){
        self.pulldownPage += 1;
    }else{
        if (cacheArray.count > 0) {
            NSArray * modelArray = [MUHomeModel mj_objectArrayWithKeyValuesArray:cacheArray];
            self.listArray = [NSMutableArray arrayWithArray:modelArray];
            completed(YES);
            return;
        }else{
            [self.listArray removeAllObjects];
            self.pulldownPage = 1;
        }
    }
    
    NSString * urlString =  @"https://music-api-jwzcyzizya.now.sh/api/search/song/netease";
    NSString * page = [NSString stringWithFormat:@"%ld",self.pulldownPage];
    weakSelf(weakSelf);
    [PPNetworkHelper GET:urlString parameters:@{@"key":@"beyand",@"limit":@"10",@"page": page} responseCache:^(id responseCache) {
        [PPNetworkCache setHttpCache:responseCache[@"songList"] URL:@"key" parameters:@{}];
    } success:^(id responseObject) {
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

-(NSMutableArray *)bannerArray{
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray arrayWithArray:@[@"https://p1.music.126.net/DRId4yElK6Po15SswbFvrA==/65970697683620.jpg?param=250y250",@"https://p1.music.126.net/suco52xu0lv3dhykrrL_vg==/65970697667610.jpg?param=250y250",@"https://p1.music.126.net/Ajn-819hYNmrj1Atan0UIg==/67070209295390.jpg?param=250y250"]];
    }
    return _bannerArray;
}

@end
