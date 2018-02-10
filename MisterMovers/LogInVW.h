//
//  LogInVW.h
//  digitalmarketing
//
//  Created by Mango SW on 14/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "digitalMarketing.pch"
@interface LogInVW : UIViewController<CCKFNavDrawerDelegate>
{
    
}
@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@property (weak, nonatomic) IBOutlet UITextField *UserName_TXT;
@property (weak, nonatomic) IBOutlet UITextField *Password_TXT;
@property (weak, nonatomic) IBOutlet UIView *usernm_View;
@property (weak, nonatomic) IBOutlet UIView *password_View;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;

@end
