//
//  NoPictureNewsTableViewCell.h
//  TTNews
//
//  Created by 瑞文戴尔 on 16/4/14.
//  Copyright © 2016年 瑞文戴尔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoPictureNewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

-(void)updateToDaySkinMode;
-(void)updateToNightSkinMode;

@end
