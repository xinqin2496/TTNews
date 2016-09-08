//
//  VideoPlayView.h
//  TTNews
//
//  Created by 郑文青 on 16/6/10.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol VideoPlayViewDelegate <NSObject>

@optional
- (void)videoplayViewSwitchOrientation:(BOOL)isFull;

@end

@interface VideoPlayView : UIView

+ (instancetype)videoPlayView;

@property (weak, nonatomic) id<VideoPlayViewDelegate> delegate;

@property (nonatomic, strong) AVPlayerItem *playerItem;

-(void)suspendPlayVideo;

-(void)resetPlayView;
@end
