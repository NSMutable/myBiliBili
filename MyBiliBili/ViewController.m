//
//  ViewController.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/3/30.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "TopView.h"
#import "MainScrollView.h"
#import "SideSlideView.h"

@interface ViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet TopView *topView;
@property (weak, nonatomic) IBOutlet MainScrollView *mainScrollView;
@property (strong, nonatomic) SideSlideView *sideSlideView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    [self configSideSlide];
    [self configTopView];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}



- (void)configTopView {
    self.topView.btnClick = ^(NSInteger tag){
        self.mainScrollView.contentOffset = CGPointMake((tag - 100) * kScreenWidth, 0);
    };
    
    [self.topView.leftBtn addTarget:self action:@selector(showSideSlide) forControlEvents:UIControlEventTouchUpInside];
}


- (void)configSideSlide {
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"SideSlideView" owner:nil options:nil];
    self.sideSlideView = [arr firstObject];
    self.sideSlideView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:self.sideSlideView];
    [self.sideSlideView.moveBack addTarget:self action:@selector(hideSideSlide) forControlEvents:UIControlEventTouchUpInside];
    
    //添加手势动作
//    UISwipeGestureRecognizer *swipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideSideSlide:)];
//    [swipGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.sideSlideView addGestureRecognizer:swipGesture];
    
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveSideSlide:)];
    [self.sideSlideView addGestureRecognizer:gestureRecognizer];
    
//   swipGesture.delegate = self;
//   gestureRecognizer.delegate = self;
//   [gestureRecognizer requireGestureRecognizerToFail:swipGesture];

    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    [UIView animateWithDuration:0.25 animations:^{
        self.topView.underLine.transform = CGAffineTransformMakeTranslation(x / 5, 0);
    }];
    
}


//两个按钮控制侧滑栏的操作
- (void)showSideSlide {
    [UIView animateWithDuration:0.4 animations:^{
        self.sideSlideView.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
    }];
    
    
}
- (void)hideSideSlide {
    [UIView animateWithDuration:0.4 animations:^{
        self.sideSlideView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    
    
    
}

//手势动作
- (void)hideSideSlide:(UISwipeGestureRecognizer *)recognizer {
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [UIView animateWithDuration:0.4 animations:^{
            self.sideSlideView.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }
}

- (void)moveSideSlide:(UIPanGestureRecognizer *)recognizer {
    CGPoint trans = [recognizer translationInView:recognizer.view];
    
    if (trans.x < 0 ) {
        CGFloat currentX = trans.x;
        self.sideSlideView.transform = CGAffineTransformMakeTranslation(currentX + kScreenWidth, 0);
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (trans.x < - self.sideSlideView.tableView.width / 2) {
            [UIView animateWithDuration:0.4 animations:^{
                self.sideSlideView.transform = CGAffineTransformMakeTranslation(0, 0);
            }];
        }else {
            [UIView animateWithDuration:0.4 animations:^{
                self.sideSlideView.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
            }];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self.topView changeBtnSelect:((scrollView.contentOffset.x + kScreenWidth * 0.5) / kScreenWidth)];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
