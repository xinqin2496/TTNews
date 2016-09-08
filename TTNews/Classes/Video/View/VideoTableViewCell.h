//
//  VideoTableViewCell.h
//  TTNews
//
//  Created by 郑文青 on 16/6/11.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPlayView.h"
@class VideoPlayView;
@class TTVideo;

@protocol  VideoTableViewCellDelegate<NSObject>

@optional

-(void)clickMoreButton:(TTVideo *)video;
-(void)clickVideoButton:(NSIndexPath *)indexPath;
-(void)clickCommentButton:(NSIndexPath *)indexPath;
-(void)clickRepostButton:(TTVideo *)video;

@end

@interface VideoTableViewCell : UITableViewCell

+(instancetype)cell;
-(void)updateToDaySkinMode;
-(void)updateToNightSkinMode;
@property (nonatomic, strong) TTVideo *video;
@property (nonatomic, weak) id<VideoTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) VideoPlayView *playView;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@end
