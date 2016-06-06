//
//  AVCommentCell.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/18.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "AVCommentCell.h"

@implementation AVCommentCell

- (void)awakeFromNib {
    self.icon.layer.cornerRadius = 16;
}

- (void)setModel:(AVCommentTableViewModel *)model {
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_model.avatar]];
    self.nameLable.text = model.uname;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *currentTime = [NSDate dateWithTimeIntervalSince1970:[model.ctime integerValue]];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [formatter stringFromDate: currentTime];
    self.dataLable.text = [NSString stringWithFormat:@"#%@  %@", model.floor, currentDateStr];
    self.messageLable.text = model.message;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
