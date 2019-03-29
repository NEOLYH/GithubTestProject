//
//  MUHomeTableViewCell.m
//  LUMVP
//
//  Created by Faith on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MUHomeTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIImageView+WebCache.h"
#import <ChameleonFramework/Chameleon.h>

@interface MUHomeTableViewCell ()
@property(nonatomic, strong)UIView * messegeView;
@property(nonatomic, strong)UIImageView * logoImageView;
@property(nonatomic, strong)UILabel * authorLabel;
@property(nonatomic, strong)UILabel * albumLabel;
@end

@implementation MUHomeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}

///布局
-(void)setCell{
    
    [self.contentView addSubview:self.messegeView];
    [self.messegeView addSubview:self.logoImageView];
    [self.messegeView addSubview:self.albumLabel];
    [self.messegeView addSubview:self.authorLabel];
    
    [self.messegeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 15, 10, 15));
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.messegeView).offset(15);
        make.top.mas_equalTo(self.messegeView).offset(10);
        make.bottom.mas_equalTo(self.messegeView).offset(-10);
        //将logo大小的约束优先级提高，避免约束冲突出现打印信息
        make.height.width.mas_equalTo(60).priorityHigh();
    }];
    
    [self.albumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImageView.mas_top);
        make.left.mas_equalTo(self.logoImageView.mas_right).offset(15);
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.logoImageView);
        make.left.mas_equalTo(self.logoImageView.mas_right).offset(15);
    }];
}

-(void)setViewModel:(MUHomeModel *)viewModel{
    _viewModel = viewModel;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:viewModel.album_cover] placeholderImage:[UIImage imageNamed:@"back"]];
    self.albumLabel.text = viewModel.album_name ? viewModel.album_name :@"--";
    self.authorLabel.text = viewModel.artists_name ? viewModel.artists_name:@"--";
}

#pragma lazy
-(UIView *)messegeView{
    if (!_messegeView) {
        _messegeView = [[UIView alloc] init];
        _messegeView.backgroundColor = [UIColor flatBlueColor];
        _messegeView.layer.cornerRadius = 10;
    }
    return _messegeView;
}

-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _logoImageView.layer.cornerRadius = 30;
        _logoImageView.clipsToBounds = YES;
    }
    return _logoImageView;
}

-(UILabel *)authorLabel{
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [UIFont boldSystemFontOfSize:16];
        _authorLabel.textColor = [UIColor whiteColor];
    }
    return _authorLabel;
}

-(UILabel *)albumLabel{
    if (!_albumLabel) {
        _albumLabel = [[UILabel alloc] init];
        _albumLabel.font = [UIFont boldSystemFontOfSize:14];
        _albumLabel.textColor = [UIColor whiteColor];
    }
    return _albumLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
