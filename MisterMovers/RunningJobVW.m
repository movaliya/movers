//
//  RunningJobVW.m
//  MisterMovers
//
//  Created by jignesh solanki on 09/03/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "RunningJobVW.h"
#import "misterMover.pch"
#import "TodayJobCell.h"
#import "SignatureVW.h"
#import "UploadImgView.h"
#import "StartTaskDetailVW.h"

@interface RunningJobVW ()

@end

@implementation RunningJobVW
@synthesize RunningJobTable,noDataLBL;

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
    noDataLBL.hidden=YES;
    UINib *nib = [UINib nibWithNibName:@"TodayJobCell" bundle:nil];
    TodayJobCell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    RunningJobTable.rowHeight = cell.frame.size.height;
    [RunningJobTable registerNib:nib forCellReuseIdentifier:@"TodayJobCell"];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetTodayTask];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    // Do any additional setup after loading the view.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)GetTodayTask
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Get_Task  forKey:@"s"];
    
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    
    [dictParams setObject:@"running"  forKey:@"type"];
   // [dictParams setObject:@"0"  forKey:@"ul"];
   // [dictParams setObject:@"5"  forKey:@"ll"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleTodayTaskResponse:response];
     }];
}

- (void)handleTodayTaskResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        noDataLBL.hidden=YES;
        runningJobDic=[[response valueForKey:@"result"] mutableCopy];
        [RunningJobTable reloadData];
    }
    else
    {
        noDataLBL.hidden=NO;
        [RunningJobTable reloadData];
       // [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return runningJobDic.count;
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
    
    cell.JobName_LBL.text=[[runningJobDic valueForKey:@"task_no"] objectAtIndex:indexPath.section];
    
    cell.JobTitle_LBL.text=[NSString stringWithFormat:@": %@",[[runningJobDic valueForKey:@"task_title"] objectAtIndex:indexPath.section]];
    
    cell.JobStartdate_LBL.text=[NSString stringWithFormat:@": %@",[[runningJobDic valueForKey:@"task_start_date"] objectAtIndex:indexPath.section]];
    
    NSString *enddatestr=[[runningJobDic valueForKey:@"task_ended_date"] objectAtIndex:indexPath.section];
    if (![enddatestr isEqualToString:@""])
    {
        cell.jobEnddate_LBL.text= [NSString stringWithFormat:@": %@",[[runningJobDic valueForKey:@"task_ended_date"] objectAtIndex:indexPath.section]];
    }
    else
    {
        cell.jobEnddate_LBL.text= @": Not Yet Ended";
    }
     
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *Task_Status=[[runningJobDic valueForKey:@"task_status"]objectAtIndex:indexPath.section];
    if ([Task_Status isEqualToString:@"3"])
    {
        //End Signature
        SignatureVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignatureVW"];
        vcr.Task_ID=[[runningJobDic valueForKey:@"id"] objectAtIndex:indexPath.section];
        vcr.Task_No2=[[runningJobDic valueForKey:@"task_no"] objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else if ([Task_Status isEqualToString:@"4"])
    {
        //Job Photos
        UploadImgView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UploadImgView"];
        vcr.Task_ID=[[runningJobDic valueForKey:@"id"] objectAtIndex:indexPath.section];
        vcr.Task_No=[[runningJobDic valueForKey:@"task_no"] objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:vcr animated:YES];
        
    }
    else
    {
        StartTaskDetailVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"StartTaskDetailVW"];
        NSLog(@"taskid=%@",[[runningJobDic valueForKey:@"id"] objectAtIndex:indexPath.section]);
        vcr.Task_ID=[[runningJobDic valueForKey:@"id"] objectAtIndex:indexPath.section];
        vcr.Task_NO=[[runningJobDic valueForKey:@"task_no"] objectAtIndex:indexPath.section];
        vcr.CheckPopup=@"RunningView";
        [self.navigationController pushViewController:vcr animated:YES];
    }
    
}
- (IBAction)BackBtn_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
