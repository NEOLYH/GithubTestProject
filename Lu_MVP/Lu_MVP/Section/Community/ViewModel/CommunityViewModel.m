//
//  CommunityViewModel.m
//  LUMVP
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommunityViewModel.h"
#import "CommunityCellData.h"
#import "CommunityModel.h"
#import <Graver/WMMutableAttributedItem.h>

#import "PPNetworkHelper.h"
#import "Community.h"


@implementation CommunityViewModel

-(WMGBaseCellData *)refreshCellDataWithMetaData:(CommunityModel *)item{
    CommunityCellData * cellData = [[CommunityCellData alloc] init];
    cellData.cellHeight = 215;
    cellData.cellWidth = [UIScreen mainScreen].bounds.size.width - 20;
    WMMutableAttributedItem * poiImageAttributedItem = [WMMutableAttributedItem  itemWithText:nil];
    WMMutableAttributedItem * imageAttibutedItem = [poiImageAttributedItem appendImageWithUrl:item.pic size:CGSizeMake(60, 60) placeholder:@"tabbar_home_selected"];
     WMGVisionObject * poiImageDrawObject  = [[WMGVisionObject alloc] init];
    poiImageDrawObject.frame = CGRectMake(15, 15,60,60);
    
//    [cellData.textDrawerDatas addObject: poiImageDrawObject];
    
    return cellData;
}

//-(void)communityNetWorkWithUrl:(NSString *)url paramas:(NSDictionary *)paramas success:(void(^)(NSArray * dataArray))success{
//    if (url) {
//        return;
//    }
//    [PPNetworkHelper setValue:@"" forHTTPHeaderField:@""];
//    [PPNetworkHelper GET:url parameters:paramas responseCache:^(id responseCache) {
//        
//    } success:^(id responseObject) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}

@end
