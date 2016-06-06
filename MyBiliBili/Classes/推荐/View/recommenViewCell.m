//
//  recommenViewCell.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/23.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "recommenViewCell.h"
#import "RecommendBaseView.h"
#import "LiveBaseView.h"
#import "bangumi_2View.h"
#import "WeblinkView.h"
#import "RegionView.h"
#import "bangumi_3View.h"

@interface recommenViewCell ()

@property (nonatomic, strong) RecommendBaseView *recommendView;
@property (nonatomic, strong) LiveBaseView *liveView;
@property (nonatomic, strong) bangumi_2View *bangumiView2;
@property (nonatomic, strong) WeblinkView *weblinkView;
@property (nonatomic, strong) RegionView *regionView;
@property (nonatomic, strong) bangumi_3View *bangumiView3;
//传回来的type为空时的view
@property (nonatomic, strong) UIView *nullView;
@property (nonatomic, strong) UIImageView *nullImgView;

@end

@implementation recommenViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.recommendView = [[RecommendBaseView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.recommendView];
        self.liveView = [[LiveBaseView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.liveView];
        self.bangumiView2 = [[bangumi_2View alloc] initWithFrame:CGRectZero];
        [self addSubview:self.bangumiView2];
        self.bangumiView3 = [[bangumi_3View alloc] initWithFrame:CGRectZero];
        [self addSubview:self.bangumiView3];
        self.weblinkView = [[WeblinkView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.weblinkView];
        self.regionView = [[RegionView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.regionView];
        self.nullView = [UIView new];
        [self addSubview:self.nullView];
        self.nullImgView = [UIImageView new];
        [self.nullView addSubview:self.nullImgView];
        
        
    }
    
    return self;
}

- (void)setRecommendModel:(RecommendModel *)recommendModel {
    
    self.recommendView.hidden = YES;
    self.liveView.hidden = YES;
    self.bangumiView2.hidden = YES;
    self.weblinkView.hidden = YES;
    self.nullView.hidden = YES;
    self.regionView.hidden = YES;
    self.bangumiView3.hidden = YES;

    _recommendModel = recommendModel;
    WS(ws);
    if ([_recommendModel.type isEqualToString:@"recommend"]) {
        
        [self.recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        self.recommendView.hidden = NO;
        self.recommendView.model = recommendModel;
        
        
    }else if ([_recommendModel.type isEqualToString:@"live"]) {
        
        [self.liveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        self.liveView.hidden = NO;
        self.liveView.model = recommendModel;
        
    }else if ([_recommendModel.type isEqualToString:@"bangumi_2"]){
        
        [self.bangumiView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        self.bangumiView2.hidden = NO;
        self.bangumiView2.model = recommendModel;
        
    }else if ([_recommendModel.type isEqualToString:@"weblink"]) {
        [self.weblinkView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        self.weblinkView.hidden = NO;
        self.weblinkView.model = recommendModel;
    
    }else if ([_recommendModel.type isEqualToString:@"region"]) {
        [self.regionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        self.regionView.hidden = NO;
        self.regionView.model = recommendModel;
    }else if ([_recommendModel.type isEqualToString:@"bangumi_3"]) {
        [self.bangumiView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        self.bangumiView3.hidden = NO;
        self.bangumiView3.model = recommendModel;
    }else {
        [self.nullView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        self.nullView.hidden = NO;
        [self.nullImgView sd_setImageWithURL:[NSURL URLWithString:recommendModel.body[0][@"cover"]]];
        [self.nullImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.nullView.mas_left).with.offset(kWidth(10));
            make.right.equalTo(ws.nullView.mas_right).with.offset(-kWidth(10));
            make.centerY.equalTo(ws.nullView);
            make.height.mas_equalTo(kHeight(80));
        }];
    }
   
}

@end
