//
//  NotificationVW.m
//  digitalmarketing
//
//  Created by Mango SW on 15/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "NotificationVW.h"
#import "Notification_Cell.h"
#import "misterMover.pch"
#import "NotificationDispCell.h"
#import "StartTaskDetailVW.h"
#import "SignatureVW.h"
#import "UploadImgView.h"

@interface NotificationVW ()

@end

@implementation NotificationVW
@synthesize NotifTBL,NoNotification_LBL;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     NoNotification_LBL.hidden=YES;
    UINib *nib = [UINib nibWithNibName:@"NotificationDispCell" bundle:nil];
    NotificationDispCell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    NotifTBL.rowHeight = cell.frame.size.height;
    [NotifTBL registerNib:nib forCellReuseIdentifier:@"NotificationDispCell"];
    
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetNotificationTask];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
   
}
-(void)GetNotificationTask
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
     [dictParams setObject:get_notification  forKey:@"s"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
   
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleNotificationTaskResponse:response];
     }];
}

- (void)handleNotificationTaskResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        NoNotification_LBL.hidden=YES;
        NotificationDic=[[response valueForKey:@"result"] mutableCopy];
        [NotifTBL reloadData];
    }
    else
    {
        NoNotification_LBL.hidden=NO;
        //[AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NotificationDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"NotificationDispCell";
    NotificationDispCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    
    cell.NotifTitle_LBL.text=[[NotificationDic valueForKey:@"notification_title"] objectAtIndex:indexPath.section];
    cell.NotifDescription_LBL.text=[NSString stringWithFormat:@": %@",[[NotificationDic valueForKey:@"notification_description"] objectAtIndex:indexPath.section]];
    
    //cell.NotifTitle_LBL.text=[NSString stringWithFormat:@": %@",@"asjfdkjakdhaskj dsajkjaksdj aksjd kasjdkas kadjskdjaksjdkasjdkajsk kaj djaskdj akjjaksjkdjakdj sijaisj"];
    //cell.NotifDescription_LBL.text=[NSString stringWithFormat:@": %@",@"asjfdkjakdhaskj dsajkjaksdj aksjd kasjdkas kadjskdjaksjdkasjdkajsk kaj djaskdj akjjaksjkdjakdj sijaisj"];
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *Task_Status=[[NotificationDic valueForKey:@"task_status"]objectAtIndex:indexPath.section];
    if ([Task_Status isEqualToString:@"3"])
    {
        //End Signature
        SignatureVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignatureVW"];
        vcr.Task_ID=[[NotificationDic valueForKey:@"reference_id"] objectAtIndex:indexPath.section];
       // vcr.Task_No2=[[NotificationDic valueForKey:@"task_no"] objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else if ([Task_Status isEqualToString:@"4"])
    {
        //Job Photos
        UploadImgView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UploadImgView"];
        vcr.Task_ID=[[NotificationDic valueForKey:@"reference_id"] objectAtIndex:indexPath.section];
       // vcr.Task_No=[[NotificationDic valueForKey:@"task_no"] objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:vcr animated:YES];
        
    }
    else
    {
        StartTaskDetailVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"StartTaskDetailVW"];
        NSLog(@"taskid=%@",[[NotificationDic valueForKey:@"id"] objectAtIndex:indexPath.section]);
        vcr.Task_ID=[[NotificationDic valueForKey:@"reference_id"] objectAtIndex:indexPath.section];
        //vcr.Task_NO=[[NotificationDic valueForKey:@"task_no"] objectAtIndex:indexPath.section];
        
        [self.navigationController pushViewController:vcr animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)Back_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
