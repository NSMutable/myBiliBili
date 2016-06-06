//
//  PublicButton.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/3.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "PublicButton.h"

@implementation PublicButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        //基础配置
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 2.5, 20, 20)];
        [self addSubview:self.imgView];
        
        self.lable = [[UILabel alloc] initWithFrame:CGRectMake(40, 2.5, 100, 20)];
        self.lable.textAlignment = NSTextAlignmentLeft;
        self.lable.textColor = [UIColor blackColor];
        self.lable.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.lable];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.button.titleLabel.font = [UIFont systemFontOfSize:11];
        self.button.layer.cornerRadius = 2;
        [self addSubview:self.button];
        
        self.leftLable = [UILabel new];
        self.leftLable.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.leftLable];


    }
    return self;
}

- (void)setimgView:(NSString *)img label:(NSString *)title buttonBackgroundColor:(UIColor *)backgroundColor content:(NSString *)content btnImg:(NSString *)btnImg leftLabel:(NSString *)str {
    self.imgView.image = [UIImage imageNamed:img];
    self.lable.text = title;
    [self.button setBackgroundColor:backgroundColor];
    if (btnImg != nil) {
        [self.button setImage:[UIImage imageNamed:btnImg] forState:UIControlStateNormal];

    }
   
    [self.button setTitle:content forState:UIControlStateNormal];
    [self.button sizeToFit];
    self.button.frame = CGRectMake(kScreenWidth - self.button.width - 20, 0, self.button.width + 10, self.button.height);
    
    
    if (str != nil) {
        self.leftLable.text = str;
        WS(ws);
        [self.leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.button.mas_left).with.offset(-kWidth(2));
            make.centerY.equalTo(ws.button.mas_centerY);
        }];
    }
}


@end
