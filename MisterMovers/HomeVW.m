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
#import "JobView.h"
#import "ExpenseView.h"
#import "ExpenseHistoryView.h"
#import "InvoiceView.h"
#import "JobHistory.h"
#import "UploadImgView.h"

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
}

- (IBAction)Home_Icon_Method:(id)sender
{
    UIButton *aButton = (UIButton *)sender;
    
    if (aButton.tag == 1)
    {
        UploadImgView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UploadImgView"];
        [self.navigationController pushViewController:vcr animated:YES];
        // Attendance
    }
    else if (aButton.tag == 2)
    {
        NotificationVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NotificationVW"];
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else if (aButton.tag == 3)
    {
        JobView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"JobView"];
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else if (aButton.tag == 4)
    {
        // Order History
    }
    else if (aButton.tag == 5)
    {
        JobHistory *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"JobHistory"];
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else if (aButton.tag == 6)
    {
        InvoiceView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"InvoiceView"];
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else if (aButton.tag == 7)
    {
        ExpenseView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpenseView"];
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else if (aButton.tag == 8)
    {
        ExpenseHistoryView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpenseHistoryView"];
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else if (aButton.tag == 9)
    {
        ProfileVIEW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileVIEW"];
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else if (aButton.tag == 10)
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure want to Logout?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            // Cancel Action
        }];
        UIAlertAction *Logout = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            // Logout action
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"LoginUserDic"];
            [self.navigationController popToRootViewControllerAnimated:NO];
           
        }];
        [alert addAction:Cancel];
        [alert addAction:Logout];
        // Present action where needed
        [self presentViewController:alert animated:YES completion:nil];
        
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
