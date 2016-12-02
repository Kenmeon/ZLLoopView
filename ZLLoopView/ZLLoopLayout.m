//
//  ZLLoopLayout.m
//  1201Test
//
//  Created by zhanglongtao on 16/12/2.
//  Copyright © 2016年 hanju001. All rights reserved.
//

#import "ZLLoopLayout.h"

@implementation ZLLoopLayout

- (void)prepareLayout
{
    //一定super
    [super prepareLayout];
    
    NSLog(@"%@",self.collectionView);
    //在collectionView第一次布局的时候被调用
    
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
}

@end
