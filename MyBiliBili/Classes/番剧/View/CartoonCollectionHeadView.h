//
//  CartoonCollectionHeadView.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/2.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "ImagePlayerView.h"
#import <UIKit/UIKit.h>

@interface CartoonCollectionHeadView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet ImagePlayerView *imagePlayView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end
