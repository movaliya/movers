//
//  JobView.m
//  MisterMovers
//
//  Created by kaushik on 11/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "JobView.h"
#import "TodayJobCell.h"
#import "JobDetailView.h"
#import "misterMover.pch"
#import "StartTaskDetailVW.h"

#define SelectedLabelColor [UIColor colorWithRed:255.0/255.0 green:175.0/255.0 blue:77.0/255.0 alpha:1.0]
#define Whitecolortitle [UIColor whiteColor]


@interface JobView ()

@end

@implementation JobView
@synthesize Today_BTN,Today_LBL,All_BTN,All_LBL,FilterBTN,MainTBL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    FilterBTN.hidden=YES;
    
    UINib *nib = [UINib nibWithNibName:@"TodayJobCell" bundle:nil];
    TodayJobCell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    MainTBL.rowHeight = cell.frame.size.height;
    [MainTBL registerNib:nib forCellReuseIdentifier:@"TodayJobCell"];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetTodayTask];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
    
    
}
-(void)GetTodayTask
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Get_Task  forKey:@"s"];
    
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    
    [dictParams setObject:@"today"  forKey:@"type"];
    [dictParams setObject:@"0"  forKey:@"ul"];
    [dictParams setObject:@"5"  forKey:@"ll"];
   
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleTodayTaskResponse:response];
     }];
}
- (void)handleTodayTaskResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        TodayTaskDic=[[response valueForKey:@"result"] mutableCopy];
        [MainTBL reloadData];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
-(void)GetAllTask
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Get_Task  forKey:@"s"];
    
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    
    [dictParams setObject:@"general"  forKey:@"type"];
    [dictParams setObject:@"0"  forKey:@"ul"];
    [dictParams setObject:@"5"  forKey:@"ll"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleAllTaskResponse:response];
     }];
}
- (void)handleAllTaskResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        TodayTaskDic=[[response valueForKey:@"result"] mutableCopy];
        [MainTBL reloadData];
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

- (IBAction)Tab_Click:(id)sender
{
    FilterBTN.hidden=YES;
    MainTBL.hidden=NO;
    if ([sender isEqual:Today_BTN])
    {
        Today_LBL.backgroundColor=SelectedLabelColor;
        [Today_BTN setTitleColor:SelectedLabelColor forState:UIControlStateNormal];
        
        All_LBL.backgroundColor=[UIColor clearColor];
        [All_BTN setTitleColor:Whitecolortitle forState:UIControlStateNormal];
        
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
            [self GetTodayTask];
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    }
    else if ([sender isEqual:All_BTN])
    {
        FilterBTN.hidden=NO;
       // MainTBL.hidden=YES;
        All_LBL.backgroundColor=SelectedLabelColor;
        [All_BTN setTitleColor:SelectedLabelColor forState:UIControlStateNormal];
        
        Today_LBL.backgroundColor=[UIColor clearColor];
        [Today_BTN setTitleColor:Whitecolortitle forState:UIControlStateNormal];
        
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
            [self GetAllTask];
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
        
    }
}

- (IBAction)Filter_Click:(id)sender
{
    
}


#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TodayTaskDic.count;
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
   
    cell.JobName_LBL.text=[[TodayTaskDic valueForKey:@"task_no"] objectAtIndex:indexPath.section];
    
    cell.JobTitle_LBL.text=[NSString stringWithFormat:@": %@",[[TodayTaskDic valueForKey:@"task_title"] objectAtIndex:indexPath.row]];
    
    cell.JobStartdate_LBL.text=[NSString stringWithFormat:@": %@",[[TodayTaskDic valueForKey:@"task_start_date"] objectAtIndex:indexPath.row]];
    
    cell.jobEnddate_LBL.text= [NSString stringWithFormat:@": %@",[[TodayTaskDic valueForKey:@"task_end_date"] objectAtIndex:indexPath.row]];
    
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StartTaskDetailVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"StartTaskDetailVW"];
    vcr.Task_ID=[[TodayTaskDic valueForKey:@"id"] objectAtIndex:indexPath.row];
    vcr.Task_NO=[[TodayTaskDic valueForKey:@"task_no"] objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:vcr animated:YES];

}

@end
