//
//  PictureTableViewCell.h
//  TTNews
//
//  Created by 郑文青 on 16/6/7.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTPicture;

@protocol  PictureTableViewCellDelegate<NSObject>
@optional

-(void)clickMoreButton:(TTPicture *)picture;
-(void)clickCommentButton:(NSIndexPath *)indexPath;
-(void)clickRepostButton:(TTPicture *)picture;;
@end

@interface PictureTableViewCell : UITableViewCell

+(instancetype)cell;
-(void)updateToDaySkinMode;
-(void)updateToNightSkinMode;

@property (nonatomic, strong) TTPicture *picture;
@property (nonatomic, weak) id<PictureTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
