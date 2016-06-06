//
//  LiveBaseView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/23.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "LiveBaseView.h"
#import "PublicButton.h"
#import "PublicView.h"

@interface LiveBaseView ()

@property (nonatomic, strong) PublicButton *button;

@end

@implementation LiveBaseView


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
        
        UIButton *moreBtn = [UIButton buttonWithType:0];
        moreBtn.backgroundColor = [UIColor whiteColor];
        [moreBtn setTitle:@"查看更多" forState:0];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [moreBtn setTitleColor:kBlackColor forState:0];
        [self addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [self.button setimgView:@"home_region_icon_22" label:model.head[@"title"] buttonBackgroundColor:UIColorFromRGB(0xbbbbbb) content:@"进去看看" btnImg:nil leftLabel:[NSString stringWithFormat:@"目前%@个直播", model.head[@"count"]]];
    
    for (int i = 0; i < 4; i++) {
        PublicView *view = [self viewWithTag:(100+i)];
//        [view setImg:model.body[i][@"cover"] title:model.body[i][@"title"] playCount:[NSString stringWithFormat:@"%@", model.body[i][@"online"]] danmakuCount:[NSString stringWithFormat:@"%@", model.body[i][@"online"]]];
        
        [view setImg:model.body[i][@"cover"] icon:model.body[i][@"up_face"] title:model.body[i][@"title"] liveCount:[NSString stringWithFormat:@"%@", model.body[i][@"online"]] upName:model.body[i][@"up"] ];
        view.type = model.body[i][@"goto"];
        view.param = model.body[i][@"param"];
    }
}


@end
