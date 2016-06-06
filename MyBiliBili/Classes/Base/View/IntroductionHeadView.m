//
//  IntroductionHeadView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/19.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "IntroductionHeadView.h"

@interface IntroductionHeadView ()
{
    NSMutableArray *_cellWidthArray;
}
@end

@implementation IntroductionHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        WS(ws);
        self.titleLable = [UILabel new];
        self.titleLable.numberOfLines = 2;
        self.titleLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.mas_top).with.offset(kHeight(10));
            make.left.equalTo(ws.mas_left).with.offset(kWidth(10));
            make.right.equalTo(ws.mas_right).with.offset(-kWidth(10));
            make.height.mas_equalTo(@kHeight(32));
        }];
        
        self.danmakuLabel = [UILabel new];
        [self addSubview:self.danmakuLabel];
        [self.danmakuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(ws.titleLable);
            make.top.equalTo(ws.titleLable.mas_bottom).with.mas_equalTo(kHeight(6));
            make.height.mas_equalTo(kHeight(12));
        }];
      
       
        
        self.descLable = [UILabel new];
        self.descLable.numberOfLines = 2;
        self.descLable.font = [UIFont systemFontOfSize:11];
        self.descLable.textColor = UIColorFromRGB(0xa2a2a2);
        [self addSubview:self.descLable];
        
        [self.descLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(ws.titleLable);
            make.right.equalTo(ws.mas_right).with.offset(-kWidth(22));
            make.top.equalTo(ws.danmakuLabel.mas_bottom).with.offset(kHeight(10));
        }];
        
#pragma -mark 中间的字幕组
        
        UIView *underLine = [UIView new];
        underLine.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self addSubview:underLine];
        [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.descLable.mas_bottom).with.offset(kHeight(12));
            make.leading.equalTo(ws);
            make.trailing.equalTo(ws);
            make.height.mas_equalTo(kHeight(1));
        }];
        
        self.ownerImgView = [UIImageView new];
        [self addSubview:self.ownerImgView];
        [self.ownerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(underLine.mas_bottom).with.offset(kHeight(10));
            make.left.equalTo(ws.mas_left).with.offset(kWidth(10));
            make.size.mas_equalTo(CGSizeMake(kHeight(28), kHeight(28)));
        }];
        self.ownerImgView.layer.cornerRadius = kHeight(14);
        
        self.ownerNamelabel = [UILabel new];
        self.ownerNamelabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.ownerNamelabel];
        [self.ownerNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.ownerImgView.mas_top);
            make.left.equalTo(ws.ownerImgView.mas_right).with.offset(kWidth(10));
            make.height.mas_equalTo(kHeight(12));
        }];
        
        self.pubdateLable = [UILabel new];
        self.pubdateLable.font = [UIFont systemFontOfSize:10];
        self.pubdateLable.textColor = UIColorFromRGB(0xa2a2a2);
        [self addSubview:self.pubdateLable];
        [self.pubdateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.ownerNamelabel.mas_bottom).with.offset(kHeight(4));
            make.leading.equalTo(ws.ownerNamelabel);
        }];
        
        UIButton *followBtn = [UIButton buttonWithType:0];
        [followBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [followBtn setTitleColor:UIColorFromRGB(0xff6aa0) forState:UIControlStateNormal];
        followBtn.layer.borderWidth = kHeight(1);
        followBtn.layer.borderColor = UIColorFromRGB(0xff6aa0).CGColor;
        followBtn.layer.cornerRadius = kHeight(4);
        followBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:followBtn];
        [followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(underLine.mas_bottom).with.offset(kHeight(12));
            make.right.equalTo(ws.mas_right).with.offset(-kWidth(10));
            make.size.mas_equalTo(CGSizeMake(kWidth(42), kHeight(25)));
        }];
        
        UIView *underLine1 = [UIView new];
        underLine1.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self addSubview:underLine1];
        [underLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.ownerImgView.mas_bottom).with.offset(kHeight(10));
            make.leading.equalTo(ws);
            make.trailing.equalTo(ws);
            make.height.mas_equalTo(kHeight(1));
        }];
        
#pragma - mark 视频相关
        UILabel *videoTagsLable = [UILabel new];
        videoTagsLable.text = @"视频相关";
        videoTagsLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:videoTagsLable];
        [videoTagsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.mas_left).with.offset(kWidth(10));
            make.top.equalTo(underLine1.mas_bottom).with.offset(kHeight(10));
            make.height.mas_equalTo(kHeight(16));
        }];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = kClearColor;
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(videoTagsLable.mas_bottom).with.offset(kHeight(10));
            make.leading.and.trailing.equalTo(ws);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(kHeight(100));
        }];
        flowLayout.minimumInteritemSpacing = kWidth(9.99);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kWidth(10), 0, kWidth(10));
        
    }
    return self;
}

#pragma - mark collectionView datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.tags.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = kWhiteColor;
    cell.layer.cornerRadius = kWidth(1);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [_cellWidthArray[indexPath.row] floatValue], kHeight(24))];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.model.tags[indexPath.row];
    [cell.contentView addSubview:label];
    return cell;
}
#pragma - mark collection flowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([_cellWidthArray[indexPath.row] floatValue], kHeight(24));
}

- (void)setModel:(AVIntroductionHeadModel *)model {
    
    _model = model;
    
    self.titleLable.text = model.title;
    self.descLable.text = model.desc;
    
    [self.ownerImgView sd_setImageWithURL:[NSURL URLWithString:model.face]];
    self.ownerNamelabel.text = model.name;
    
    NSInteger viewTimes = [model.view integerValue];
    NSString *viewStr;
    if (viewTimes >= 10000) {
        viewStr = [NSString stringWithFormat:@"%li.%li万", viewTimes / 10000, (viewTimes % 10000) / 1000];
    } else {
        viewStr = [NSString stringWithFormat:@"%li", viewTimes];
    }
    
    NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@  ", viewStr]];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, viewStr.length + 1)];
    [attri addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xa2a2a2) range:NSMakeRange(0, viewStr.length + 1)];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"list_playnumb_icon"];
    attch.bounds = CGRectMake(0, 0, kHeight(9), kHeight(9));
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    
    NSTextAttachment *attch1 = [[NSTextAttachment alloc] init];
    attch1.image = [UIImage imageNamed:@"list_danmaku_icon"];
    attch1.bounds = CGRectMake(0, 0, kHeight(9), kHeight(9));
    NSAttributedString *string1 = [NSAttributedString attributedStringWithAttachment:attch1];
    [attri appendAttributedString:string1];
    
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@         ", model.danmaku] attributes:@{
                                                                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:11],
                                                                                                                                                     NSForegroundColorAttributeName:UIColorFromRGB(0xa2a2a2)
                                                                                                                                                     }                                          ];
    [attri appendAttributedString:string2];
    

    self.danmakuLabel.attributedText = attri;
    
    
    // 获取当前时时间戳
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建时间戳
    NSTimeInterval createTime = [model.pubdate integerValue];
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    NSString *pubDate;
    // 秒转小时
    NSInteger hours = time/3600;
    NSInteger days = time/3600/24;
    NSInteger months = time/3600/24/30;
    NSInteger years = time/3600/24/30/12;

    if (hours<24) {
        pubDate = [NSString stringWithFormat:@"%ld小时前",hours];
    } else if (days < 30) {
        pubDate = [NSString stringWithFormat:@"%ld天前",days];
    } else if (months < 12) {
        pubDate = [NSString stringWithFormat:@"%ld月前",months];
    } else {
        pubDate = [NSString stringWithFormat:@"%ld年前",years];
    }
    self.pubdateLable.text = [NSString stringWithFormat:@"%@投递", pubDate];
    [self calculateCellWidth:_model.tags];
}
#pragma - mark 计算collectionViewcell 的每个宽度
- (void)calculateCellWidth:(NSArray *)arr {
    /*
     计算规则：1.最多一行五个 2.最多一行有25个字
     用数组记录下每行几个
     还得用个数组保存model给的每个字符串的width
     */
    _cellWidthArray = [NSMutableArray array];
    NSMutableArray *countArray = [NSMutableArray array];
    NSInteger length = 0;
    NSInteger lastCount = 0;
    for (int i = 1; i <= arr.count; i++) {
        
        NSString *str = arr[i - 1];
        length += str.length;
        if ((i - lastCount) >= 6 || length > 25) {
            length = 0;
            [countArray addObject:[NSNumber numberWithInteger:(i - lastCount - 1)]];
            lastCount += i - lastCount - 1;
        }
    }
    [countArray addObject:[NSNumber numberWithInteger:(arr.count - lastCount)]];

    NSMutableArray *strWidth = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSString *str = arr[i];
        CGRect rect = [str boundingRectWithSize:CGSizeMake(999, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                               NSFontAttributeName:[UIFont systemFontOfSize:12]
                                                                                                                               } context:nil];
        [strWidth addObject:[NSNumber numberWithFloat:rect.size.width]];
    }
    
    //回调
    if (self.sendLineCount) {
        self.sendLineCount(countArray.count);
    }
    int count = 0;
    for (int i = 0; i < countArray.count - 1; i++) {
        
        CGFloat restWidth1 = kScreenWidth - kWidth(10) * 2 - kWidth(10) * ([countArray[i] integerValue] - 1);
        CGFloat restWidth2 = restWidth1;
        
        for (int j = 0; j < [countArray[i] integerValue]; j++) {
            restWidth2 = restWidth2 - [strWidth[j + count] floatValue];
        }
        //计算的最后需要的字旁边的边框大小
        CGFloat edgWidth = restWidth2 / [countArray[i] integerValue];
        for (int z = 0; z < [countArray[i] integerValue]; z++) {
            [_cellWidthArray addObject:[NSNumber numberWithFloat:([strWidth[z + count] floatValue] + edgWidth)]];
        }
        
        count += [countArray[i] integerValue];
    }
    
    for (int i = 0; i < [[countArray lastObject] integerValue]; i++) {
        NSInteger j = strWidth.count - [[countArray lastObject] integerValue];
        [_cellWidthArray addObject:[NSNumber numberWithFloat:([strWidth[j + i] floatValue] + kWidth(10))]];
    }
    [self.collectionView reloadData];

}

@end
