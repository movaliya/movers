//
//  ForgotPassVW.m
//  digitalmarketing
//
//  Created by Mango SW on 14/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "ForgotPassVW.h"
#import <QuartzCore/QuartzCore.h>
#import "misterMover.pch"


@interface ForgotPassVW ()

@end

@implementation ForgotPassVW
@synthesize FindAccountBtn,BackView,Email_TXT,passwordtxt_View;


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    [self.rootNav.pan_gr setEnabled:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [BackView.layer setShadowColor:[UIColor blackColor].CGColor];
    [BackView.layer setShadowOpacity:0.8];
    [BackView.layer setShadowRadius:3.0];
    [BackView.layer setShadowOffset:CGSizeMake(1.0,1.0)];
    
    
    [FindAccountBtn.layer setCornerRadius:3.0f];
    FindAccountBtn.layer.borderWidth = 1.0f;
    [FindAccountBtn.layer setMasksToBounds:YES];
    FindAccountBtn.layer.borderColor = [UIColor colorWithRed:(193/255.0) green:(193/255.0) blue:(193/255.0) alpha:1.0].CGColor;
    
    [passwordtxt_View.layer setCornerRadius:3.0f];
    passwordtxt_View.layer.borderWidth = 1.0f;
    [passwordtxt_View.layer setMasksToBounds:YES];
    passwordtxt_View.layer.borderColor = [UIColor colorWithRed:(62/255.0) green:(64/255.0) blue:(149/255.0) alpha:1.0].CGColor;

}
- (IBAction)Find_Account_Action:(id)sender
{
    if ([Email_TXT.text isEqualToString:@""])
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Email" delegate:nil];
    }
    else if (![AppDelegate IsValidEmail:Email_TXT.text])
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter valid email" delegate:nil];
    }
    else
    {
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
            [self CallForgotPass];
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    }
}
-(void)CallForgotPass
{
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:user_forget_password  forKey:@"s"];
    [dictParams setObject:Email_TXT.text  forKey:@"email"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleResponse:response];
     }];
}
- (void)handleResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        Email_TXT.text=@"";
       
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

- (IBAction)Back_Btn_action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
