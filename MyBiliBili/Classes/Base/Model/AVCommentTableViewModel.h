//
//  AVCommentTableViewModel.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/18.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVCommentTableViewModel : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *rcount;
@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *floor;
@property (nonatomic, strong) NSString *like;
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, strong) NSString *rpid;
@property (nonatomic, assign) CGFloat height;

@end
