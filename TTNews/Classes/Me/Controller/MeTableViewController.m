//
//  MeTableViewController.m
//  TTNews
//
//  Created by 郑文青 on 16/6/12.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "MeTableViewController.h"
#import <SDImageCache.h>
#import "TTDataTool.h"
#import "UIImage+Extension.h"
#import "TTConst.h"
#import "AppInfoViewController.h"
#import "EditUserInfoViewController.h"
#import "UIImage+Extension.h"
#import "TRLoginViewController.h"
#import "UserFeedBackViewController.h"
@interface MeTableViewController ()

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, weak) UISwitch *changeSkinSwitch;
@property (nonatomic, weak) UISwitch *shakeCanChangeSkinSwitch;
@property (nonatomic, weak) UISwitch *imageDownLoadModeSwitch;
@property (nonatomic, assign) CGFloat cacheSize;
@property (nonatomic, copy) NSString *currentSkinModel;


@end

CGFloat const footViewHeight = 30;

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self caculateCacheSize];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(-130, 0, 0, 0);
    [self createHeaderView];
    [self preferredStatusBarStyle];
    
   
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSkinModel) name:SkinModelDidChangedNotification object:nil];
    [self updateSkinModel];
     self.navigationController.navigationBarHidden = YES;
    AVUser *user = [AVUser currentUser];
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:1220];
    UIImageView *bgimageView = (UIImageView *)[self.view viewWithTag:1219];
    NSString *iconImageStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"headerImageStr"];
    if (iconImageStr != nil) {
        UIImage *image = [Factory Base64StrToUIImage:iconImageStr];
        imageView.image = image;
        bgimageView.image = image;
    }else{
        imageView.image = [UIImage imageNamed:@"IMG_3183"];
        bgimageView.image = imageView.image;
    }
    UILabel *nameLabel = (UILabel *)[self.view viewWithTag:1221];
    if (user != nil) {
        nameLabel.text = user.username;
    }else{
        nameLabel.text = @"点击登录";
    }
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view hiddenBusyHUD];
    self.navigationController.navigationBarHidden = NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    //返回白色
    return UIStatusBarStyleLightContent;
   
}
-(void)createHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 340)];
    UIImageView *bgimageView = [[UIImageView alloc]initWithFrame:headerView.bounds];
    bgimageView.tag = 1219;
    bgimageView.alpha = 0.7;
    [headerView addSubview:bgimageView];
    
    UIImageView *avatarImageView = [[UIImageView alloc] init];
    [headerView insertSubview:avatarImageView aboveSubview:bgimageView];
    avatarImageView.image = [UIImage imageNamed:@"IMG_3183"];
    avatarImageView.tag = 1220;
    avatarImageView.layer.cornerRadius = 30;
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    avatarImageView.layer.borderWidth = 2;
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(200);
        make.centerX.equalTo(0);
        make.width.equalTo(60);
        make.height.equalTo(60);
    }];
    UILabel *nameLabel = [[UILabel alloc] init];
    [headerView insertSubview:nameLabel aboveSubview:bgimageView];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.tag = 1221;

    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.textColor = [UIColor whiteColor];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatarImageView.mas_bottom).equalTo(5);
        make.centerX.equalTo(0);
        make.height.equalTo(20);
        make.width.equalTo(200);
    }];
   self.tableView.tableHeaderView = headerView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeaderView:)];
    tap.numberOfTapsRequired = 1;
    [headerView addGestureRecognizer:tap];
}
-(void)clickHeaderView:(UIGestureRecognizer *)sender
{
    AVUser *user = [AVUser currentUser];
    
    if (user != nil) {
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:1220];
 
        EditUserInfoViewController *userInfoVC = [[EditUserInfoViewController alloc]initWithBlock:^(UIImage *photoImage) {
            imageView.image = photoImage;
        } saveImage:imageView.image];
        
        userInfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userInfoVC animated:YES];
       
    }else{
        TRLoginViewController *loginVC = [TRLoginViewController new];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];

    }


}
#pragma mark 更新皮肤模式 接到模式切换的通知后会调用此方法
-(void)updateSkinModel {
    self.currentSkinModel = [[NSUserDefaults standardUserDefaults] stringForKey:CurrentSkinModelKey];
    if ([self.currentSkinModel isEqualToString:NightSkinModelValue]) {
        self.tableView.backgroundColor = [UIColor blackColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableHeaderView.backgroundColor = [UIColor darkGrayColor];
        UIImageView *bgimageView = (UIImageView *)[self.view viewWithTag:1219];
        bgimageView.alpha = 0.3;
    } else {//日间模式
        self.tableView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.tableHeaderView.backgroundColor = [UIColor lightGrayColor];
        UIImageView *bgimageView = (UIImageView *)[self.view viewWithTag:1219];
        bgimageView.alpha = 0.7;
    }
    [self.tableView reloadData];
}

-(void)caculateCacheSize {
    float imageCache = [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"data.sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float sqliteCache = [fileManager attributesOfItemAtPath:path error:nil].fileSize/1024.0/1024.0;
    self.cacheSize = imageCache + sqliteCache;
}

#pragma mark - Table view data source

#pragma mark -UITableViewDataSource 返回tableView有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

#pragma mark -UITableViewDataSource 返回tableView每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //if (section == 0) return 1;
    if(section == 0) return 4;
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return footViewHeight;
}

#pragma mark -UITableViewDataSource 返回indexPath对应的cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //if (indexPath.section == 0) return 100;
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, footViewHeight);
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size. width, 1);
    [footView addSubview:lineView1];
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.frame = CGRectMake(0, footViewHeight - 1, [UIScreen mainScreen].bounds.size.width, 1);
    [footView addSubview:lineView2];
    if ([self.currentSkinModel isEqualToString:DaySkinModelValue]) {//日间模式
        footView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        lineView1.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        lineView2.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    } else {
        footView.backgroundColor = [UIColor blackColor];
        lineView1.backgroundColor = [UIColor blackColor];
        lineView2.backgroundColor = [UIColor blackColor];
    }
    if (section==1) {
        [lineView2 removeFromSuperview];
    }
    return footView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"摇一摇夜间模式";
            if (cell.accessoryView == nil) {
                UISwitch *shakeCanChangeSkinSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
                self.shakeCanChangeSkinSwitch = shakeCanChangeSkinSwitch;
                [shakeCanChangeSkinSwitch addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
                shakeCanChangeSkinSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:IsShakeCanChangeSkinKey];
                cell.accessoryView = shakeCanChangeSkinSwitch;
            }
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"夜间模式";
            if (cell.accessoryView == nil) {
                UISwitch *changeSkinSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
                self.changeSkinSwitch = changeSkinSwitch;
                [changeSkinSwitch addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
                
                cell.accessoryView = changeSkinSwitch;
            }
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"智能无图";
            if (cell.accessoryView == nil) {
                UISwitch *theSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 51, 31)];
                self.imageDownLoadModeSwitch = theSwitch;
                [theSwitch addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
                theSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:IsDownLoadNoImageIn3GKey];
                
                cell.accessoryView = theSwitch;
            }
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"清除缓存";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f MB",self.cacheSize];
        }
        
    } else  {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"反馈";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if(indexPath.row == 1) {
            cell.textLabel.text = @"关于";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    
    if ([self.currentSkinModel isEqualToString:NightSkinModelValue]) {//夜间模式
        cell.backgroundColor = [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
        cell.textLabel.textColor = [UIColor colorWithRed:111/255.0 green:109/255.0 blue:112/255.0 alpha:1.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.changeSkinSwitch.on = YES;
    } else {//日间模式
        cell.backgroundColor =[UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        self.changeSkinSwitch.on = NO;
    }
    
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row ==3) {
        [self.view showBusyHUD];
        [TTDataTool deletePartOfCacheInSqlite];
        [[SDImageCache sharedImageCache] clearDisk];
        [self.view showSuccess:@"缓存清除完毕!"];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"0.0MB"];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        UserFeedBackViewController *feedBackVC = [UserFeedBackViewController new];
        feedBackVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedBackVC animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        [self.navigationController pushViewController:[[AppInfoViewController alloc] init] animated:YES];
    }
    

}

-(void)switchDidChange:(UISwitch *)theSwitch {
    if (theSwitch == self.changeSkinSwitch) {
        if (theSwitch.on == YES) {//切换至夜间模式
            [[NSUserDefaults standardUserDefaults] setObject:NightSkinModelValue forKey:CurrentSkinModelKey];
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:DaySkinModelValue forKey:CurrentSkinModelKey];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:SkinModelDidChangedNotification object:self];
    } else if (theSwitch == self.shakeCanChangeSkinSwitch) {//摇一摇夜间模式
        BOOL status = self.shakeCanChangeSkinSwitch.on;
        [[NSUserDefaults standardUserDefaults] setObject:@(status) forKey:IsShakeCanChangeSkinKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if([self.delegate respondsToSelector:@selector(shakeCanChangeSkin:)]) {
            [self.delegate shakeCanChangeSkin:status];
        }
    } else if (theSwitch == self.imageDownLoadModeSwitch) {//智能无图
        BOOL status = self.imageDownLoadModeSwitch.on;
        [[NSUserDefaults standardUserDefaults] setObject:@(status) forKey:IsDownLoadNoImageIn3GKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}



@end
