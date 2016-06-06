//
//  IntroductionHeadView.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/19.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "AVIntroductionHeadModel.h"
#import <UIKit/UIKit.h>

@interface IntroductionHeadView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *danmakuLabel;

@property (nonatomic, strong) UILabel *descLable;

@property (nonatomic, strong) UIImageView *ownerImgView;

@property (nonatomic, strong) UILabel *ownerNamelabel;

@property (nonatomic, strong) UILabel *pubdateLable;

@property (nonatomic, strong) AVIntroductionHeadModel *model;

@property (nonatomic, strong) UICollectionView *collectionView;

//代码整体布局有问题，只能在这里再传值回去😭
@property (nonatomic, copy) void(^sendLineCount)(NSInteger);

@end
