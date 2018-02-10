//
//  ProfileVIEW.m
//  digitalmarketing
//
//  Created by Mango SW on 15/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "ProfileVIEW.h"
#import "digitalMarketing.pch"

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
    
    
    
    
    
    
}

- (IBAction)BackBtn_action:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)Back_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Done_Click:(id)sender
{
    
}

@end
