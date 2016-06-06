//
//  SideSlideView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/1.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "SideSlideView.h"

@interface SideSlideView ()
{
    NSArray *_dataArr;
}

@end

@implementation SideSlideView



- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self loadData];
    //配置tableview的头视图
    [self creatTableViewHeader];
    //配置tableview的内容
    [self configTableview];
    
}

- (void)loadData {

    _dataArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Setting.plist" ofType:nil]];
    
}

- (void)creatTableViewHeader {
    UIImageView *underView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 150)];
    underView.image = IMAGE(@"hd_homepage_thread_more_0");
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(10, 30, 70, 70);
    [loginBtn setBackgroundImage:IMAGE(@"bili_default_avatar2") forState:UIControlStateNormal];
    [underView addSubview:loginBtn];
    
    UILabel *loginLable = [[UILabel alloc] initWithFrame:CGRectMake(11, 105, 100, 30)];
    loginLable.text = @"点击头像登录";
    loginLable.textAlignment = NSTextAlignmentLeft;
    loginLable.textColor = [UIColor whiteColor];
    loginLable.font = [UIFont boldSystemFontOfSize:13];
    [underView addSubview:loginLable];
    
   
    self.tableView.tableHeaderView = underView;
}

- (void)configTableview {
    self.tableView.rowHeight = 44;
}


#pragma - mark tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_dataArr[section][@"item"] count];;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    }
    NSArray *arr = _dataArr[indexPath.section][@"item"];
    
    //改变下大小😂
    UIImage *icon = IMAGE(arr[indexPath.row][@"icon"]);
    CGSize itemSize = CGSizeMake(25, 25);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  
    
    cell.imageView.alpha = 0.6;
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"    %@", arr[indexPath.row][@"title"]];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

#pragma - mark tableView delegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 10)];
    view1.backgroundColor = [UIColor whiteColor];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 10)];
    UIView *mediuLine = [[UIView alloc] initWithFrame:CGRectMake(0, 5, self.tableView.width, 0.5)];
    mediuLine.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    [view2 addSubview:mediuLine];
    
    return section == 0 ? view1 : view2;
    
}


@end
