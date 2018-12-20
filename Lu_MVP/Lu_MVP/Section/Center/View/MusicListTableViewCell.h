//
//  MusicListTableViewCell.h
//  LUMVP
//
//  Created by apple on 2018/12/19.
//  Copyright © 2018 apple. All rights reserved.
//

#define MusicListTableViewCellID @"MusicListTableViewCell"

#import <UIKit/UIKit.h>
#import "MusicEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface MusicListTableViewCell : UITableViewCell
-(void)setCellWithModle:(MusicEntity *)mdoel;
@end

NS_ASSUME_NONNULL_END
