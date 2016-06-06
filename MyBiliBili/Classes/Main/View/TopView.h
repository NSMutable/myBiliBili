//
//  TopView.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/3/30.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopView : UIView

@property (nonatomic, strong) UIButton *gameBtn;
@property (nonatomic, strong) UIButton *downLoadBtn;
@property (nonatomic, strong) UIButton *searchBtn;

//左上角登录后显示的名字，或者没登录时显示  未登录
@property (nonatomic, strong) UILabel *loginName;
//左边覆盖在上面的button
@property (nonatomic, strong) UIButton *leftBtn;
//底下可移动的line
@property (nonatomic, strong) UIView *underLine;

//给主页面传点击了哪个按钮
@property (nonatomic, copy) void (^btnClick)(NSInteger);

- (void)changeBtnSelect:(NSInteger) tag;

@end
