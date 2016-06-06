//
//  SideSlideView.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/1.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideSlideView : UIView<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property (weak, nonatomic) IBOutlet UIButton *moveBtn;

//点击后移回去
@property (weak, nonatomic) IBOutlet UIButton *moveBack;

@end
