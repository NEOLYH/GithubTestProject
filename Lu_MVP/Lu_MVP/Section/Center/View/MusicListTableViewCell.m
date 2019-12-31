//
//  MusicListTableViewCell.m
//  LUMVP
//
//  Created by apple on 2018/12/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MusicListTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+MUCache.h"

@interface MusicListTableViewCell()
@property(nonatomic, strong) UILabel * titleLable;
@property(nonatomic, strong) UILabel * contentLable;
@property(nonatomic, strong) UILabel * articleLable;
@property(nonatomic, strong) UIImageView * musicLogo;
@end

@implementation MusicListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpcell];
    }
    return self;
}

-(void)setUpcell{
    [self.contentView addSubview:self.musicLogo];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.contentLable];
    [self.contentView addSubview:self.articleLable];
    
    [self.musicLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.top.mas_equalTo(self.contentView).offset(10);
        make.bottom.mas_equalTo(self.contentView).offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(80);
    }];
    
    
//    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView).offset(10);
//        make.left.mas_equalTo(self.contentView).offset(50);
//    }];
//
//    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView.titleLable.mas_bottom).offset(10);
//        make.left.mas_equalTo(self.contentView).offset(50);
//    }];
    

}

-(void)setCellWithModle:(MusicEntity *)mdoel{
//    self.textLabel.text = mdoel.title;
//    self.contentLable.text = mdoel.artist;
//    [self.musicLogo sd_setImageWithURL:[NSURL URLWithString:mdoel.pic]];
    [self.musicLogo setImageURLString:mdoel.pic placeHolderImageName:@"back" cornerRadius:12];
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont systemFontOfSize:18 weight:200];
        _titleLable.textColor = [UIColor colorWithRed:151/255.0 green:156/255.0 blue:161/255.0 alpha:1];
    }
    return _titleLable;
}

-(UILabel *)contentLable{
    if (!_contentLable) {
        _contentLable = [[UILabel alloc] init];
    }
    return _contentLable;
}

-(UIImageView *)musicLogo{
    if (!_musicLogo) {
        _musicLogo = [[UIImageView alloc] init];
    }
    return _musicLogo;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
