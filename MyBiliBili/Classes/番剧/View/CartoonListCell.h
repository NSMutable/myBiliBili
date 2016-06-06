//
//  CartoonListCell.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/5.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartoonListModel.h"

@interface CartoonListCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) CartoonListModel *model;

@end
