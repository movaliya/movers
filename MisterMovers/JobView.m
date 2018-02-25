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
#import "CustomAlert.h"

#define SelectedLabelColor [UIColor colorWithRed:255.0/255.0 green:175.0/255.0 blue:77.0/255.0 alpha:1.0]
#define Whitecolortitle [UIColor whiteColor]


@interface JobView ()
{
    CustomAlert *alert;

}
@property (strong, nonatomic) UIButton *CancleBTN;
@property (strong, nonatomic) UIButton *SetBTN;
@property (strong, nonatomic) UIButton *ClearBTN;
@property (strong, nonatomic) UITextField *FromDateTXT;
@property (strong, nonatomic) UITextField *ToDateTXT;



@end

@implementation JobView
@synthesize Today_BTN,Today_LBL,All_BTN,All_LBL,FilterBTN,MainTBL,NoJobsFound_LBL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    alert = [[CustomAlert alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:alert];
    alert.hidden=YES;
    
    self.CancleBTN = (UIButton *)[alert viewWithTag:100];
    [self.CancleBTN addTarget:self action:@selector(PopupCancle_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    self.ClearBTN = (UIButton *)[alert viewWithTag:101];
    [self.ClearBTN addTarget:self action:@selector(PopupClearBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    self.SetBTN = (UIButton *)[alert viewWithTag:102];
    [self.SetBTN addTarget:self action:@selector(PopupSetBTN_Click:) forControlEvents:UIControlEventTouchUpInside];

    FilterBTN.hidden=YES;
    NoJobsFound_LBL.hidden=YES;
    
    self.FromDateTXT = (UITextField *)[alert viewWithTag:103];
    self.ToDateTXT = (UITextField *)[alert viewWithTag:104];
    
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
        NoJobsFound_LBL.hidden=YES;
        TodayTaskDic=[[response valueForKey:@"result"] mutableCopy];
        [MainTBL reloadData];
    }
    else
    {
         NoJobsFound_LBL.hidden=NO;
        TodayTaskDic=[[NSMutableDictionary alloc]init];
        [MainTBL reloadData];
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
        NoJobsFound_LBL.hidden=YES;
        TodayTaskDic=[[response valueForKey:@"result"] mutableCopy];
        [MainTBL reloadData];
    }
    else
    {
        NoJobsFound_LBL.hidden=NO;
        TodayTaskDic=[[NSMutableDictionary alloc]init];
        [MainTBL reloadData];
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
    [self.view endEditing:YES];
    alert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    
    [KmyappDelegate SettextfieldViewBorder:alert.FromDateView];
    [KmyappDelegate SettextfieldViewBorder:alert.ToDateView];
    alert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    
    alert.hidden=NO;
    
    [UIView animateWithDuration:0.2 animations:
     ^{
        alert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
      }];
}

-(void)PopupCancle_Click:(id)sender
{
    alert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView animateWithDuration:0.2 animations:^{
        alert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            alert.hidden=YES;
        }];
    }];
}
-(void)PopupClearBTN_Click:(id)sender
{
    self.ToDateTXT.text=@"";
    self.FromDateTXT.text=@"";
}
-(void)PopupSetBTN_Click:(id)sender
{
    /*
    // NSString *dateStr = @"2016-09-20";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *Startdate = [dateFormat dateFromString:self.FromTextPop.text];
    
    // NSString *dateStr2 = @"2016-09-21";
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"dd-MM-yyyy"];
    NSDate *Enddate = [dateFormat2 dateFromString:self.ToTextPop.text];
    
    if ([[Enddate laterDate:Startdate] isEqualToDate:Enddate]) {
        NSLog(@"currentDate is later then previousDate");
        DateFiiterPOPUp.hidden=YES;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit ) fromDate:[NSDate date]];
        //create a date with these components
        NSDate *startDate = [calendar dateFromComponents:components];
        [components setMonth:0];
        [components setDay:0]; //reset the other components
        [components setYear:0]; //reset the other components
        NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
        
        startDate = [NSDate date];
        endDate = [startDate dateByAddingTimeInterval:-(7 * 24 * 60 * 60)];//change here
        
        NSString *startTimeStamp = [[NSNumber numberWithInt:floor([Startdate timeIntervalSince1970])] stringValue];
        NSString *endTimeStamp = [[NSNumber numberWithInt:floor([Enddate timeIntervalSince1970])] stringValue];
        
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((date >= %@) AND (date <= %@))",startTimeStamp,endTimeStamp];
        NSLog(@"predicate is %@",predicate);
        NSArray *totalArr = [filterArray filteredArrayUsingPredicate:predicate];
        ExchangeArray = [totalArr mutableCopy];
        
        NSLog(@"NEW ARR==%@",totalArr);
        [Table reloadData];*/
        
        
    alert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView animateWithDuration:0.2 animations:^{
        alert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            alert.hidden=YES;
        }];
    }];
}

#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TodayTaskDic.count;
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
   
    cell.JobName_LBL.text=[[TodayTaskDic valueForKey:@"task_no"] objectAtIndex:indexPath.section];
    
    cell.JobTitle_LBL.text=[NSString stringWithFormat:@": %@",[[TodayTaskDic valueForKey:@"task_title"] objectAtIndex:indexPath.section]];
    
    cell.JobStartdate_LBL.text=[NSString stringWithFormat:@": %@",[[TodayTaskDic valueForKey:@"task_start_date"] objectAtIndex:indexPath.section]];
    
    cell.jobEnddate_LBL.text= [NSString stringWithFormat:@": %@",[[TodayTaskDic valueForKey:@"task_end_date"] objectAtIndex:indexPath.section]];
    
    
    
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
