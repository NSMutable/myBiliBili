//
//  AVViewController.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/17.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVViewController : UIViewController<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) NSString *aid;

@end
