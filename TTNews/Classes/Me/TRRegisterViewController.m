//
//  TRRegisterViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/8/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRRegisterViewController.h"

@interface TRRegisterViewController ()
@property (nonatomic,strong)UIView *bgView;
/** 手机号 */
@property (nonatomic,strong)UITextField *phoneTextField;
/** 验证码 */
//@property (nonatomic,strong)UITextField *codeTextField;
/** 昵称 */
@property (nonatomic,strong)UITextField *nicktextField;
/** 密码 */
@property (nonatomic,strong)UITextField *passwdtextField;

@end

@implementation TRRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBGColor;
 
    [Factory addBackItemToVC:self];

    self.title = @"手机注册";
    [self createTextFields];
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTextFields
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请输入您的手机号码";
    label.textColor=[UIColor grayColor];
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    
    [self.view addSubview:label];
    
    
    CGRect frame=[UIScreen mainScreen].bounds;
    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 110, frame.size.width-20, 150)];
    self.bgView.layer.cornerRadius=3.0;
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    self.phoneTextField = [Factory createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"11位手机号"];
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTextField .keyboardType=UIKeyboardTypeNumberPad;
    
    self.nicktextField =[Factory createTextFielfFrame:CGRectMake(100, 60, 200, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"请输入昵称" ];
    self.nicktextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.passwdtextField =[Factory createTextFielfFrame:CGRectMake(100, 110, 200, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"请输入密码" ];
    self.passwdtextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text=@"手机号";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=NSTextAlignmentLeft;
    phonelabel.font=[UIFont systemFontOfSize:14];
    
    UILabel *nicklabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
    nicklabel.text=@"昵称";
    nicklabel.textColor=[UIColor blackColor];
    nicklabel.textAlignment=NSTextAlignmentLeft;
    nicklabel.font=[UIFont systemFontOfSize:14];
    
    UILabel *passedLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 112, 50, 25)];
    passedLabel.text=@"密码";
    passedLabel.textColor=[UIColor blackColor];
    passedLabel.textAlignment=NSTextAlignmentLeft;
    passedLabel.font=[UIFont systemFontOfSize:14];
    
    
    UIImageView *line1=[Factory createImageViewFrame:CGRectMake(20, 50, self.bgView.frame.size.width-40, 1) imageName:nil color:kRGBA(180, 180, 180, 0.3)];
    UIImageView *line2=[Factory createImageViewFrame:CGRectMake(20, 100, self.bgView.frame.size.width-40, 1) imageName:nil color:kRGBA(180, 180, 180, 0.3)];
    
    UIButton *registerBtn=[Factory createButtonFrame:CGRectMake(10, self.bgView.frame.size.height+ self.bgView.frame.origin.y+30,self.view.frame.size.width-20, 37) backImageName:nil title:@"注册" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:15] target:self action:@selector(clickRegisterBtn)];
    registerBtn.backgroundColor = kRGBA(239, 73, 83, 0.8);
    registerBtn.layer.cornerRadius=5.0f;
    
    UIButton *agreeBtn = [Factory createButtonFrame:CGRectMake(kScreenW / 2 - 50 - 25, registerBtn.frame.origin.y + registerBtn.frame.size.height + 22, 20, 20) backImageName:@"同意按钮" title:nil titleColor:nil font:nil target:self action:nil];
    UILabel *agreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(agreeBtn.frame.origin.x + 25, registerBtn.frame.origin.y + registerBtn.frame.size.height + 20, 30, 25)];
    agreeLabel.textColor = [UIColor grayColor];
    agreeLabel.text = @"同意";
    agreeLabel.font = [UIFont systemFontOfSize:12];
    agreeLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *agreementLabel = [[UILabel alloc]initWithFrame:CGRectMake(agreeLabel.frame.origin.x + 30, registerBtn.frame.origin.y + registerBtn.frame.size.height + 20, 200, 25)];
    agreementLabel.textColor = kRGBA(239,73,83,0.8);
    agreementLabel.text = @"《注册协议及版权申明》";
    agreementLabel.font = [UIFont systemFontOfSize:12];
    agreementLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.bgView addSubview:self.phoneTextField];
    [self.bgView addSubview:self.nicktextField];
    [self.bgView addSubview:self.passwdtextField];
    [self.bgView addSubview:phonelabel];
    [self.bgView addSubview:nicklabel];
    [self.bgView addSubview:passedLabel];
    [self.bgView addSubview:line1];
    [self.bgView addSubview:line2];
    [self.view addSubview:registerBtn];
    [self.view addSubview:agreeBtn];
    [self.view addSubview:agreeLabel];
    [self.view addSubview:agreementLabel];
}
//判断账号和密码是否为空
- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = self.phoneTextField.text;
    NSString *passwd = self.passwdtextField.text;
    NSString *nickName = self.nicktextField.text;
    if (username.length == 0 || passwd.length == 0  || nickName == 0) {
        ret = YES;
    }
    
    return ret;
}


-(void)clickRegisterBtn
{
    
    if(![self isEmpty]){
        AVUser *user = [AVUser user];
        user.mobilePhoneNumber = self.phoneTextField.text;
        user.password = self.passwdtextField.text;
        user.username = self.nicktextField.text;
        
        [self.view showBusyHUD];
    WK(weakSelf);
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [weakSelf.view hiddenBusyHUD];
                [weakSelf.view showSuccess:@"注册成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
                
            }else{
                switch (error.code) {
                    case 127:
                        [self.view showError:@"请输入有效的手机号码"];
                        break;
                    case 214:
                        [self.view showError:@"手机号码已经注册"];
                        break;
                    default:
                        break;
                }
                NSLog(@"注册错误:%@",error);
            }
        }];
    }else{
        if (self.phoneTextField.text.length == 0) {
            [self.view showError:@"请输入手机号码"];
        }else if (self.nicktextField.text.length == 0){
            [self.view showError:@"请输入昵称"];
        }else{
            [self.view showError:@"请输入密码"];
        }
    }
    

}
@end
