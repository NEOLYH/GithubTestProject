//
//  MURollCollectionViewCell.h
//  LUMVP
//
//  Created by Faith on 2019/3/30.
//  Copyright © 2019 apple. All rights reserved.
//

#define MURollCollectionViewCellID @"MURollCollectionViewCell"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MURollCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) NSString *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, assign) NSTextAlignment titleLabelTextAlignment;

@property (nonatomic, assign) BOOL hasConfigured;

/** 只展示文字轮播 */
@property (nonatomic, assign) BOOL onlyDisplayText;
@end

NS_ASSUME_NONNULL_END
