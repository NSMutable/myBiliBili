//
//  AVCommentCell.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/18.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCommentTableViewModel.h"


@interface AVCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *dataLable;
@property (weak, nonatomic) IBOutlet UILabel *messageLable;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgView;

@property (nonatomic, strong) AVCommentTableViewModel *model;

@end
