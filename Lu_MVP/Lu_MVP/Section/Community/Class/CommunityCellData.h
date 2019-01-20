//
//  CommunityCellData.h
//  LUMVP
//
//  Created by apple on 2019/1/15.
//  Copyright © 2019 apple. All rights reserved.
//
#import <Graver/WMGVisionObject.h>
#import "WMGBaseCellData.h"
#import "CommunityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommunityCellData : WMGBaseCellData
@property(nonatomic,strong) NSMutableArray < WMGVisionObject *> * textDrawerDatas;
@end

NS_ASSUME_NONNULL_END
