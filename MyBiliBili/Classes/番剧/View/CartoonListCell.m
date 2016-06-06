//
//  CartoonListCell.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/5.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "CartoonListCell.h"

@implementation CartoonListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imgView];
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_titleLable];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.font = [UIFont systemFontOfSize:12];
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.numberOfLines = 0;

    }
    return self;
}


- (void)setModel:(CartoonListModel *)model {
    
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.imageurl]];
    _imgView.frame = CGRectMake(0, 0, (kScreenWidth - 30) / 2, _model.height / 2);
    
    _titleLable.text= _model.title;
    _titleLable.frame = CGRectMake(0, _imgView.bottom + 2, (kScreenWidth - 30) / 2, _model.titleHeight);

}

@end
