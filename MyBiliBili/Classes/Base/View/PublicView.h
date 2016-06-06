//
//  PublicView.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/23.
//  Copyright © 2016年 陈淼. All rights reserved.
//


#import "RecommendModel.h"
#import <UIKit/UIKit.h>

@interface PublicView : UIView

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *detailLable;

@property (nonatomic, strong) RecommendModel *model;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *param;
//live中独有的
@property (nonatomic, strong) UIImageView *icon;



- (void)setImg:(NSString *)imgStr title:(NSString *)title playCount:(NSString *)playCount danmakuCount:(NSString *)danmakuCount;

- (void)setImg:(NSString *)imgStr icon:(NSString *)iconStr title:(NSString *)title liveCount:(NSString *)liveCount upName:(NSString *)upName;



@end
