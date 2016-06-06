//
//  bangumi_3Cell.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/24.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#include "PublicView.h"
#import "bangumi_3Cell.h"

@interface bangumi_3Cell ()

@property (nonatomic, strong) PublicView *view;

@end

@implementation bangumi_3Cell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.view = [[PublicView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.view];
        WS(ws);
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
    }
    
    return self;
}

- (void)setModel:(bangumi_3Model *)model {
    _model = model;
//    [self.view setImg:model.cover icon:nil title:model.title liveCount:model.desc1 upName:nil];
    [self.view setImg:model.cover title:model.title playCount:model.desc1 danmakuCount:nil];
}

@end
