//
//  AvPlayerView.h
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/26.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AvPlayerView : UIView

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) NSString *aid;


//播放视频的网址
@property (nonatomic, strong) NSString *urlStr;



@end
