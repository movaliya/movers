//
//  HomeVW.m
//  digitalmarketing
//
//  Created by Mango SW on 14/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "HomeVW.h"
#import "ProfileVIEW.h"
#import "NotificationVW.h"
@interface HomeVW ()

@end

@implementation HomeVW
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    [self.rootNav CheckLoginArr];
    [self.rootNav.pan_gr setEnabled:YES];
    
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    [self.rootNav.pan_gr setEnabled:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)Home_Icon_Method:(id)sender
{
    UIButton *aButton = (UIButton *)sender;
    
    if (aButton.tag == 1)
    {
        // Attendance
    }
    else if (aButton.tag == 2)
    {
        // Notification
        NotificationVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NotificationVW"];
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else if (aButton.tag == 3)
    {
        // Create Order
    }
    else if (aButton.tag == 4)
    {
        // Order History
    }
    else if (aButton.tag == 5)
    {
        // Customer
    }
    else if (aButton.tag == 6)
    {
        // Inward
    }
    else if (aButton.tag == 7)
    {
        // Inward History
    }
    else if (aButton.tag == 8)
    {
        // Stock
    }
    else if (aButton.tag == 9)
    {
        // Dispatch
    }
    else if (aButton.tag == 10)
    {
        // Dispatch History
    }
    else if (aButton.tag == 11)
    {
        // Profile Activity
        ProfileVIEW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileVIEW"];
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else if (aButton.tag == 12)
    {
        // Logout
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Are you sure want to Logout?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Logout",nil];
        alert.tag=50;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // the user clicked Logout
    if (alertView.tag==50)
    {
        if (buttonIndex == 1)
        {
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"LoginUserDic"];
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
    }
}



#pragma mark - photoShotSavedDelegate

- (IBAction)MenuBtn_action:(id)sender
{
    [self.rootNav drawerToggle];
}
-(void)CCKFNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"CCKFNavDrawerSelection = %li", (long)selectionIndex);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
