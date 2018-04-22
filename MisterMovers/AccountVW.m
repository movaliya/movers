//
//  AccountVW.m
//  MisterMovers
//
//  Created by jignesh solanki on 21/04/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "AccountVW.h"
#import "misterMover.pch"
#import "AccountCell.h"


@interface AccountVW ()

@end

@implementation AccountVW

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6 autorotation fix
{
    [self.rootNav closeNavigationDrawer];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return UIInterfaceOrientationMaskLandscape;
    }
    else
    {
        return UIInterfaceOrientationMaskLandscape;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation // iOS 6 autorotation fix
{
    return UIInterfaceOrientationLandscapeLeft;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    
    
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    UINib *nib = [UINib nibWithNibName:@"AccountCell" bundle:nil];
    AccountCell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    self.AccountTBL.rowHeight = cell.frame.size.height;
    [self.AccountTBL registerNib:nib forCellReuseIdentifier:@"AccountCell"];
    
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetAccount];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
}
-(void)GetAccount
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@userid=%@",AccountBaseUrl,[UserSaveData valueForKey:@"id"]] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleAccountResponse:response];
     }];
}

- (void)handleAccountResponse:(NSDictionary*)response
{
    [self.rootNav closeNavigationDrawer];
    if ([[[response objectForKey:@"success"]stringValue ] isEqualToString:@"1"])
    {
        accountDict=[[response valueForKey:@"report"] mutableCopy];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"message"] delegate:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackBtn_Click:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"AccountCell";
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


@end
