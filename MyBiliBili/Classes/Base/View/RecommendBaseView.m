//
//  RecommendView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/23.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "RecommendBaseView.h"
#import "PublicButton.h"
#import "PublicView.h"

@interface RecommendBaseView ()

@property (nonatomic, strong) PublicButton *button;

@end

@implementation RecommendBaseView

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
        CGFloat itemWidth = (kScreenWidth - kWidth(30)) / 2.0;
        for (int i = 0; i < 4 ; i++) {
            PublicView *imgView = [[PublicView alloc] initWithFrame:CGRectMake(kWidth(10) + (i % 2) * (itemWidth + kWidth(10)), kHeight(50) + (i / 2) * (kHeight(10) + kHeight(132)), itemWidth, kHeight(132))];
            imgView.tag = 100 + i;
            [self addSubview:imgView];
        }
        
        UIButton *reloadBtn = [UIButton buttonWithType:0];
        [self addSubview:reloadBtn];
        [reloadBtn setTitle:@"换一波推荐" forState:0];
        [reloadBtn setTitleColor:kBlackColor forState:0];
        reloadBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.mas_centerX);
            make.bottom.equalTo(ws.mas_bottom).with.offset(-kHeight(5));
        }];
    }
    return self;
}
//目前先仅用于推荐页
- (void)setModel:(RecommendModel *)model {
    
    _model = model;
    
    [self.button setimgView:@"othen_hot_icon" label:model.head[@"title"] buttonBackgroundColor:UIColorFromRGB(0xf9d61f) content:@"排行榜" btnImg:nil leftLabel:nil];
    
    for (int i = 0; i < 4; i++) {
        PublicView *view = [self viewWithTag:(100+i)];
        [view setImg:model.body[i][@"cover"] title:model.body[i][@"title"] playCount:model.body[i][@"play"] danmakuCount:model.body[i][@"danmaku"]];
        view.type = model.body[i][@"goto"];
        view.param = model.body[i][@"param"];
    }
}

@end
