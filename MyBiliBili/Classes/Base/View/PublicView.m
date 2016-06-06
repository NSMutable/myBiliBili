//
//  PublicView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/23.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "PublicView.h"
#import "AVViewController.h"

@implementation PublicView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        self.imgView = [UIImageView new];
        [self addSubview:self.imgView];
        WS(ws);
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws);
            make.leading.equalTo(ws);
            make.trailing.equalTo(ws);
            make.height.mas_equalTo(kHeight(80));
        }];
        
        self.titleLable = [UILabel new];
        [self addSubview:self.titleLable];
        self.titleLable.numberOfLines = 2;
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.imgView.mas_bottom).with.offset(kHeight(2));
            make.left.equalTo(ws.mas_left).with.offset(kWidth(6));
            make.right.equalTo(ws.mas_right).with.offset(-kWidth(6));
        }];
        
        self.detailLable = [UILabel new];
        [self addSubview:self.detailLable];
        
        [self.detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws).with.offset(-kHeight(4));
            make.left.equalTo(ws.mas_left).with.offset(kWidth(6));
            make.right.equalTo(ws.mas_right).with.offset(-kWidth(6));
        }];
        
        self.icon = [UIImageView new];
        [self addSubview:self.icon];
        
        UIButton *jumpBtn = [UIButton buttonWithType:0];
        jumpBtn.backgroundColor = kClearColor;
        [self addSubview:jumpBtn];
        [jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        [jumpBtn addTarget:self action:@selector(jumpToAvVc) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)jumpToAvVc {

    if ([self.type isEqualToString:@"av"]) {
        AVViewController *vc = [[AVViewController alloc] init];
        vc.aid = [NSString stringWithFormat:@"%@", self.param];
        [self.viewController.navigationController pushViewController:vc animated:YES];

    }
}

- (void)setImg:(NSString *)imgStr title:(NSString *)title playCount:(NSString *)playCount danmakuCount:(NSString *)danmakuCount {
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgStr]];
    
    self.titleLable.text = title;
    self.titleLable.font = [UIFont systemFontOfSize:12];

    if (playCount != nil) {
        NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@      ", playCount]];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, playCount.length)];
        [attri addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x9a9ab96) range:NSMakeRange(0, playCount.length)];
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
        if (danmakuCount != nil) {
            NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:danmakuCount attributes:@{
                                                                                                            NSFontAttributeName:[UIFont systemFontOfSize:11],
                                                                                                            NSForegroundColorAttributeName:UIColorFromRGB(0x9a9ab96)
                                                                                                            }];
            
            [attri appendAttributedString:str2];
        }
       
        
        self.detailLable.attributedText = attri;
    }
    
}

- (void)setImg:(NSString *)imgStr icon:(NSString *)iconStr title:(NSString *)title liveCount:(NSString *)liveCount upName:(NSString *)upName {
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgStr]];
    WS(ws);

    [self.icon sd_setImageWithURL:[NSURL URLWithString:iconStr]];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.imgView.mas_bottom).with.mas_equalTo(-kHeight(7));
        make.left.equalTo(ws.imgView.mas_left).with.mas_equalTo(kWidth(6));
        make.size.mas_equalTo(CGSizeMake(kHeight(26), kHeight(26)));
    }];
    self.icon.layer.cornerRadius = kHeight(13);
    
     self.titleLable.numberOfLines = 1;
    [self.titleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.imgView.mas_bottom).with.offset(kHeight(2));
        make.left.equalTo(ws.icon.mas_right).with.offset(kWidth(4));
        make.right.equalTo(ws.mas_right).with.offset(-kWidth(6));
    }];
    
    self.titleLable.text = title;
    self.titleLable.font = [UIFont systemFontOfSize:14];
    
    if (liveCount != nil && upName != nil) {
        
       
//
//        NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:title attributes:@{
//                                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:14]                                                                                   }];
//        
//        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//        attch.bounds = CGRectMake(0, 0, kHeight(30), kHeight(30));
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconStr]];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                attch.image = [UIImage imageWithData:data];
//                NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//                [titleAttri insertAttributedString:string atIndex:0];
//                self.titleLable.attributedText = titleAttri;
//            });
//        });
        
        
        NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", liveCount]];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, liveCount.length)];
        [attri addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x9a9ab96) range:NSMakeRange(0, liveCount.length)];
        [attri addAttribute:NSBackgroundColorAttributeName value:UIColorFromRGB(0xdcdcdc) range:NSMakeRange(0, liveCount.length)];
        NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:upName attributes:@{
                                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:11],
                                                                                                        NSForegroundColorAttributeName:UIColorFromRGB(0x9a9ab96)
                                                                                                        }];
        
        [attri appendAttributedString:str2];
        
        self.detailLable.attributedText = attri;
    }

    
}

@end
