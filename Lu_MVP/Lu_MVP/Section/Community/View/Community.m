//
//  Community.m
//  LUMVP
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import "Community.h"
#import "CommunityContentView.h"
#import "CommunityCellData.h"

@interface Community ()
@property(nonatomic, strong) CommunityContentView * ContentView;
@end

@implementation Community
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _ContentView  = [[CommunityContentView alloc] initWithFrame:CGRectMake(10, 5, 0, 0)];
        _ContentView.cornerRadius = 2;
        _ContentView.backgroundColor = [UIColor whiteColor];
        [ self.contentView addSubview:_ContentView];
    }
    return self;
}


-(void)setupCellData:(CommunityCellData *)cellData{
    _ContentView.frame = CGRectMake(10, 5, cellData.cellWidth, cellData.cellHeight);
//    _ContentView.textDrawerDatas = cellData.textDrawerDatas;
}
@end
