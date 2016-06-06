//
//  CartoonListView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/2.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "CartoonListView.h"
#import "CartoonCollectionHeadView.h"
#import "AFNetworking.h"
#import "CartoonListModel.h"
#import "CartoonListCell.h"


//这个界面暂时先这样😢
@interface CartoonListView ()
{
    NSMutableArray *_dataArr;
    NSMutableArray *_yArr;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CartoonListView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        [self sendRequestForRecommendCartoonData];
        
        [self configUI:frame];
        
    }
    return self;
}

- (void)calculateY {
    _yArr = [NSMutableArray array];
    [_yArr addObject:[NSNumber numberWithFloat:10.0 + 500]];
    [_yArr addObject:[NSNumber numberWithFloat:10.0 + 500]];
    for (int i = 2; i < _dataArr.count; i++) {
        
        CartoonListModel *model = _dataArr[i - 2];
        CGFloat _lastY = [_yArr[i - 2] floatValue];
        CGFloat _currentY = _lastY + model.height / 2 + model.titleHeight + 4 + 20;
        [_yArr addObject:[NSNumber numberWithFloat:_currentY]];
    }
    
}

- (void)configUI:(CGRect)frame {
    //配置collectionView
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, kScreenHeight - 100) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[CartoonListCell class] forCellWithReuseIdentifier:@"CartoonListCell"];
    self.collectionView.bounces = NO;
    UINib *head = [UINib nibWithNibName:@"CartoonCollectionHeadView" bundle:nil];
    [self.collectionView registerNib:head forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CartoonCollectionHeadView"];
    [self addSubview:self.collectionView];
    
    layout.minimumLineSpacing = 10;
}

- (void)sendRequestForRecommendCartoonData {
  
    dispatch_async(dispatch_get_main_queue(), ^{
        
        AFHTTPSessionManager* managerAD = [AFHTTPSessionManager manager];
        [managerAD GET:@"http://app.bilibili.com/promo/android3/2626/bangumi.android3.xhdpi.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            _dataArr = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"list"]) {
                CartoonListModel *modal = [[CartoonListModel alloc] init];
                modal.height = [dic[@"height"] integerValue];
                modal.imagekey = [dic[@"imagekey"] integerValue];
                modal.imageurl = dic[@"imageurl"];
                modal.remark = dic[@"remark"];
                modal.remark2 = dic[@"remark2"];
                modal.spid = [dic[@"spid"] integerValue];
                modal.spname = dic[@"spname"];
                modal.title = dic[@"title"];
                CGRect rect = [modal.title boundingRectWithSize:CGSizeMake((kScreenWidth - 30) / 2, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
                modal.titleHeight = rect.size.height;
                [_dataArr addObject:modal];
            }
            
            
            
            [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

        
    });

}

- (void)reloadData {
    
    [self calculateY];
    
    [self.collectionView reloadData];

}


#pragma - mark collectionDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CartoonListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CartoonListCell" forIndexPath:indexPath];

    
    cell.model = _dataArr[indexPath.row];
    cell.frame = CGRectMake(indexPath.row % 2 ? (kScreenWidth / 2 + 5) : 10, [_yArr[indexPath.row] floatValue], (kScreenWidth - 30) / 2, cell.model.height / 2 + cell.model.titleHeight + 10 + 4);
    
    return cell;
    
}

- (UICollectionReusableView*)collectionView:(UICollectionView*)collectionView viewForSupplementaryElementOfKind:(NSString*)kind atIndexPath:(NSIndexPath*)indexPath
{
    UICollectionReusableView* header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CartoonCollectionHeadView" forIndexPath:indexPath];
    
    return header;
}

#pragma - mark collectionViewFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={320,500};
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CartoonListModel *model = _dataArr[indexPath.row];
    return CGSizeMake((kScreenWidth - 30) / 2, model.height / 2  + model.titleHeight + 4);
}





@end
