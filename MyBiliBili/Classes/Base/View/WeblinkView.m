//
//  WeblinkView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/23.
//  Copyright © 2016年 陈淼. All rights reserved.
//


#import "PublicButton.h"
#import "WeblinkView.h"
#import "WeblinkViewController.h"

@interface WeblinkView ()

@property (nonatomic, strong) PublicButton *button;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *lable;

@end

@implementation WeblinkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kClearColor;
        
        self.button = [PublicButton new];
        [self addSubview:self.button];
        WS(ws);
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(ws);
            make.trailing.equalTo(ws);
            make.top.equalTo(ws.mas_top).with.offset(kHeight(10));
            make.height.mas_equalTo(kHeight(30));
        }];
        
        self.imgView = [UIImageView new];
        self.imgView.userInteractionEnabled = YES;
        [self addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.mas_left).with.offset(kWidth(10));
//            make.right.equalTo(ws.mas_right).with.offset(-kWidth(10));
            make.top.equalTo(ws.button.mas_bottom).with.offset(kHeight(10));
            make.height.mas_equalTo(kHeight(80));
            make.width.mas_equalTo(kScreenWidth - kWidth(20));
        }];
        
        self.lable = [UILabel new];
        [self addSubview:self.lable];
        self.lable.font = [UIFont systemFontOfSize:13];
        self.lable.numberOfLines = 1;
        self.lable.backgroundColor = [UIColor whiteColor];
        [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.imgView.mas_bottom);
            make.leading.equalTo(ws.imgView);
            make.trailing.equalTo(ws.imgView);
            make.height.mas_equalTo(kHeight(25));
        }];
        
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    WeblinkViewController *vc = [[WeblinkViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    [vc addData:self.model.body[0][@"param"]];

}


- (void)setModel:(RecommendModel *)model {
    
    _model = model;
    [self.button setimgView:@"home_region_icon_153" label:@"话题" buttonBackgroundColor:kClearColor content:nil btnImg:nil leftLabel:nil];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.body[0][@"cover"]]];
    self.lable.text = model.body[0][@"title"];
}

@end
