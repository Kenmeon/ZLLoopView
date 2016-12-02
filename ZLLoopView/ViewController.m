//
//  ViewController.m
//  1201Test
//
//  Created by zhanglongtao on 16/12/1.
//  Copyright © 2016年 hanju001. All rights reserved.
//

#import "ViewController.h"
#import "ZLLoopView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
//类扩展/匿名分类  定义私有属性和方法
@interface ViewController ()<ZLLoopViewDelegate>
{
    
}

@end

@implementation ViewController
{
    NSArray <NSURL *> *_urls;
    UIPageControl *_pageControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSString *str = nil;
//    
//    NSArray *array = @[@"hello",str];
//    
//    NSLog(@"%@",array);
    
    NSLog(@"Hello world");
    
    [self loadData];
    
    //pageControl
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 40)];
    _pageControl.center = CGPointMake((kScreenWidth)/2.0, 200);
    _pageControl.currentPage = 0;
    
    _pageControl.numberOfPages = _urls.count;
    
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.view addSubview:_pageControl];
    
    
    //网络
//    ZLLoopView *loopView = [[ZLLoopView alloc]initWithURLs:_urls];
//    loopView.delegata = self;
//    loopView.frame = CGRectMake(20, 20, self.view.bounds.size.width-40, 200);
//    [self.view addSubview:loopView];
    
    
    //本地图片的名字数组
    ZLLoopView *loopView = [[ZLLoopView alloc]initWithLoaclImage:_urls];
    loopView.delegata = self;
    loopView.frame = CGRectMake(20, 20, self.view.bounds.size.width-40, 200);
    [self.view addSubview:loopView];
    loopView.pageControl = _pageControl;
    
    [self.view insertSubview:_pageControl aboveSubview:loopView];

}
- (void)clickImageNumber:(NSInteger)num
{
    NSLog(@"click:%ld",num+1);
}
- (void)loadData
{
    NSMutableArray *urlArray = [NSMutableArray array];
    for (int i = 0;i < 4;i++)
    {
        NSString *flleName = [NSString stringWithFormat:@"%d.jpeg",(i+1)];
        
        //如果dileNmae不存在 url返回nil
//        NSURL *url = [[NSBundle mainBundle]URLForResource:flleName withExtension:nil];
        
        [urlArray addObject:flleName];
    }
    
    _urls = urlArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
