//
//  AVViewControllerHeader.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/18.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "AVViewControllerHeader.h"

@interface AVViewControllerHeader ()


@end


@implementation AVViewControllerHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.playBtnFlag = NO;
        [self configUI];
    }
    return self;
}

- (void) configUI {
    
    self.backgroundImgView = [UIImageView new];
    self.backgroundImgView.userInteractionEnabled = YES;
    [self addSubview:self.backgroundImgView];
    WS(ws);
    [self.backgroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws).with.insets(UIEdgeInsetsMake(0, 0, kHeight(32), 0));
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:IMAGE(@"hd_icmpv_back_light") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToLastViewCtrl) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundImgView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.backgroundImgView).with.offset(kHeight(36));
        make.left.equalTo(ws.backgroundImgView).with.offset(kWidth(16));
        make.size.mas_equalTo(CGSizeMake(kWidth(17), kHeight(16)));
    }];
    
    self.avIdLable = [UILabel new];
    self.avIdLable.textAlignment = NSTextAlignmentLeft;
    self.avIdLable.textColor = [UIColor whiteColor];
    self.avIdLable.font = [UIFont systemFontOfSize:14];
    [self.backgroundImgView addSubview:self.avIdLable];
    [self.avIdLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backBtn.mas_right).with.offset(kWidth(16));
        make.top.equalTo(backBtn.mas_top);
        make.size.mas_equalTo(CGSizeMake(kWidth(100), kHeight(16)));
    }];
    
    UIButton *introductionBtn = [UIButton buttonWithType:0];
    [introductionBtn setTitle:@"简介" forState:UIControlStateNormal];
    introductionBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    introductionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    introductionBtn.selected = YES;
    [introductionBtn setTitleColor:UIColorFromRGB(0xeb9bb6) forState:UIControlStateSelected];
    [introductionBtn setTitleColor:kBlackColor forState:0];
    introductionBtn.tag = 101;
    [introductionBtn addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:introductionBtn];
    [introductionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(kWidth(4));
        make.bottom.equalTo(ws.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kWidth(36), kHeight(32)));
    }];
    
    UIButton *commentBtn = [UIButton buttonWithType:0];
    [commentBtn setTitle:@"评论(1000)" forState:0];
    [commentBtn setTitleColor:kBlackColor forState:0];
    [commentBtn setTitleColor:UIColorFromRGB(0xeb9bb6) forState:UIControlStateSelected];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    commentBtn.tag = 102;
    [commentBtn addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commentBtn];
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(introductionBtn.mas_right).with.offset(kWidth(12));
        make.bottom.equalTo(ws.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kWidth(70), kHeight(32)));
    }];
    
    //计算简介按钮里面字的width
    CGRect rect = [introductionBtn.titleLabel.text boundingRectWithSize:CGSizeMake(999, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                       NSFontAttributeName:[UIFont systemFontOfSize:12]
                                                                                                                                                       } context:nil];
    
    self.underLine = [UIView new];
    self.underLine.backgroundColor = UIColorFromRGB(0xff76a1);
    [self addSubview:self.underLine];
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottom);
        make.centerX.equalTo(introductionBtn.mas_centerX);
        make.width.mas_equalTo(rect.size.width);
        make.height.mas_equalTo(@kHeight(2));
    }];
    
    self.playBtn = [UIButton buttonWithType:0];
    self.playBtn.backgroundColor = UIColorFromRGB(0xfc7398);
    [self addSubview:self.playBtn];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right).with.offset(-kWidth(12));
        make.bottom.equalTo(ws.mas_bottom).with.offset(-kHeight(10));
        make.size.mas_equalTo(CGSizeMake(kHeight(44), kHeight(44)));
    }];
    self.playBtn.layer.cornerRadius = kHeight(22);
    [self.playBtn addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark - 点击播放视频
- (void)playVideo {
    
    self.playView = [[AvPlayerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight(218 - 32))];
    self.playView.aid = self.model.aid;
    self.playBtn.hidden = YES;
    self.playBtnFlag = YES;
    [self addSubview:self.playView];

}

- (void)backToLastViewCtrl {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

- (void)changeState:(UIButton *)btn {
    
    UIButton *btn1 = (UIButton *)[self viewWithTag:101];
    UIButton *btn2 = (UIButton *)[self viewWithTag:102];
    
    
    //计算简介按钮里面字的width
    CGRect rect1 = [btn1.titleLabel.text boundingRectWithSize:CGSizeMake(999, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:12]
                                                                                                                                                        } context:nil];
    
    //计算评论按钮里面字的width
    CGRect rect2 = [btn2.titleLabel.text boundingRectWithSize:CGSizeMake(999, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:12]
                                                                                                                                        } context:nil];
    
    if (btn.tag == 101) {
        btn1.selected = YES;
        btn2.selected = NO;
        [UIView animateWithDuration:.25 animations:^{
            self.underLine.transform = CGAffineTransformIdentity;
        }];
        if (self.clickBtn) {
            self.clickBtn(1);
        }
    }else {
        
        if (btn2.selected == NO) {
            [UIView animateWithDuration:.25 animations:^{
                
                self.underLine.transform = CGAffineTransformMakeTranslation(kWidth(36) + kWidth(12) + (rect2.size.width - rect1.size.width)/2, 0);
                self.underLine.transform = CGAffineTransformScale(self.underLine.transform, rect2.size.width / rect1.size.width, 1);
            }];
        }
        if (self.clickBtn) {
            self.clickBtn(2);
        }
        btn2.selected = YES;
        btn1.selected = NO;
        
    }
}

//😭😢随便加个算了
- (void)changeBtn:(NSInteger)i {
    UIButton *btn = (UIButton *)[self viewWithTag:100 + i];
    [self changeState:btn];
}

- (void)setModel:(AVViewControllerHeaderModel *)model {
    _model = model;
    [self.backgroundImgView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    UIButton *commentBtn = [self viewWithTag:102];
    NSString *str = [NSString stringWithFormat:@"评论(%@)", model.reply];
    [commentBtn setTitle:str forState:0];
    
    
    self.avIdLable.text = [NSString stringWithFormat:@"av%@", model.aid];

}

@end
