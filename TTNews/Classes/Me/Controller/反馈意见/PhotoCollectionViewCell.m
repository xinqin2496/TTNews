//
//  PhotoCollectionViewCell.m
//  wyh
//
//  Created by 郑文青 on 16/5/31.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

//懒加载创建数据
-(UIImageView *)photoV{
    if (_photoV == nil) {
        self.photoV = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _photoV;
}

//创建自定义cell时调用该方法
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoV];
    }
    return self;
}

@end
