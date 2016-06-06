//
//  RecommendView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/2.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "RecommendView.h"
#import "AFNetworking.h"
#import "RecommendModel.h"
#import "recommenViewCell.h"

@interface RecommendView ()<UITableViewDataSource, UITableViewDelegate>

{
    NSMutableArray *_dataArray;
}

@property (nonatomic, strong) RecommendModel *recommendModel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RecommendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.recommendModel = [[RecommendModel alloc] init];
        self.backgroundColor = UIColorFromRGB(0xf2f2f2);

        [self sendRequestForInformation];
        
        [self configUI];
        
    }
    return self;
}

- (void)configUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = kClearColor;
    WS(ws);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
}

#pragma -mark tableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    recommenViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[recommenViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = kClearColor;
    cell.recommendModel = _dataArray[indexPath.row];
    cell.selectionStyle = NO;
    return cell;
}

- (void)sendRequestForInformation {
    
    _dataArray = [NSMutableArray array];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    
    [manager GET:@"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=index&platform=android&screen=xxhdpi&test=0&ts=1450884356000" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"%@", responseObject[@"result"]);
        
        for (int i = 0 ; i < [responseObject[@"result"] count]; i++) {
            RecommendModel *model = [[RecommendModel alloc] init];
            model.body = responseObject[@"result"][i][@"body"];
            model.head = responseObject[@"result"][i][@"head"];
            model.type = responseObject[@"result"][i][@"type"];
            [_dataArray addObject:model];
        }
        
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecommendModel *model = _dataArray[indexPath.row];
    if ([model.type isEqualToString:@"weblink"]) {
        return kHeight(160);
    } else if (model.type == nil) {
        return kHeight(100);
    } else if ([model.type isEqualToString:@"bangumi_2"]) {
        return kHeight(330);
    } else if ([model.type isEqualToString:@"bangumi_3"]) {
        return kHeight(205);
    }
        return kHeight(360);
}

@end
