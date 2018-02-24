//
//  ExpenseHistoryView.m
//  MisterMovers
//
//  Created by kaushik on 11/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "ExpenseHistoryView.h"
#import "ExpenseCellHistory.h"

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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
   
    cell.backgroundColor=[UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
