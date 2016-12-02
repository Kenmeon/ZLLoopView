//
//  ZLLoopCollectionViewCell.m
//  1201Test
//
//  Created by zhanglongtao on 16/12/2.
//  Copyright © 2016年 hanju001. All rights reserved.
//

#import "ZLLoopCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ZLLoopCollectionViewCell
{
    UIImageView *_iamgeView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    //frame根据之前的layout已经确定好了
    if (self = [super initWithFrame:frame])
    {
        NSLog(@"%@",NSStringFromCGRect(frame));
        
        _iamgeView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        [self.contentView addSubview:_iamgeView];
        _iamgeView.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
- (void)setUrl:(NSURL *)url
{
    _url = url;
    
    
    [_iamgeView sd_setImageWithURL:_url placeholderImage:self.placeHolder];
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    _iamgeView.image = image;
}

@end
