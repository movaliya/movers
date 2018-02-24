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
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
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
    cell.VehicleNo_LBL.text=[NSString stringWithFormat:@": %@",[[Expense_historyDIC valueForKey:@"vehical_no"] objectAtIndex:indexPath.section]];
    cell.VehicleName_LBL.text=[NSString stringWithFormat:@": %@",[[Expense_historyDIC valueForKey:@"vehical_name"] objectAtIndex:indexPath.section]];
    cell.Amount_LBL.text=[NSString stringWithFormat:@": %@",[[Expense_historyDIC valueForKey:@"amount"] objectAtIndex:indexPath.section]];
    cell.Remark_LBL.text=[NSString stringWithFormat:@": %@",[[Expense_historyDIC valueForKey:@"remark"] objectAtIndex:indexPath.section]];
    
    cell.backgroundColor=[UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
