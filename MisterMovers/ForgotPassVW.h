//
//  ForgotPassVW.h
//  digitalmarketing
//
//  Created by Mango SW on 14/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "misterMover.pch"

@interface ForgotPassVW : UIViewController<CCKFNavDrawerDelegate>
{
    
}
@property (strong, nonatomic) CCKFNavDrawer *rootNav;
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UITextField *Email_TXT;
@property (weak, nonatomic) IBOutlet UIButton *FindAccountBtn;
@property (weak, nonatomic) IBOutlet UIView *passwordtxt_View;

@end
