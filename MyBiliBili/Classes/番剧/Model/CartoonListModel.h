//
//  CartoonListModel.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/5.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartoonListModel : NSObject

@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger imagekey;
@property (nonatomic, strong) NSString *imageurl;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *remark2;
@property (nonatomic, assign) NSInteger spid;
@property (nonatomic, strong) NSString *spname;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat titleHeight;


@end
