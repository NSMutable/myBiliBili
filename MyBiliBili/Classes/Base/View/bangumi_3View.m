//
//  bangumi_3View.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/24.
//  Copyright © 2016年 陈淼. All rights reserved.
//


#import "PublicButton.h"
#import "PublicView.h"
#import "bangumi_3View.h"
#import "bangumi_3Cell.h"

@interface bangumi_3View ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) PublicButton *button;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation bangumi_3View

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
       
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView.bounces = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.collectionView];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = kClearColor;
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.button.mas_bottom).with.offset(kHeight(10));
            make.leading.equalTo(ws);
            make.trailing.equalTo(ws);
            make.height.mas_equalTo(kHeight(156));
        }];
        flowlayout.sectionInset = UIEdgeInsetsMake(0, kWidth(10), 0, kWidth(10));
        flowlayout.minimumLineSpacing = kWidth(10);
        flowlayout.itemSize = CGSizeMake(kWidth(90), kHeight(156));
        [self.collectionView registerClass:[bangumi_3Cell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}
//目前先仅用于推荐页
- (void)setModel:(RecommendModel *)model {
    
    _model = model;
    
    self.dataArray = [NSMutableArray array];
    [self.button setimgView:@"home_region_icon_128" label:model.head[@"title"] buttonBackgroundColor:UIColorFromRGB(0xbbbbbb) content:@"进去看看" btnImg:nil leftLabel:nil];
    
    for (int i = 0; i < model.body.count; i ++) {
        bangumi_3Model *model2 = [[bangumi_3Model alloc] init];
        model2.cover = model.body[i][@"cover"];
        model2.desc1 = model.body[i][@"desc1"];
        model2.title = model.body[i][@"title"];
        [self.dataArray addObject:model2];
    }
    [self.collectionView reloadData];
}


#pragma - mark collectionView datasourse
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    bangumi_3Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}




@end
