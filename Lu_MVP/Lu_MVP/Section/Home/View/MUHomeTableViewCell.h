//
//  MUHomeTableViewCell.h
//  LUMVP
//
//  Created by Faith on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUHomeModel.h"

#define MUHomeTableViewCellID @"MUHomeTableViewCell"

NS_ASSUME_NONNULL_BEGIN

@interface MUHomeTableViewCell : UITableViewCell
@property(nonatomic, strong) MUHomeModel * viewModel;
@end

NS_ASSUME_NONNULL_END
