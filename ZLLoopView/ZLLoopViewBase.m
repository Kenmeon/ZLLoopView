//
//  ZLLoopViewBase.m
//  ZLLoopView
//
//  Created by zhanglongtao on 17/2/21.
//  Copyright © 2017年 hanju001. All rights reserved.
//

#import "ZLLoopViewBase.h"
#import "ZLLoopView.h"

@interface ZLLoopViewBase ()<ZLLoopViewDelegate>
{
    NSInteger _numPage;
    UIPageControl *_pageControl;
    NSArray <NSURL *> *_urls;
}

@property(nonatomic,strong) ZLLoopView *loopView;

@end

@implementation ZLLoopViewBase

- (instancetype)initWithFrame:(CGRect)frame WithURLs:(NSArray<NSURL *> *)urls{
    if (self = [super initWithFrame:frame]){
        
        //网络
        self.loopView = [[ZLLoopView alloc]initWithURLs:urls];
        self.loopView.delegata = self;
        self.loopView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.loopView];
        _urls = urls;
        _numPage = urls.count;
        //创建pageControl
        [self createPage];
    }
    
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame WithLoaclImage:(NSArray *)imageNameArrays{
    if (self = [super initWithFrame:frame]){
        //本地图片的名字数组
        
        self.loopView = [[ZLLoopView alloc]initWithLoaclImage:imageNameArrays];
        self.loopView.delegata = self;
        self.loopView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.loopView];
        
        _numPage = imageNameArrays.count;
        //创建pageControl
        [self createPage];
        
    }
    
    return self;
    
}
- (void)createPage
{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-40, 40)];
    _pageControl.center = CGPointMake((self.frame.size.width)/2.0, 200);
    _pageControl.currentPage = 0;
    
    _pageControl.numberOfPages = _numPage;
    
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self addSubview:_pageControl];
    
    self.loopView.pageControl = _pageControl;
}
- (void)clickImageNumber:(NSInteger)num
{
    if ([self.delegata respondsToSelector:@selector(clickImageNumberBase:)])
    {
        if (_urls.count == 0)
        {
            [self.delegata clickImageNumberBase:num];
        }
        else
        {
            [self.delegata clickImageNumberBase:num];
        }
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
