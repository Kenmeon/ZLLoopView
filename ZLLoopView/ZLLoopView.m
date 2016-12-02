//
//  ZLLoopView.m
//  1201Test
//
//  Created by zhanglongtao on 16/12/2.
//  Copyright © 2016年 hanju001. All rights reserved.
//

#import "ZLLoopView.h"
#import "ZLLoopLayout.h"
#import "ZLLoopCollectionViewCell.h"


NSString *const CellID = @"ZLLoopCell";
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface ZLLoopView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
//独立处理轮播器相关的所有代码
@implementation ZLLoopView
{
    NSArray <NSURL *> *_urls;
    NSInteger *_currentIndex;
    NSTimer *_scrollTimer;
    NSArray *imageArray;
    UIPageControl *_pageControl;
}

- (instancetype)initWithURLs:(NSArray<NSURL *> *)urls
{
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[ZLLoopLayout alloc]init]];
    if (self)
    {
        
        _urls = urls;
        
        [self loadInitView];
        
    }
    return self;
}
- (instancetype)initWithLoaclImage:(NSArray *)imageNameArray
{
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[ZLLoopLayout alloc]init]];
    if (self)
    {
        
        imageArray = imageNameArray;;
        
        [self loadInitView];
        
    }
    return self;
}
- (void)loadInitView
{
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:[ZLLoopCollectionViewCell class] forCellWithReuseIdentifier:CellID];
    
    //初始显示第二组
    //在开发中什么时候使用多线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSIndexPath *index;
        if (_urls.count == 0)
        {
            index = [NSIndexPath indexPathForItem:imageArray.count inSection:0];
        }
        else
        {
            index = [NSIndexPath indexPathForItem:_urls.count inSection:0];
        }
        [self scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        
        
    });
    
    
    
    
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timerRunning) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSDefaultRunLoopMode];
   
}
-(void)timerRunning{
    

    
    NSInteger offSet = self.contentOffset.x / self.bounds.size.width;
    if (_urls.count == 0)
    {
        if (offSet == 0) {
            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:imageArray.count inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }else if (offSet == [self numberOfItemsInSection:0]-1) {
            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:imageArray.count*100*0.5-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }else{
            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:offSet + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
        
    }
    else
    {
        if (offSet == 0) {
            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_urls.count inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }else if (offSet == [self numberOfItemsInSection:0]-1) {
            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_urls.count*100*0.5-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }else{
            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:offSet + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
    }
    if (_urls.count == 0)
    {
        self.pageControl.currentPage = (offSet+1)%imageArray.count;
    }
    else
    {
        self.pageControl.currentPage = (offSet+1)%_urls.count;
    }
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_urls.count == 0)
    {
        return imageArray.count*100;
    }
    else
    {
        return _urls.count*100;
    }
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZLLoopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
    if (_urls.count == 0)
    {
        UIImage *image = [UIImage imageNamed:imageArray[indexPath.item%imageArray.count]];
        
        cell.image = image;
    }
    else
    {
        cell.url = _urls[indexPath.item%_urls.count];
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegata respondsToSelector:@selector(clickImageNumber:)])
    {
        if (_urls.count == 0)
        {
            [self.delegata clickImageNumber:indexPath.item%imageArray.count];
        }
        else
        {
            [self.delegata clickImageNumber:indexPath.item%_urls.count];
        }
        
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前停止的页面
    NSInteger offset = scrollView.contentOffset.x/scrollView.bounds.size.width;
    //第0页跳转到第一组的的0页
    //最后一页跳转到第0组的最后一页
    if (offset == 0||offset ==([self numberOfItemsInSection:0]-1))
    {
        //第0页
        if (offset == 0)
        {
            offset = _urls.count;
        }
        else
        {
            offset = _urls.count-1;
        }
        
        
    }
    if (_urls.count == 0)
    {
        self.pageControl.currentPage = (offset+1)%imageArray.count;
    }
    else
    {
        self.pageControl.currentPage = (offset+1)%_urls.count;
    }
    //重新调整contentoffset
    scrollView.contentOffset = CGPointMake(offset*scrollView.bounds.size.width, 0);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
