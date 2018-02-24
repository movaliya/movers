//
//  JobHistory.m
//  MisterMovers
//
//  Created by kaushik on 24/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "JobHistory.h"
#import "misterMover.pch"
#import "TodayJobCell.h"

@interface JobHistory ()

@end

@implementation JobHistory
@synthesize HistoryTBL,NoJobHistoryBTN;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NoJobHistoryBTN.hidden=YES;
    
    UINib *nib = [UINib nibWithNibName:@"TodayJobCell" bundle:nil];
    TodayJobCell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    HistoryTBL.rowHeight = cell.frame.size.height;
    [HistoryTBL registerNib:nib forCellReuseIdentifier:@"TodayJobCell"];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"TodayJobCell";
    TodayJobCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
