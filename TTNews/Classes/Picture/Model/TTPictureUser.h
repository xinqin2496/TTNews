//
//  TTPictureUser.h
//  TTNews
//
//  Created by 郑文青 on 16/6/5.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTPictureUser : NSObject<NSCoding>
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *sex;
@end
