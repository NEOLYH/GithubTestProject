//
//  CommunityCellData.m
//  LUMVP
//
//  Created by apple on 2019/1/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommunityCellData.h"

@implementation CommunityCellData

-(instancetype)init{
    if (self = [super init]) {
        _textDrawerDatas = [NSMutableArray array];
    }
    return self;
}

-(Class)cellClass{
    return NSClassFromString(@"Community");
}

@end
