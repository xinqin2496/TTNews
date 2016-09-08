//
//  TTPictureUser.m
//  TTNews
//
//  Created by 郑文青 on 16/6/5.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "TTPictureUser.h"
#import <MJExtension.h>

@implementation TTPictureUser

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super init]) {
        [self mj_decode:aDecoder];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [self mj_encode:aCoder];
}

@end
