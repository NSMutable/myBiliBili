//
//  CartoonCollectionHeadView.m
//  MyBiliBili
//
//  Created by 陈淼 on 16/4/2.
//  Copyright © 2016年 陈淼. All rights reserved.
//

#import "CartoonCollectionHeadView.h"
#import "AFNetworking.h"
#import "PublicButton.h"
#import "headImgPlayerModel.h"
#import "HeadHitCartoonModel.h"

@interface CartoonCollectionHeadView ()<ImagePlayerViewDelegate>
{
    NSMutableArray *_imgPlayerModels;
    NSMutableArray *_hitCartoonModels;
    UIView *_view;
    NSMutableArray *_rects;
}

@property (nonatomic, strong) PublicButton *cartoonLoveBtn;
@property (nonatomic, strong) PublicButton *cartoonRecommendBtn;

@end

@implementation CartoonCollectionHeadView

- (void)awakeFromNib {
    
    [self sendRequestForImgPlayerData];
    [self sendRequestForShowViewData];
    //基础配置
    [self configUI];
    
}

- (void)configUI {
    
    self.imagePlayView.imagePlayerViewDelegate = self;
    self.imagePlayView.scrollInterval = 4.0f;
    self.imagePlayView.pageControlPosition = ICPageControlPosition_BottomRight;
    self.imagePlayView.hidePageControl = NO;
    
    self.cartoonLoveBtn = [[PublicButton alloc] initWithFrame:CGRectMake(0, self.leftBtn.origin.y + 60, kScreenWidth, 30)];
    [self addSubview:self.cartoonLoveBtn];
    
    [self.cartoonLoveBtn setimgView:@"home_region_icon_4" label:@"大家都在看" buttonBackgroundColor:UIColorFromRGB(0xbbbbbb) content:@"进去看看" btnImg:nil leftLabel:nil];
    //初始化中间四个view，先随便给个frame
    for (int i = 0; i < 4; i++) {
        _view = [[UIView alloc] initWithFrame:CGRectMake(10 + i % 2 * ((kScreenWidth - 30) / 2 + 10), self.cartoonLoveBtn.frame.origin.y + 40 + i / 2 * 100, (kScreenWidth - 30) / 2, 90)];
        _view.backgroundColor = [UIColor whiteColor];
        _view.tag = 100 + i;
        [self addSubview:_view];
    }
    
    
    self.cartoonRecommendBtn = [[PublicButton alloc] initWithFrame:CGRectMake(0, _view.origin.y + 110, kScreenWidth, 30)];
    
    [self.cartoonRecommendBtn setimgView:@"home_region_icon_5" label:@"推荐番剧" buttonBackgroundColor:UIColorFromRGB(0xbbbbbb) content:@"更多" btnImg:nil leftLabel:nil];
    [self addSubview:self.cartoonRecommendBtn];
   

    
}
//配置中间四个view，明确frame
- (void)configShowView {
    
    _rects = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        
        
        UIView *view = [self viewWithTag:100 + i];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 30) / 2, 90)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:[_hitCartoonModels[i] pic]]];
        [view addSubview:imgView];
        
        //动态改变在线人数这个视图的大小
        UILabel *onlinePeople = [[UILabel alloc] init];
        onlinePeople.text = [NSString stringWithFormat:@"%li", [_hitCartoonModels[i] online]];
        onlinePeople.font = [UIFont systemFontOfSize:9];
        CGSize size = [onlinePeople.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:9]}];
        onlinePeople.textColor = [UIColor whiteColor];
        
        
        UIView *onlinePeopleView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 30) / 2 - size.width  - 11, 90 - size.height - 2 - 1 , size.width + 10, size.height + 1)];
        onlinePeopleView.backgroundColor = UIColorFromRGB(0xf48fa5);
        onlinePeopleView.layer.cornerRadius = 2.0;
        onlinePeople.frame = CGRectMake(5, 0.5, size.width, size.height);
        [onlinePeopleView addSubview:onlinePeople];
        [view addSubview:onlinePeopleView];
        
        //动态改变标题lable的大小，可变行
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.text = [_hitCartoonModels[i] title];
        titleLable.font = [UIFont systemFontOfSize:11];
        titleLable.numberOfLines = 0;
        CGRect rect = [titleLable.text boundingRectWithSize:CGSizeMake((kScreenWidth - 30) / 2, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil];
        
        titleLable.textColor = [UIColor blackColor];
        titleLable.textAlignment = NSTextAlignmentLeft;
        titleLable.frame = CGRectMake(0, 90, (kScreenWidth - 30) / 2, rect.size.height);
        [view addSubview:titleLable];
        
        //存下改变的高度
        NSValue *value = [NSValue valueWithCGRect:rect];
        [_rects addObject:value];
    }
    //配置view的frame
    for (int i = 0; i < 4; i++) {
        UIView *view = [self viewWithTag:100 + i];
        CGRect rect = [_rects[i] CGRectValue];
        view.frame = CGRectMake(10 + i % 2 * ((kScreenWidth - 30) / 2 + 10), self.cartoonLoveBtn.frame.origin.y + 40 + (i >= 2 ? (100 + [_rects[i - 2] CGRectValue].size.height) : 0), (kScreenWidth - 30) / 2, 90 + rect.size.height);
    }
    
    //改下btn的frame
    CGFloat maxheight;
    if (([_rects[0] CGRectValue].size.height + [_rects[2] CGRectValue].size.height) > ([_rects[1] CGRectValue].size.height + [_rects[3] CGRectValue].size.height)) {
        maxheight = [_rects[0] CGRectValue].size.height + [_rects[2] CGRectValue].size.height;
    }else {
        maxheight = [_rects[1] CGRectValue].size.height + [_rects[3] CGRectValue].size.height;
    }
    
    self.cartoonRecommendBtn.frame = CGRectMake(0, self.cartoonLoveBtn.origin.y + 40 + 100 * 2 + maxheight + 10, kScreenWidth, 30);

}

- (void)sendRequestForImgPlayerData {
    
    AFHTTPSessionManager* managerAD = [AFHTTPSessionManager manager];
    [managerAD GET:@"http://app.bilibili.com/api/region2/13.json?_device=android&_hwid=130a7709aeac1793&appkey=c1b107428d337928&build=402003&platform=android&ts=1449758668000&sign=9f36da5e90b8345e376a71466a078696" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //接收滚动视图的model
        _imgPlayerModels = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"result"][@"banners"]) {
            headImgPlayerModel *model = [[headImgPlayerModel alloc] init];
            model.aid = [dic[@"aid"] integerValue];
            model.img = dic[@"img"];
            model.link = dic[@"link"];
            model.pid = [dic[@"pid"] integerValue];
            model.platform = [dic[@"platform"] integerValue];
            model.simg = dic[@"simg"];
            model.title = dic[@"title"];
            model.type = [dic[@"type"] integerValue];
            [_imgPlayerModels addObject:model];
        }
        
        [self.imagePlayView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)sendRequestForShowViewData {

        AFHTTPSessionManager* managerAD = [AFHTTPSessionManager manager];
        [managerAD GET:@"http://api.bilibili.com/online_list?_device=android&_hwid=646dc75290b23698&appkey=c1b107428d337928&build=404000&platform=android&typeid=13&sign=b41110330fea0388ca3edf9d18e8d96d" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
            _hitCartoonModels = [NSMutableArray array];
            for (int i = 0; i < [responseObject[@"list"] count]; i++) {
                NSString *num = [NSString stringWithFormat:@"%i", i];
                NSDictionary *dic = responseObject[@"list"][num];
                HeadHitCartoonModel *model = [[HeadHitCartoonModel alloc] init];
                model.aid = [dic[@"aid"] integerValue];
                model.author = dic[@"author"];
                model.coins = [dic[@"coins"] integerValue];
                model.create = dic[@"create"];
                model.credit = [dic[@"credit"] integerValue];
                model.Description = dic[@"description"];
                model.duration = dic[@"duration"];
                model.favorites = [dic[@"favorites"] integerValue];
                model.mid = [dic[@"mid"] integerValue];
                model.online = [dic[@"online"] integerValue];
                model.pic = dic[@"pic"];
                model.play = [dic[@"play"] integerValue];
                model.review = [dic[@"review"] integerValue];
                model.title = dic[@"title"];
                model.Typeid = [dic[@"typeid"] integerValue];
                model.Typename = dic[@"typename"];
                [_hitCartoonModels addObject:model];
            }
            [self configShowView];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    
}




#pragma mark - ImagePlayerViewDelegate
- (NSInteger)numberOfItems
{
    return _imgPlayerModels.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_imgPlayerModels[index] img]]]];
}

@end
