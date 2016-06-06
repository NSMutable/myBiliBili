//
//  RegionView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/24.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "PublicButton.h"
#import "PublicView.h"
#import "RegionView.h"

@interface RegionView ()

@property (nonatomic, strong) PublicButton *button;

@property (nonatomic, strong) UIButton *moreBtn;

@end

@implementation RegionView

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
        
        self.moreBtn = [UIButton buttonWithType:0];
        self.moreBtn.backgroundColor = [UIColor whiteColor];
        [self.moreBtn setTitle:@"查看更多" forState:0];
        self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.moreBtn setTitleColor:kBlackColor forState:0];
        [self addSubview:self.moreBtn];
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.mas_left).with.offset(kWidth(10));
            make.bottom.equalTo(ws.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(kWidth(88), kHeight(24)));
        }];
    }
    return self;
}
//目前先仅用于推荐页
- (void)setModel:(RecommendModel *)model {
    
    _model = model;
    
    [self.button setimgView:@"othen_hot_icon" label:model.head[@"title"] buttonBackgroundColor:UIColorFromRGB(0xbbbbbb) content:@"进去看看" btnImg:nil leftLabel:nil];

    NSMutableString *str = [NSMutableString stringWithFormat:@"%@", model.head[@"title"]];
    [str deleteCharactersInRange:NSMakeRange(2, str.length - 2)];
    [self.moreBtn setTitle:[NSString stringWithFormat:@"更多%@", str] forState:0];
    
    
    
    for (int i = 0; i < 4; i++) {
        PublicView *view = [self viewWithTag:(100+i)];
        [view setImg:model.body[i][@"cover"] title:model.body[i][@"title"] playCount:model.body[i][@"play"] danmakuCount:model.body[i][@"danmaku"]];
        view.type = model.body[i][@"goto"];
        view.param = model.body[i][@"param"];
    }
}


@end
