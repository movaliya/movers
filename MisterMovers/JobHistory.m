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
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetHrtyTask];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
}
-(void)GetHrtyTask
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Get_Task  forKey:@"s"];
    
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    //[dictParams setObject:@"2"  forKey:@"eid"];
    [dictParams setObject:@"completed"  forKey:@"type"];
    
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleHrtyTaskResponse:response];
     }];
}
- (void)handleHrtyTaskResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        JobHrtyDic=[[response valueForKey:@"result"] mutableCopy];
        [HistoryTBL reloadData];
    }
    else
    {
        JobHrtyDic=[[NSMutableDictionary alloc]init];
        [HistoryTBL reloadData];
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
    return JobHrtyDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    cell.JobName_LBL.text=[[JobHrtyDic valueForKey:@"task_no"] objectAtIndex:indexPath.section];
    
    cell.JobTitle_LBL.text=[NSString stringWithFormat:@": %@",[[JobHrtyDic valueForKey:@"task_title"] objectAtIndex:indexPath.section]];
    
    cell.JobStartdate_LBL.text=[NSString stringWithFormat:@": %@",[[JobHrtyDic valueForKey:@"task_start_date"] objectAtIndex:indexPath.section]];
    
    cell.jobEnddate_LBL.text= [NSString stringWithFormat:@": %@",[[JobHrtyDic valueForKey:@"task_end_date"] objectAtIndex:indexPath.section]];
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
}
@end
