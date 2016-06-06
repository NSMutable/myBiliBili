//
//  bangumi_2View.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/23.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "bangumi_2View.h"
#import "PublicButton.h"
#import "PublicView.h"

@interface bangumi_2View ()

@property (nonatomic, strong) PublicButton *button;

@end

@implementation bangumi_2View


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
        
    }
    return self;
}
//目前先仅用于推荐页
- (void)setModel:(RecommendModel *)model {
    
    _model = model;
    
    [self.button setimgView:@"othen_hot_icon" label:model.head[@"title"] buttonBackgroundColor:UIColorFromRGB(0xbbbbbb) content:@"更多" btnImg:nil leftLabel:nil];
    
    for (int i = 0; i < 4; i++) {
        PublicView *view = [self viewWithTag:(100+i)];
        [view setImg:model.body[i][@"cover"] title:model.body[i][@"title"] playCount:[NSString stringWithFormat:@"%@", model.body[i][@"desc1"]] danmakuCount:nil];
        
    }
}




@end
