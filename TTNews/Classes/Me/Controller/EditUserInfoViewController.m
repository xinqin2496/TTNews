//
//  EditUserInfoViewController.m
//  TTNews
//
//  Created by 郑文青 on 16/6/12.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "EditUserInfoViewController.h"
#import "UIImage+Extension.h"
#import "TTConst.h"

@interface EditUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *titleArray;
/** 接收的头像 */
@property (nonatomic,strong)UIImage *iconImage;
/** 头像 */
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,copy)NSString *backSignature;
@property(nonatomic,copy)PHOTO_BLOCK myBlock;
@property (nonatomic, copy) NSString *currentSkinModel;
@end

@implementation EditUserInfoViewController
-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"头像",@"昵称",@"个性签名",@"手机号"];
    }
    return _titleArray;
}
-(instancetype)initWithBlock:(PHOTO_BLOCK)block saveImage:(UIImage *)saveImage
{
    if (self = [super initWithNibName:@"EditUserInfoViewController" bundle:[NSBundle mainBundle]]) {
        self.myBlock = block;
        self.iconImage = saveImage;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSkinModel) name:SkinModelDidChangedNotification object:nil];
    [self updateSkinModel];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    return self.titleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    if ([self.currentSkinModel isEqualToString:NightSkinModelValue]) {//夜间模式
        cell.backgroundColor = [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
        cell.textLabel.textColor = [UIColor colorWithRed:111/255.0 green:109/255.0 blue:112/255.0 alpha:1.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else {//夜间模式
        cell.backgroundColor =[UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
     AVUser *user = [AVUser currentUser];
    if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellSelectionStyleNone;
        UILabel *exitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
        exitLabel.text = @"退出登录";
        exitLabel.textColor = kRGBA(248, 148, 34, 1.0);
        exitLabel.textAlignment = NSTextAlignmentCenter;
        exitLabel.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:exitLabel];
        return cell;
    }else{
        cell.textLabel.text = self.titleArray[indexPath.row];
        if (indexPath.row == 0) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW - 80 , 0, 40, 40)];
            self.iconImageView = imageView;
            imageView.image = self.iconImage;
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 20;
            imageView.layer.borderColor = [UIColor whiteColor].CGColor;
            imageView.layer.borderWidth = 1;
            [cell.contentView addSubview:imageView];
            
        }else if (indexPath.row == 1){
            cell.detailTextLabel.text = user.username;
        }else if (indexPath.row == 2){
            cell.detailTextLabel.text = self.backSignature ? self.backSignature : @"这个家伙很懒,什么也没有留下";
        }else{
            cell.detailTextLabel.text = user.mobilePhoneNumber;
        }
        return cell;
    }
   

   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cameraBtn = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self snapImage];
            }];
            UIAlertAction *photoBtn = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self localPhoto];
            }];
            UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cameraBtn];
            [alert addAction:photoBtn];
            [alert addAction:cancelBtn];
           [self presentViewController:alert animated:YES completion:nil];
        }else if (indexPath.row == 1){
            [self editUserInfoTitle:@"修改昵称" message:@"" okAction:^(NSString *text) {
                AVUser *user = [AVUser currentUser];
                user.username = text;
                [user save];
                [self.tableView reloadData];
            }];
        }else if (indexPath.row == 2){
            [self editUserInfoTitle:@"修改个性签名" message:@"" okAction:^(NSString *text) {
                self.backSignature = text;
                [self.tableView reloadData];
            }];
        }else{
            [self.view showError:@"手机号已经绑定"];
        }
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"是否确定退出当前账号" preferredStyle:UIAlertControllerStyleAlert];
       
        UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [AVUser logOut];
            [AVUser changeCurrentUser:nil save:YES];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"headerImageStr"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okBtn];
        [alert addAction:cancelBtn];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
-(void)editUserInfoTitle:(NSString *)title message:(NSString *)message okAction:(void(^)(NSString *text))okAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okAction(alert.textFields[0].text);
    }];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        //配置文本框的占位符
        textField.placeholder = title;
    }];
    [alert addAction:okBtn];
    [alert addAction:cancelBtn];
    [self presentViewController:alert animated:YES completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
//拍照
- (void) snapImage
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        __block UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        
        [self presentViewController:ipc animated:YES completion:^{
            ipc = nil;
        }];
    } else {
        NSLog(@"模拟器无法打开照相机");
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //完成选择
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"]) {
        //转换成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //通过 block 把image 传值
        self.myBlock(image);
        
        NSString *imageStr =  [Factory UIImageToBase64Str:image];
        [[NSUserDefaults standardUserDefaults]setObject:imageStr forKey:@"headerImageStr"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            //设置头像
            self.iconImageView.image = image;
        }];
        
    }
}
//相册
-(void)localPhoto
{
    __block UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        picker = nil;
    }];
}

#pragma mark 更新皮肤模式 接到模式切换的通知后会调用此方法
-(void)updateSkinModel {
    self.currentSkinModel = [[NSUserDefaults standardUserDefaults] stringForKey:CurrentSkinModelKey];
    if ([self.currentSkinModel isEqualToString:NightSkinModelValue]) {
        self.view.backgroundColor = [UIColor blackColor];
        self.tableView.backgroundColor = [UIColor blackColor];
        
    } else {//日间模式
        self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
