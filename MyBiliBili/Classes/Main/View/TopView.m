//
//  TopView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/3/30.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "TopView.h"

@interface TopView ()
{
    //记录上一个点击的按钮的tag值
    NSInteger _lastTouchBtnTag;
}

@end

@implementation TopView



- (void)awakeFromNib {
    [super awakeFromNib];
    [self creatRightButtones];
    [self creatLeftButton];
    [self creatBottomSlider];
}

//右上方的三个按钮
- (void)creatRightButtones {
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame = CGRectMake(kScreenWidth - 30, 28, 15, 15);
    [self.searchBtn setBackgroundImage:IMAGE(@"ic_search.png") forState:UIControlStateNormal];
    [self addSubview:self.searchBtn];
    
    self.downLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downLoadBtn.frame = CGRectMake(kScreenWidth - 70, 28, 15, 15);
    [self.downLoadBtn setBackgroundImage:IMAGE(@"ic_toolbar.png") forState:UIControlStateNormal];
    [self addSubview:self.downLoadBtn];
    
    self.gameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.gameBtn.frame = CGRectMake(kScreenWidth - 115, 28, 20, 15);
    [self.gameBtn setBackgroundImage:IMAGE(@"ic_game.png") forState:UIControlStateNormal];
    [self addSubview:self.gameBtn];
    
}

//左上方的按钮视图
- (void)creatLeftButton {
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 110, 30)];
    btnView.backgroundColor = [UIColor clearColor];
    [self addSubview:btnView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 7, 10)];
    imgView.image = IMAGE(@"ic_drawer_home.png");
    [btnView addSubview:imgView];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 2.5, 25, 25)];
    icon.image = IMAGE(@"bili_default_avatar2.png");
    [btnView addSubview:icon];
    
    self.loginName = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 60, 30)];
    self.loginName.text = @"未登录";
    self.loginName.textColor = [UIColor whiteColor];
    self.loginName.textAlignment = NSTextAlignmentLeft;
    self.loginName.font = [UIFont systemFontOfSize:13];
    [btnView addSubview:self.loginName];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 110, 30);
    [self.leftBtn setBackgroundColor:[UIColor clearColor]];
    [btnView addSubview:self.leftBtn];
    
}

//底下的SLider
- (void)creatBottomSlider {
    
    NSArray *nameArray = @[@"番剧", @"推荐", @"分区", @"关注", @"发现"];
    
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:nameArray[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(kScreenWidth / 5 * i , 66, kScreenWidth / 5, 32);
        [btn setTitleColor:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(moveUnderLine:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:btn];
    }
    UIButton *button = (UIButton *)[self viewWithTag:100];
    button.selected = YES;
    _lastTouchBtnTag = 100;
    
    self.underLine = [[UIView alloc] initWithFrame:CGRectMake(10, 98, kScreenWidth / 5 - 20 , 2)];
    self.underLine.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.underLine];
}

- (void)moveUnderLine:(UIButton *)btn {
    
    [self changeBtnSelect:(btn.tag - 100)];
    
    if(self.btnClick) {
        self.btnClick(btn.tag);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.transform = CGAffineTransformMakeTranslation((btn.tag - 100) * kScreenWidth / 5, 0);
    }];
}
//给这条传值时注意：传的是减去100后的值
- (void)changeBtnSelect:(NSInteger)tag {
    UIButton *LastBtn = (UIButton *)[self viewWithTag:_lastTouchBtnTag];
    LastBtn.selected = NO;
    UIButton *currentBtn = (UIButton *)[self viewWithTag:tag + 100];
    currentBtn.selected = YES;
    _lastTouchBtnTag = tag + 100;
}


@end
