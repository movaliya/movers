//
//  CompleteTaskVW.m
//  MisterMovers
//
//  Created by jignesh solanki on 09/03/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "CompleteTaskVW.h"
#import "misterMover.pch"
#import "JobHistory.h"
#import "HomeVW.h"

@interface CompleteTaskVW ()

@end

@implementation CompleteTaskVW

- (NSUInteger)supportedInterfaceOrientations // iOS 6 autorotation fix
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation // iOS 6 autorotation fix
{
    return UIInterfaceOrientationPortrait;
}

-(void)Setlockoriantation
{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self performSelector:@selector(Setlockoriantation) withObject:nil afterDelay:0.1];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)JobHistryBtn_Click:(id)sender
{
    JobHistory *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"JobHistory"];
    vcr.CheckPopupVw=@"POPUP";
    [self.navigationController pushViewController:vcr animated:YES];
}
- (IBAction)DashboardBtn_Click:(id)sender
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HomeVW class]]) {
            [self.navigationController popToViewController:controller animated:NO];
            break;
        }
    }
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
