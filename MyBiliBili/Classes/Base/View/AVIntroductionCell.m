//
//  AVIntroductionCell.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/20.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "AVIntroductionCell.h"

@interface AVIntroductionCell ()

@property (nonatomic, strong) UIImageView *picImgView;

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *upLable;

@property (nonatomic, strong) UILabel *playLable;


@end

@implementation AVIntroductionCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    
    return self;
}

- (void)configUI {
    
    WS(ws);
    self.picImgView = [UIImageView new];
    [self addSubview:self.picImgView];
    
    [self.picImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.mas_left).with.offset(kWidth(10));
        make.top.equalTo(ws.mas_top);
        make.size.mas_equalTo(CGSizeMake(kWidth(102), kHeight(62)));
    }];
    
    self.titleLable = [UILabel new];
    self.titleLable.numberOfLines = 2;
    self.titleLable.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.picImgView.mas_top);
        make.left.equalTo(ws.picImgView.mas_right).with.offset(kWidth(8));
        make.right.equalTo(ws).with.offset(-kWidth(24));
        make.height.mas_equalTo(kHeight(34));
    }];
    
    self.upLable = [UILabel new];
    [self addSubview:self.upLable];
    [self.upLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.titleLable.mas_bottom);
        make.leading.equalTo(ws.titleLable);
        make.height.mas_equalTo(kHeight(14));
    }];
    
    self.playLable = [UILabel new];
    [self addSubview:self.playLable];
    [self.playLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.picImgView.mas_bottom);
        make.leading.equalTo(ws.titleLable);
        make.height.mas_equalTo(kHeight(14));
    }];
    
}

- (void)setModel:(AVIntroductionTableViewCellModel *)model {
    
    _model = model;
    
    [self.picImgView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    self.titleLable.text = model.title;
    
    self.upLable.text = [NSString stringWithFormat:@"UP主 %@", model.name];
    self.upLable.font = [UIFont systemFontOfSize:11];
    
    NSInteger viewTimes = [model.view integerValue];
    NSString *viewStr;
    if (viewTimes >= 10000) {
        viewStr = [NSString stringWithFormat:@"%li.%li万", viewTimes / 10000, (viewTimes % 10000) / 1000];
    } else {
        viewStr = [NSString stringWithFormat:@"%li", viewTimes];
    }
    
    NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@  ", viewStr]];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, attri.length)];
    [attri addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xa2a2a2) range:NSMakeRange(0, attri.length)];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"list_playnumb_icon"];
    attch.bounds = CGRectMake(0, 0, kHeight(9), kHeight(9));
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    
    NSTextAttachment *attch1 = [[NSTextAttachment alloc] init];
    attch1.image = [UIImage imageNamed:@"list_danmaku_icon"];
    attch1.bounds = CGRectMake(0, 0, kHeight(9), kHeight(9));
    NSAttributedString *string1 = [NSAttributedString attributedStringWithAttachment:attch1];
    [attri appendAttributedString:string1];
    
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@         ", model.danmaku] attributes:@{
                                                                                                                                                     NSFontAttributeName: [UIFont systemFontOfSize:11] ,
                                                                                                                                                     NSForegroundColorAttributeName:  UIColorFromRGB(0xa2a2a2)                                      }];
    
    
    [attri appendAttributedString:string2];
   
    self.playLable.attributedText = attri;
    
}

@end
