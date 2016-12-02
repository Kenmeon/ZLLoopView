//
//  ZLLoopView.h
//  1201Test
//
//  Created by zhanglongtao on 16/12/2.
//  Copyright © 2016年 hanju001. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZLLoopView;

@protocol ZLLoopViewDelegate <NSObject>

- (void)clickImageNumber:(NSInteger)num;

@end

@interface ZLLoopView : UICollectionView

//初始化网络图片
- (instancetype)initWithURLs:(NSArray<NSURL *> *)urls;
//初始化本地图片
- (instancetype)initWithLoaclImage:(NSArray*)imageNameArray;

@property(nonatomic,weak) id <ZLLoopViewDelegate>delegata;

//已经存在的pageControl传递进来
@property(nonatomic,strong) UIPageControl *pageControl;

@end
