//
//  ProfileVIEW.h
//  digitalmarketing
//
//  Created by Mango SW on 15/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"

@interface ProfileVIEW : UIViewController
{
    
}
@property (strong, nonatomic) IBOutlet UIView *InfoView;
- (IBAction)Back_Click:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *FNameView;
@property (strong, nonatomic) IBOutlet UITextField *Fname_TXT;
@property (strong, nonatomic) IBOutlet UIView *MNameView;
@property (strong, nonatomic) IBOutlet UITextField *Mname_TXT;
@property (strong, nonatomic) IBOutlet UIView *LNameView;
@property (strong, nonatomic) IBOutlet UITextField *LName_TXT;
@property (strong, nonatomic) IBOutlet UIView *PhoneView;
@property (strong, nonatomic) IBOutlet UITextField *Phone_TXT;
@property (strong, nonatomic) IBOutlet UIView *EmailView;
@property (strong, nonatomic) IBOutlet UITextField *Email_TXT;
@property (strong, nonatomic) IBOutlet UIView *ResidentialView;
@property (strong, nonatomic) IBOutlet IQTextView *Residential_TXT;
- (IBAction)Done_Click:(id)sender;

@end
