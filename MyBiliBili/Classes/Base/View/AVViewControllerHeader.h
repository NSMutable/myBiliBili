//
//  AVViewControllerHeader.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/18.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "AVViewControllerHeaderModel.h"
#import "AvPlayerView.h"
#import <UIKit/UIKit.h>

@interface AVViewControllerHeader : UIView

@property (nonatomic, strong) AVViewControllerHeaderModel *model;

@property (nonatomic, strong) UIImageView *backgroundImgView;

@property (nonatomic, strong) UILabel *avIdLable;

@property (nonatomic, strong) UIView *underLine;

@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, assign) BOOL playBtnFlag;

@property (nonatomic, copy) void(^clickBtn)(NSInteger);

@property (nonatomic, strong) AvPlayerView *playView;

- (void)changeBtn:(NSInteger)i;

@end
