//
//  WeblinkViewController.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/25.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "WeblinkViewController.h"

@interface WeblinkViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WeblinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
}



- (void)addData:(NSString *)urlStr {
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
