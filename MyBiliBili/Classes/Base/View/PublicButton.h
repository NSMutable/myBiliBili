//
//  PublicButton.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/3.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PublicButton : UIControl

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *leftLable;

- (void)setimgView:(NSString *)img label:(NSString *)title buttonBackgroundColor:(UIColor *)backgroundColor content:(NSString *)content btnImg:(NSString *)btnImg leftLabel:(NSString *)str;

@end
