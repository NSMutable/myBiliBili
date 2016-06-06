//
//  MainScrollView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/3/31.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "MainScrollView.h"
#import "CartoonListView.h"
#import "RecommendView.h"
#import "PartitionView.h"
#import "ConcernView.h"
#import "DiscoverView.h"

@implementation MainScrollView

- (void)awakeFromNib {
    //基础配置
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.contentSize = CGSizeMake(5 * kScreenWidth, 0);
    self.pagingEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    self.bounces = NO;
    
    NSArray *viewClassArr = @[[CartoonListView class], [RecommendView class], [PartitionView class], [ConcernView class], [DiscoverView class]];
    
    for (int i = 0 ; i < 5; i++) {
        
        UIView *view = [[viewClassArr[i] alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, self.height)];
        [self addSubview:view];
    }
    

}

@end
