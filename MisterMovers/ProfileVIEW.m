//
//  ProfileVIEW.m
//  digitalmarketing
//
//  Created by Mango SW on 15/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "ProfileVIEW.h"
#import "misterMover.pch"

@interface ProfileVIEW ()

@end

@implementation ProfileVIEW

@synthesize InfoView,Fname_TXT,FNameView,Mname_TXT,MNameView,LName_TXT,LNameView,Phone_TXT,PhoneView,Email_TXT,EmailView,Residential_TXT,ResidentialView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [InfoView.layer setShadowColor:[UIColor blackColor].CGColor];
    [InfoView.layer setShadowOpacity:0.8];
    [InfoView.layer setShadowRadius:2.0];
    [InfoView.layer setShadowOffset:CGSizeMake(1.0,1.0)];
    
    [KmyappDelegate SettextfieldViewBorder:FNameView];
    [KmyappDelegate SettextfieldViewBorder:MNameView];
    [KmyappDelegate SettextfieldViewBorder:LNameView];
    [KmyappDelegate SettextfieldViewBorder:PhoneView];
    [KmyappDelegate SettextfieldViewBorder:EmailView];
    [KmyappDelegate SettextfieldViewBorder:ResidentialView];
    
    Fname_TXT.enabled=NO;
    Email_TXT.enabled=NO;
    Fname_TXT.textColor=[UIColor grayColor];
    Email_TXT.textColor=[UIColor grayColor];
    
    
    if ([KmyappDelegate isUserLoggedIn] == YES)
    {
        NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
        if ([UserSaveData valueForKey:@"first_name"] != (id)[NSNull null])
        {
            Fname_TXT.text=[UserSaveData valueForKey:@"first_name"];
        }
        if ([UserSaveData valueForKey:@"middle_name"] != (id)[NSNull null])
        {
            Mname_TXT.text=[UserSaveData valueForKey:@"middle_name"];
        }
        if ([UserSaveData valueForKey:@"last_name"] != (id)[NSNull null])
        {
            LName_TXT.text=[UserSaveData valueForKey:@"last_name"];
        }
        if ([UserSaveData valueForKey:@"email"] != (id)[NSNull null])
        {
            Email_TXT.text=[UserSaveData valueForKey:@"email"];
        }
        if ([UserSaveData valueForKey:@"phone"] != (id)[NSNull null])
        {
            Phone_TXT.text=[UserSaveData valueForKey:@"phone"];
        }
        if ([UserSaveData valueForKey:@"residential_address"] != (id)[NSNull null])
        {
            Residential_TXT.text=[UserSaveData valueForKey:@"residential_address"];
        }
    }

    
}
- (IBAction)Done_Click:(id)sender
{
    if ([ Fname_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter First name" delegate:nil];
    }
    else if ([Mname_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Middle name" delegate:nil];
    }
    else if ([LName_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Last name" delegate:nil];
    }
    else if ([Email_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Email address" delegate:nil];
    }
    else if ([Phone_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Phone number" delegate:nil];
    }
    else if ([Residential_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Residential address" delegate:nil];
    }
    else
    {
        
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
        {
            [self updateProfile];
        }
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    }
}

-(void)updateProfile
{
    
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Update_User_Profile  forKey:@"s"];
    
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    
    [dictParams setObject: Fname_TXT.text  forKey:@"first_name"];
    [dictParams setObject:Mname_TXT.text  forKey:@"middel_name"];
     [dictParams setObject:LName_TXT.text  forKey:@"last_name"];
    [dictParams setObject:Phone_TXT.text  forKey:@"phone"];
    [dictParams setObject:Email_TXT.text  forKey:@"email"];
    [dictParams setObject:Residential_TXT.text  forKey:@"residential_address"];
    [dictParams setObject:Residential_TXT.text  forKey:@"perment_address"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleUpdateProfileResponse:response];
     }];
}

- (void)handleUpdateProfileResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        NSMutableDictionary *dic = [[NSMutableDictionary  alloc] init];
        dic=[[response valueForKey:@"result"] mutableCopy];
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"LoginUserDic"];
        
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)Back_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
