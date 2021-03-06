//
//  ExpenseHistoryView.m
//  MisterMovers
//
//  Created by kaushik on 11/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "ExpenseHistoryView.h"
#import "ExpenseCellHistory.h"
#import "misterMover.pch"
@interface ExpenseHistoryView ()

@end

@implementation ExpenseHistoryView
@synthesize ExpenseTBL,NoExpBTN;

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
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NoExpBTN.hidden=YES;
    
    UINib *nib = [UINib nibWithNibName:@"ExpenseCellHistory" bundle:nil];
    ExpenseCellHistory *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    ExpenseTBL.rowHeight = cell.frame.size.height;
    [ExpenseTBL registerNib:nib forCellReuseIdentifier:@"ExpenseCellHistory"];
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetExpense_history];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}
-(void)GetExpense_history
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Expense_history  forKey:@"s"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleExpense_historyResponse:response];
     }];
}

- (void)handleExpense_historyResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        Expense_historyDIC=[[response valueForKey:@"result"] mutableCopy];
        [ExpenseTBL reloadData];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:@"NO HISTORY FOUND" delegate:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)Back_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return Expense_historyDIC.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ExpenseCellHistory";
    ExpenseCellHistory *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    
    cell.Jobtitle_LBL.text=[NSString stringWithFormat:@": %@",[[Expense_historyDIC valueForKey:@"job_title"] objectAtIndex:indexPath.section]];
    cell.ExpenseType_LBL.text=[NSString stringWithFormat:@": %@",[[Expense_historyDIC valueForKey:@"expense_type"] objectAtIndex:indexPath.section]];
    
    if ([[[Expense_historyDIC valueForKey:@"expense_type"] objectAtIndex:indexPath.section] isEqualToString:@"Fuel"])
    {
        cell.VehicletNoTitle_LBL.text=@"Vehicle No";
        cell.AmountTop.constant=70.0f;
        cell.VehicleNo_LBL.text=[NSString stringWithFormat:@": %@",[[Expense_historyDIC valueForKey:@"vehical_no"] objectAtIndex:indexPath.section]];
        cell.VehicleName_LBL.text=[NSString stringWithFormat:@": %@",[[Expense_historyDIC valueForKey:@"vehical_name"] objectAtIndex:indexPath.section]];
    }
    else if ([[[Expense_historyDIC valueForKey:@"expense_type"] objectAtIndex:indexPath.section] isEqualToString:@"Others"])
    {
        cell.AmountTop.constant=10.0f;
        cell.VehicletNoTitle_LBL.hidden=YES;
        cell.VehicleNameTitle_LBL.hidden=YES;
        cell.VehicletNoTitle_LBL.text=@"Vehicle No";
        cell.VehicleNo_LBL.text=@"";
        cell.VehicleName_LBL.text=@"";
    }
    else if ([[[Expense_historyDIC valueForKey:@"expense_type"] objectAtIndex:indexPath.section] isEqualToString:@"Helper"])
    {
        cell.AmountTop.constant=40.0f;
        cell.VehicletNoTitle_LBL.hidden=NO;
        cell.VehicleNameTitle_LBL.hidden=YES;
        cell.VehicletNoTitle_LBL.text=@"Helper Name";
        cell.VehicleNo_LBL.text=[NSString stringWithFormat:@": %@",[[Expense_historyDIC valueForKey:@"helper_name"] objectAtIndex:indexPath.section]];
        
        cell.VehicleName_LBL.text=@"";
    }
    
    
    
    
    cell.Amount_LBL.text=[NSString stringWithFormat:@": %@",[[Expense_historyDIC valueForKey:@"amount"] objectAtIndex:indexPath.section]];
    cell.Remark_LBL.text=[NSString stringWithFormat:@": %@",[[Expense_historyDIC valueForKey:@"remark"] objectAtIndex:indexPath.section]];
    
    cell.backgroundColor=[UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

@end
