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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    [self.rootNav.pan_gr setEnabled:NO];
    self.rootNav.toolbarHidden=YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6 autorotation fix
{
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
    return UIInterfaceOrientationMaskLandscape;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    if ([[[response objectForKey:@"success"]stringValue ] isEqualToString:@"1"])
    {
        
        accountDict=[[response valueForKey:@"report"] mutableCopy];
        
        float DebitINT = 0,CreditINT=0;
        for (int PP=0; PP<accountDict.count; PP++)
        {
            DebitINT=DebitINT+[[[accountDict valueForKey:@"debit"] objectAtIndex:PP]floatValue];
            CreditINT=CreditINT+[[[accountDict valueForKey:@"credit"] objectAtIndex:PP]floatValue];
        }
        self.CreditTotal_LBL.text=[NSString stringWithFormat:@"%.02f",CreditINT];
        self.DebitTotal_LBL.text=[NSString stringWithFormat:@"%.02f",DebitINT];
        
        float ColsingBal=DebitINT+CreditINT;
         self.ClosingBalance_LBL.text=[NSString stringWithFormat:@"%.02f",ColsingBal];
        
        
        self.AccountNO_LBL.text=[NSString stringWithFormat:@"Account No.-: %@",[response valueForKey:@"account_number"]];
        self.DriverName_LBL.text=[NSString stringWithFormat:@"Driver Name-: %@",[response valueForKey:@"employee_name"]];
        self.FromDate_LBL.text=[NSString stringWithFormat:@"From Date %@",[response valueForKey:@"add_date"]];
        self.ToDate_LBL.text=[NSString stringWithFormat:@"To Date %@",[response valueForKey:@"add_date"]];
        [self.AccountTBL reloadData];
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
    return accountDict.count;
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
    cell.SRNo_LBL.text=[[accountDict valueForKey:@"accountid"]objectAtIndex:indexPath.section];
    cell.Date_LBL.text=[[accountDict valueForKey:@"created_date"]objectAtIndex:indexPath.section];
    cell.Description_LBL.text=[[accountDict valueForKey:@"details"]objectAtIndex:indexPath.section];
    cell.debitamount_LBL.text=[[accountDict valueForKey:@"debit"]objectAtIndex:indexPath.section];
    cell.CreditAmount_LBL.text=[[accountDict valueForKey:@"credit"]objectAtIndex:indexPath.section];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


@end
