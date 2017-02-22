//
//  ZLLoopViewBase.h
//  ZLLoopView
//
//  Created by zhanglongtao on 17/2/21.
//  Copyright © 2017年 hanju001. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLLoopViewBase;

/**点击了图片的代理传递*/
@protocol ZLLoopViewDelegateBase <NSObject>

- (void)clickImageNumberBase:(NSInteger)num;

@end

@interface ZLLoopViewBase : UIView

//初始化网络图片
- (instancetype)initWithFrame:(CGRect)frame WithURLs:(NSArray<NSURL *> *)urls;
//初始化本地图片
- (instancetype)initWithFrame:(CGRect)frame WithLoaclImage:(NSArray*)imageNameArray;

@property(nonatomic,weak) id <ZLLoopViewDelegateBase>delegata;

@end
