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
        ForSortData=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in accountDict)
        {
            [ForSortData addObject:dic];
        }
        
        sortedArray = [ForSortData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([[obj1 valueForKey:@"accountid"] integerValue] > [[obj2 valueForKey:@"accountid"] integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            if ([[obj1 valueForKey:@"accountid"] integerValue] < [[obj2 valueForKey:@"accountid"] integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];

        NSLog(@"dic=%@",sortedArray);
        
        float DebitINT = 0,CreditINT=0;
        for (int PP=0; PP<sortedArray.count; PP++)
        {
            DebitINT=DebitINT+[[[sortedArray valueForKey:@"debit"] objectAtIndex:PP]floatValue];
            CreditINT=CreditINT+[[[sortedArray valueForKey:@"credit"] objectAtIndex:PP]floatValue];
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
          //[self.navigationController popViewControllerAnimated:YES];
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
    //cell.SRNo_LBL.text=[[sortedArray valueForKey:@"accountid"]objectAtIndex:indexPath.section];
    cell.SRNo_LBL.text=[NSString stringWithFormat:@"%ld",indexPath.section+1];
    cell.Date_LBL.text=[[sortedArray valueForKey:@"created_date"]objectAtIndex:indexPath.section];
    cell.Description_LBL.text=[[sortedArray valueForKey:@"details"]objectAtIndex:indexPath.section];
    cell.debitamount_LBL.text=[[sortedArray valueForKey:@"debit"]objectAtIndex:indexPath.section];
    cell.CreditAmount_LBL.text=[[sortedArray valueForKey:@"credit"]objectAtIndex:indexPath.section];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


@end
