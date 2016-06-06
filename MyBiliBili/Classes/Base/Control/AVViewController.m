//
//  AVViewController.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/17.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "AVViewController.h"
#import "AVViewControllerHeader.h"
#import "AVCommentTableViewModel.h"
#import "AVCommentCell.h"
#import "AVViewControllerHeaderModel.h"
#import "IntroductionHeadView.h"
#import "AVIntroductionHeadModel.h"
#import "AVIntroductionTableViewCellModel.h"
#import "AVIntroductionCell.h"
#import <AFNetworking.h>

@interface AVViewController ()
{
    UIScrollView *_underView;
    
    AVViewControllerHeader *_header;
    
    UITableView *_commentTableView;
    //评论tableView model的数组
    NSMutableArray *_commentDataArray;
    
    NSMutableArray *_introductionCellDataArray;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) AVViewControllerHeaderModel *headerModel;

@property (nonatomic, strong) AVIntroductionHeadModel *introductionHeadModel;

@property (nonatomic, strong) UITableView *introductionTableView;

@property (nonatomic, strong) IntroductionHeadView *introductionHeadView;

@end

@implementation AVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 //   [self sendRequestForInformation];

    [self configUI];
    
}
//这里有毒😭😭
- (void)viewDidAppear:(BOOL)animated {
    
    
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

    UIButton *leftBtn = [UIButton buttonWithType:0];
    [leftBtn setImage:IMAGE(@"icnav_back_light") forState:0];
    [leftBtn addTarget:self action:@selector(backToLastViewCtrl) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}



- (void)backToLastViewCtrl {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configUI {
    
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.navigationController.navigationBar.hidden = YES;
    _underView = [UIScrollView new];
    _underView.backgroundColor = kClearColor;
    _underView.bounces = NO;
    _underView.showsVerticalScrollIndicator = NO;
    _underView.delegate = self;
    [self.view addSubview:_underView];
    WS(ws);
    [_underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(-20, 0, 0, 0));
    }];
    
   
    
    _underView.contentSize = CGSizeMake(0, kScreenHeight + kHeight(214) - kHeight(64) - kHeight(32));
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeight(214), kScreenWidth, kScreenHeight - (kHeight(214) - kHeight(32) - kHeight(64)) + kHeight(20))];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [_underView addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    
    
    _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - (kHeight(214) - kHeight(32) - kHeight(64)) + kHeight(20)) style:UITableViewStylePlain];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.scrollEnabled = NO;
    _commentTableView.backgroundColor = [UIColor clearColor];
    [_commentTableView registerNib:[UINib nibWithNibName:@"AVCommentCell" bundle:nil] forCellReuseIdentifier:@"AVCommentCell"];
    [_scrollView addSubview:_commentTableView];
   
    
    _introductionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (kHeight(214) - kHeight(32) - kHeight(64)) + kHeight(20)) style:UITableViewStylePlain];
    _introductionTableView.delegate = self;
    _introductionTableView.dataSource = self;
    _introductionTableView.scrollEnabled = NO;
    _introductionTableView.separatorStyle = NO;
    _introductionTableView.backgroundColor = kClearColor;
    [_scrollView addSubview:_introductionTableView];
    
    
    self.introductionHeadView = [[IntroductionHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight(300))];
    self.introductionHeadView.sendLineCount = ^(NSInteger i) {
        ws.introductionHeadView.bounds =  CGRectMake(0, 0, kScreenWidth, kHeight(173) + kHeight(20) + kHeight(33) * i);
        ws.introductionTableView.tableHeaderView = ws.introductionHeadView;

    };
    _introductionTableView.tableHeaderView = self.introductionHeadView;
    
    
    
    //放在最上面，使视频全屏时能在最上头
    _header = [[AVViewControllerHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight(214))];
    [_underView addSubview:_header];
    
    
    [_header addObserver:self forKeyPath:@"playBtnFlag" options:NSKeyValueObservingOptionNew context:nil];
    _header.clickBtn = ^(NSInteger i){
        ws.scrollView.contentOffset = CGPointMake(kScreenWidth * (i-1), 0);
    };
}

#pragma - mark ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_header.playBtnFlag == NO) {
        if (scrollView == _underView) {
            if (scrollView.contentOffset.y >= kHeight(214) - kHeight(64) - kHeight(32) - kHeight(20)) {
                _underView.scrollEnabled = NO;
                self.navigationController.navigationBar.hidden = NO;
                [UIView animateWithDuration:.25 animations:^{
                    _header.playBtn.hidden = YES;
                }];
                _commentTableView.scrollEnabled = YES;
                _introductionTableView.scrollEnabled = YES;
            }
        }else if (scrollView == _commentTableView || scrollView == _introductionTableView) {
            if (scrollView.contentOffset.y <= 0) {
                _commentTableView.scrollEnabled = NO;
                _introductionTableView.scrollEnabled = NO;
                
                _underView.scrollEnabled = YES;
                
                [UIView animateWithDuration:.25 animations:^{
                    if (_header.playBtnFlag == NO) {
                        _header.playBtn.hidden = NO;
                    }
                }];
                self.navigationController.navigationBar.hidden = YES;
            }
        }

    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == _scrollView) {
        [_header changeBtn:(scrollView.contentOffset.x / kScreenWidth) + 1];
    }

    
}

#pragma - mark kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"playBtnFlag"]) {
        _underView.scrollEnabled = NO;
        _commentTableView.scrollEnabled = YES;
        _introductionTableView.scrollEnabled = YES;
    }
}


- (void)dealloc {
    [_header removeObserver:self forKeyPath:@"playBtnFlag"];
}
#pragma - mark tableView datasourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _commentTableView) return _commentDataArray.count;
    else  return _introductionCellDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _commentTableView) {
        
        AVCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AVCommentCell"];
        cell.backgroundColor = kClearColor;
        cell.model = _commentDataArray[indexPath.row];
        return cell;
    } else {
        AVIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"introductionCell"];
        if (cell == nil) {
            cell = [[AVIntroductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"introductionCell"];
        }
        cell.model = _introductionCellDataArray[indexPath.row];
        cell.backgroundColor = kClearColor;
        return cell;
    }
    
}

#pragma - mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _commentTableView) {
        AVCommentTableViewModel *model = _commentDataArray[indexPath.row];
        return model.height;
    } else {
        return kHeight(74);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _introductionTableView) {
        
        AVViewController *vc = [[AVViewController alloc] init];
        vc.aid = [_introductionCellDataArray[indexPath.row] aid];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - 发送请求
- (void)setAid:(NSString *)aid {
    
    _aid = aid;
    _commentDataArray = [NSMutableArray array];
    
    AFHTTPSessionManager* managerAD = [AFHTTPSessionManager manager];
    
    
    [managerAD GET:[NSString stringWithFormat:@"http://api.bilibili.com/x/reply?_device=android&_hwid=646dc75290b23698&appkey=c1b107428d337928&build=414000&oid=%@&platform=android&pn=1&ps=20&sort=0&type=1", aid]  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        for (NSDictionary *dict in responseObject[@"data"][@"hots"]) {
            
            AVCommentTableViewModel *model = [[AVCommentTableViewModel alloc] init];
            model.avatar = dict[@"member"][@"avatar"];
            model.uname = dict[@"member"][@"uname"];
            model.sex = dict[@"member"][@"sex"];
            model.rcount = dict[@"rcount"];
            model.like = dict[@"like"];
            model.floor = dict[@"floor"];
            model.ctime = dict[@"ctime"];
            if (dict[@"content"] != [NSNull null]) {
                model.message = dict[@"content"][@"message"];

            }
            
            CGRect rect = [model.message boundingRectWithSize:CGSizeMake(kScreenWidth - 66, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                            NSFontAttributeName:[UIFont systemFontOfSize:12]
                                                                                                                                                            } context:nil];
            model.height = rect.size.height + 62;
            [_commentDataArray addObject:model];
        }
        for (NSDictionary *dict in responseObject[@"data"][@"replies"]) {
            
            AVCommentTableViewModel *model = [[AVCommentTableViewModel alloc] init];
            model.avatar = dict[@"member"][@"avatar"];
            model.uname = dict[@"member"][@"uname"];
            model.sex = dict[@"member"][@"sex"];
            model.rcount = dict[@"rcount"];
            model.like = dict[@"like"];
            model.floor = dict[@"floor"];
            model.ctime = dict[@"ctime"];
            if (dict[@"content"] != [NSNull null]) {
                model.message = dict[@"content"][@"message"];
                
            }
            CGRect rect = [model.message boundingRectWithSize:CGSizeMake(kScreenWidth - 66, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                            NSFontAttributeName:[UIFont systemFontOfSize:12]
                                                                                                                                                            } context:nil];
            model.height = rect.size.height + 62;
            [_commentDataArray addObject:model];
        }
        [_commentTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    _introductionCellDataArray = [NSMutableArray array];
    
    [managerAD GET:[NSString stringWithFormat:@"http://app.bilibili.com/x/view?_device=android&_hwid=646dc75290b23698&aid=%@&appkey=c1b107428d337928&build=414000&plat=0&platform=android&ts=1461541239000", aid]  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.headerModel = [[AVViewControllerHeaderModel alloc] init];
        self.headerModel.pic = responseObject[@"data"][@"pic"];
        self.headerModel.aid = responseObject[@"data"][@"aid"];
        self.headerModel.reply = responseObject[@"data"][@"stat"][@"reply"];
        _header.model = self.headerModel;
        
        self.introductionHeadModel = [[AVIntroductionHeadModel alloc] init];
        self.introductionHeadModel.title = responseObject[@"data"][@"title"];
        self.introductionHeadModel.desc = responseObject[@"data"][@"desc"];
        self.introductionHeadModel.pubdate = responseObject[@"data"][@"pubdate"];
        self.introductionHeadModel.danmaku = responseObject[@"data"][@"relates"][0][@"stat"][@"danmaku"];
        self.introductionHeadModel.view = responseObject[@"data"][@"relates"][0][@"stat"][@"view"];
        self.introductionHeadModel.face = responseObject[@"data"][@"owner"][@"face"];
        self.introductionHeadModel.name = responseObject[@"data"][@"owner"][@"name"];
        self.introductionHeadModel.tags = responseObject[@"data"][@"tags"];
        IntroductionHeadView *headView = (IntroductionHeadView *)_introductionTableView.tableHeaderView;
        headView.model = self.introductionHeadModel;
        
        
        for (NSDictionary *dic in responseObject[@"data"][@"relates"]) {
            AVIntroductionTableViewCellModel *model = [[AVIntroductionTableViewCellModel alloc] init];
            model.pic = dic[@"pic"];
            model.title = dic[@"title"];
            model.name = dic[@"owner"][@"name"];
            model.view = dic[@"stat"][@"view"];
            model.danmaku = dic[@"stat"][@"danmaku"];
            model.aid = dic[@"aid"];
            [_introductionCellDataArray addObject:model];
        }
        [self.introductionTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}

- (void)sendRequestForInformation {
    
    _commentDataArray = [NSMutableArray array];
    
    AFHTTPSessionManager* managerAD = [AFHTTPSessionManager manager];
    
    
    [managerAD GET:@"http://api.bilibili.com/x/reply?_device=android&_hwid=646dc75290b23698&appkey=c1b107428d337928&build=414000&oid=4442427&platform=android&pn=1&ps=20&sort=0&type=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        for (NSDictionary *dict in responseObject[@"data"][@"hots"]) {
            
            AVCommentTableViewModel *model = [[AVCommentTableViewModel alloc] init];
            model.avatar = dict[@"member"][@"avatar"];
            model.uname = dict[@"member"][@"uname"];
            model.sex = dict[@"member"][@"sex"];
            model.rcount = dict[@"rcount"];
            model.like = dict[@"like"];
            model.floor = dict[@"floor"];
            model.ctime = dict[@"ctime"];
            model.message = dict[@"content"][@"message"];
            CGRect rect = [model.message boundingRectWithSize:CGSizeMake(kScreenWidth - 66, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                            NSFontAttributeName:[UIFont systemFontOfSize:12]
                                                                                                                                                            } context:nil];
            model.height = rect.size.height + 62;
            [_commentDataArray addObject:model];
        }
        for (NSDictionary *dict in responseObject[@"data"][@"replies"]) {
            
            AVCommentTableViewModel *model = [[AVCommentTableViewModel alloc] init];
            model.avatar = dict[@"member"][@"avatar"];
            model.uname = dict[@"member"][@"uname"];
            model.sex = dict[@"member"][@"sex"];
            model.rcount = dict[@"rcount"];
            model.like = dict[@"like"];
            model.floor = dict[@"floor"];
            model.ctime = dict[@"ctime"];
            model.message = dict[@"content"][@"message"];
            CGRect rect = [model.message boundingRectWithSize:CGSizeMake(kScreenWidth - 66, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                            NSFontAttributeName:[UIFont systemFontOfSize:12]
                                                                                                                                                            } context:nil];
            model.height = rect.size.height + 62;
            [_commentDataArray addObject:model];
        }
        [_commentTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    _introductionCellDataArray = [NSMutableArray array];
    
    [managerAD GET:@"http://app.bilibili.com/x/view?_device=android&_hwid=646dc75290b23698&aid=4442427&appkey=c1b107428d337928&build=414000&plat=0&platform=android&ts=1461541239000" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.headerModel = [[AVViewControllerHeaderModel alloc] init];
        self.headerModel.pic = responseObject[@"data"][@"pic"];
        self.headerModel.aid = responseObject[@"data"][@"aid"];
        self.headerModel.reply = responseObject[@"data"][@"stat"][@"reply"];
        _header.model = self.headerModel;
        
        self.introductionHeadModel = [[AVIntroductionHeadModel alloc] init];
        self.introductionHeadModel.title = responseObject[@"data"][@"title"];
        self.introductionHeadModel.desc = responseObject[@"data"][@"desc"];
        self.introductionHeadModel.pubdate = responseObject[@"data"][@"pubdate"];
        self.introductionHeadModel.danmaku = responseObject[@"data"][@"relates"][0][@"stat"][@"danmaku"];
        self.introductionHeadModel.view = responseObject[@"data"][@"relates"][0][@"stat"][@"view"];
        self.introductionHeadModel.face = responseObject[@"data"][@"owner"][@"face"];
        self.introductionHeadModel.name = responseObject[@"data"][@"owner"][@"name"];
        self.introductionHeadModel.tags = responseObject[@"data"][@"tags"];
        IntroductionHeadView *headView = (IntroductionHeadView *)_introductionTableView.tableHeaderView;
        headView.model = self.introductionHeadModel;
        
        
        for (NSDictionary *dic in responseObject[@"data"][@"relates"]) {
            AVIntroductionTableViewCellModel *model = [[AVIntroductionTableViewCellModel alloc] init];
            model.pic = dic[@"pic"];
            model.title = dic[@"title"];
            model.name = dic[@"owner"][@"name"];
            model.view = dic[@"stat"][@"view"];
            model.danmaku = dic[@"stat"][@"danmaku"];
            [_introductionCellDataArray addObject:model];
        }
        [self.introductionTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
