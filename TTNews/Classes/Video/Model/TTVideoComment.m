//
//  TTVideoComment.m
//  TTNews
//
//  Created by 郑文青 on 16/6/9.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "TTVideoComment.h"
#import <MJExtension.h>

@implementation TTVideoComment

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}


-(void)encodeWithCoder:(NSCoder *)aCoder {
    [self mj_encode:aCoder];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self= [super init]) {
        [self mj_decode:aDecoder];
    }
    return self;
}


@end
