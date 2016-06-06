//
//  AvPlayerView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/26.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "AvPlayerView.h"
#import "AVViewControllerHeader.h"
#import <AFNetworking.h>
#define ORIENTATION [UIDevice currentDevice].orientation


@interface AvPlayerView ()
{
    //初始的大小
    CGRect instanceFrame;

}

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *underView;

@property (nonatomic, strong) UILabel *startTime;

@property (nonatomic, strong) UILabel *totleTime;

@property (nonatomic, strong) UISlider *progress;

//简易的判断下是否是加载状态，以后有空回来修改
@property (nonatomic, assign) BOOL isFirstPlay;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end


@implementation AvPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.isFirstPlay = YES;
        
        instanceFrame = frame;
    }
    return self;
}


#pragma mark - 上头控制返回等功能的视图
- (void)configTopView {
    
    self.topView = [UIView new];
    self.topView.backgroundColor = kBlackColor;
    self.topView.alpha = 0.2;
    [self addSubview:self.topView];
    WS(ws);
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_top);
        make.leading.equalTo(ws);
        make.trailing.equalTo(ws);
        make.height.mas_equalTo(kHeight(40));
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:IMAGE(@"hd_icmpv_back_light") forState:UIControlStateNormal];
    [self.topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.topView.mas_top).with.offset(kHeight(20));
        make.left.equalTo(ws.topView.mas_left).with.offset(kWidth(16));
        make.size.mas_equalTo(CGSizeMake(kWidth(17), kHeight(16)));
    }];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.topView.hidden = YES;
}

- (void)backAction {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 底下控制进度和播放的视图
- (void)configUnderView {
    
    
    self.underView = [UIView new];
    self.underView.backgroundColor = kBlackColor;
    self.underView.alpha = 0.2;
    [self addSubview:self.underView];
    WS(ws);
    [self.underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottom);
        make.leading.equalTo(ws);
        make.trailing.equalTo(ws);
        make.height.mas_equalTo(kHeight(60));
    }];
    
    UIButton *lPlayBtn = [UIButton buttonWithType:0];
    [lPlayBtn setImage:IMAGE(@"icmpv_pause_light") forState:UIControlStateNormal];
    [lPlayBtn setImage:IMAGE(@"icmpv_play_light") forState:UIControlStateSelected];
    [lPlayBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    lPlayBtn.tag = 101;
    [self.underView addSubview:lPlayBtn];
    [lPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.underView.mas_right).with.offset(-kWidth(10));
        make.top.equalTo(ws.underView);
        make.size.mas_equalTo(CGSizeMake(kHeight(30), kHeight(30)));
    }];
    
    UIButton *sPlayBtn = [UIButton buttonWithType:0];
    [sPlayBtn setImage:IMAGE(@"download_stop") forState:UIControlStateNormal];
    [sPlayBtn setImage:IMAGE(@"download_start") forState:UIControlStateSelected];
    sPlayBtn.tag = 102;
    [sPlayBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.underView addSubview:sPlayBtn];
    [sPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.underView.mas_left).with.offset(kWidth(10));
        make.bottom.equalTo(ws.underView.mas_bottom).with.offset(-kHeight(4));
        make.size.mas_equalTo(CGSizeMake(kHeight(22), kHeight(22)));
    }];
    
    
    self.startTime = [UILabel new];
    self.startTime.text = @"00:00";
    self.startTime.textColor = kWhiteColor;
    self.startTime.font = [UIFont systemFontOfSize:12];
    [self.underView addSubview:self.startTime];
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sPlayBtn.mas_right).with.offset(kWidth(4));
        make.centerY.equalTo(sPlayBtn);
    }];
    
    UIButton *bigBtn = [UIButton buttonWithType:0];
    [bigBtn setImage:IMAGE(@"set_scale_icon") forState:0];
    [bigBtn addTarget:self action:@selector(scale:) forControlEvents:UIControlEventTouchUpInside];
    [self.underView addSubview:bigBtn];
    [bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.underView.mas_right).with.offset(-kWidth(10));
        make.centerY.equalTo(sPlayBtn);
        make.width.equalTo(sPlayBtn);
        make.height.equalTo(sPlayBtn);
    }];
    
    self.totleTime = [UILabel new];
    self.totleTime.text = @"00:00";
    self.totleTime.textColor = kWhiteColor;
    self.totleTime.font = [UIFont systemFontOfSize:12];
    [self.underView addSubview:self.totleTime];
    [self.totleTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bigBtn.mas_left).with.offset(-kWidth(4));
        make.centerY.equalTo(ws.startTime);
    }];
    
    
    self.progress = [UISlider new];
    self.progress.minimumTrackTintColor = UIColorFromRGB(0xe87fa5);
    self.progress.maximumTrackTintColor = kClearColor;
    [self.progress addTarget:self action:@selector(progressSliderChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.progress setThumbImage:IMAGE(@"icmpv_thumb_light") forState:UIControlStateNormal];
    [self.underView addSubview:self.progress];
    
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.startTime.mas_right).with.offset(kWidth(4));
        make.centerY.equalTo(ws.startTime);
        make.height.mas_equalTo(kHeight(1));
        make.right.equalTo(ws.totleTime.mas_left).with.offset(-kWidth(4));
    }];
    
    self.underView.hidden = YES;
    
}
#pragma - mark 拖动进度条
- (void)progressSliderChange:(UISlider *)sender {
    
    CMTime cmTime = CMTimeMake(sender.value, 1);
    [self.player seekToTime:cmTime];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.underView.hidden = !self.underView.hidden;
    self.topView.hidden = !self.topView.hidden;
}

- (void)btnAction:(UIButton *)btn {
    
    UIButton *btn1 = [self viewWithTag:101];
    UIButton *btn2 = [self viewWithTag:102];
    btn1.selected = !btn1.selected;
    btn2.selected = !btn2.selected;
    
    if (btn1.selected) {
        [self.player pause];
    } else {
        [self.player play];
    }
}



#pragma - mark 接收aid的同时发送网络请求获得cid
- (void)setAid:(NSString *)aid {

    _aid = aid;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    [manager GET:[NSString stringWithFormat:@"http://www.bilibilijj.com/Api/AvToCid/%@", aid] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [self getMovieUrl:responseObject[@"list"][0][@"AV"] cid:responseObject[@"list"][0][@"CID"]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
}

- (void)getMovieUrl:(NSString *)aid cid:(NSString *)cid{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"http://interface.bilibili.com/playurl?platform=android&_device=android&_hwid=831fc7511fa9aff5&_tid=0&_p=1&_down=0&quality=3&otype=json&appkey=86385cdc024c0f6c&type=mp4&sign=7fed8a9b7b446de4369936b6c1c40c3f&_aid=%@&cid=%@", aid, cid] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.urlStr = responseObject[@"durl"][0][@"url"];
        NSLog(@"%@", self.urlStr);
        [self startPlay];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma  - mark startPlay
- (void)startPlay {
    
    NSString *urlStr=self.urlStr;
    NSURL *url=[NSURL URLWithString:urlStr];
    AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:url];
    
    _player=[AVPlayer playerWithPlayerItem:playerItem];
    [self addProgressObserver];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    self.playerLayer=[AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = CGRectMake(0, 0, kScreenWidth, kHeight(186));
    [self.layer addSublayer:self.playerLayer];
    [self.player play];
    self.playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;
    
    [self.player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];

    [self configUnderView];
    [self configTopView];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
            float total = CMTimeGetSeconds(playerItem.duration);
            self.totleTime.text = [NSString stringWithFormat:@"%02i:%02i", (int)total/60, (int)total%60];
            self.progress.maximumValue = (CGFloat)CMTimeGetSeconds(self.player.currentItem.duration);
            self.progress.minimumValue =  0;
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);
        //
    }
    
    if ([keyPath isEqualToString:@"rate"]) {
        NSInteger rate = [[change objectForKey:@"new"] integerValue] ;
        
        //需要判断下是不是最开始的加载状态，我这里就直接给个全局变量判断算了
        if(rate == 0) {
            if (self.isFirstPlay) {
                self.isFirstPlay = NO;
            }else {
                
                self.underView.hidden = NO;
                self.topView.hidden = NO;
                UIButton *btn1 = [self viewWithTag:101];
                UIButton *btn2 = [self viewWithTag:102];
                btn1.selected = YES;
                btn2.selected = YES;

            }
            
        }
    }
}


#pragma -mark 全屏播放 
- (void)scale:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    if(btn.selected == NO) {
        
        UIView *fathView = (UIView *)self.nextResponder;
        fathView.frame = CGRectMake(0, 0, kScreenWidth, kHeight(214));
        self.frame = instanceFrame;
        self.underView.transform = CGAffineTransformIdentity;
        self.topView.transform = CGAffineTransformIdentity;
        self.playerLayer.transform = CATransform3DIdentity;
    }else if (btn.selected == YES) {
        
        UIView *fathView = (UIView *)self.nextResponder;
        fathView.frame = [UIScreen mainScreen].bounds;
        self.frame = [UIScreen mainScreen].bounds;
        self.topView.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        self.topView.transform = CGAffineTransformTranslate(self.topView.transform, kScreenHeight / 2 - kHeight(40) / 2, -(kScreenWidth / 2 - kHeight(40) / 2));
        self.topView.transform = CGAffineTransformScale(self.topView.transform, kScreenHeight / kScreenWidth, 1);
        
        self.underView.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        self.underView.transform = CGAffineTransformTranslate(self.underView.transform, -(kScreenHeight / 2 - kHeight(60) / 2), (kScreenWidth / 2 - kHeight(60) / 2));
        self.underView.transform = CGAffineTransformScale(self.underView.transform, kScreenHeight / kScreenWidth, 1);
        
        self.playerLayer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
        self.playerLayer.transform = CATransform3DTranslate(self.playerLayer.transform, kScreenHeight / 2 - kHeight(186) / 2, 0, 0);
        self.playerLayer.transform = CATransform3DScale(self.playerLayer.transform, kScreenHeight / kScreenWidth, kScreenWidth / kHeight(186), 1);
    }
}


-(void)addProgressObserver{
    //这里设置每秒执行一次
    WS(ws);
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current=CMTimeGetSeconds(time);
        int second = (int)current % 60;
        int minute = (int)current / 60;
        if (current) {
            [ws.progress setValue:current animated:YES];
            ws.startTime.text = [NSString stringWithFormat:@"%02i:%02i", minute, second];

        }
    }];
}


- (void)dealloc {
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.player removeObserver:self forKeyPath:@"rate"];

}
@end
