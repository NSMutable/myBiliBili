//
//  headImgPlayerModel.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/3.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Type) {
    video
};

@interface headImgPlayerModel : NSObject

@property (nonatomic, assign) NSInteger aid;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, assign) NSInteger pid;
@property (nonatomic, assign) NSInteger platform;
@property (nonatomic, copy) NSString *simg;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) Type type;

@end
