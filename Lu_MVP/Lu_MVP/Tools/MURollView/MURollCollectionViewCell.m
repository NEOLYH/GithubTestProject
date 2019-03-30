//
//  MURollCollectionViewCell.m
//  LUMVP
//
//  Created by Faith on 2019/3/30.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MURollCollectionViewCell.h"

@implementation MURollCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpImage];
    }
    return self;
}

-(void)setUpImage{
    
    [self.contentView addSubview:self.imageView];
}

#pragma lazy
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}
@end
