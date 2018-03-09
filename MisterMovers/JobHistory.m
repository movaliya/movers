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
#import "CustomAlert.h"
#import "HomeVW.h"


@interface JobHistory ()
{
    CustomAlert *alert;
    
}
@property (strong, nonatomic) UIButton *CancleBTN;
@property (strong, nonatomic) UIButton *SetBTN;
@property (strong, nonatomic) UIButton *ClearBTN;
@property (strong, nonatomic) UITextField *FromDateTXT;
@property (strong, nonatomic) UITextField *ToDateTXT;

@end

@implementation JobHistory
@synthesize HistoryTBL,NoJobHistoryBTN;

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
    
    
    self.FromDateTXT = (UITextField *)[alert viewWithTag:103];
    self.ToDateTXT = (UITextField *)[alert viewWithTag:104];
    
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
   // [dictParams setObject:@"2"  forKey:@"eid"];
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
- (IBAction)FilterBtn_Click:(id)sender
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
    

    if ([self.ToDateTXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter From Date" delegate:nil];
    }
    else if ([ self.FromDateTXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter To Date" delegate:nil];
    }
    else
    {
        
        
        // NSString *dateStr = @"2016-09-20";
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm"];
        NSDate *Startdate = [dateFormat dateFromString:self.FromDateTXT.text];
        
        // NSString *dateStr2 = @"2016-09-21";
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"dd-MM-yyyy HH:mm"]; // HH:mm
        NSDate *Enddate = [dateFormat2 dateFromString:self.ToDateTXT.text];
        
        if ([[Enddate laterDate:Startdate] isEqualToDate:Enddate]) {
            NSLog(@"currentDate is later then previousDate");
            
            alert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            [UIView animateWithDuration:0.2 animations:^{
                alert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    alert.hidden=YES;
                }];
            }];
            /*
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
             NSString *endTimeStamp = [[NSNumber numberWithInt:floor([Enddate timeIntervalSince1970])] stringValue];*/
            
            
            NSMutableArray* result = [NSMutableArray array];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"dd-MM-yyyy HH:mm";
            for (NSDictionary *dict in JobHrtyDic) {
                NSString *dateString = dict[@"task_start_date"];
                
                NSDate *date = [formatter dateFromString:dateString];
                if ([date compare:Startdate] > 0 && [date compare:Enddate] < 0) {
                    [result addObject:dict];
                }
            }
            
            JobHrtyDic = [result mutableCopy];
            
            
            //  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((task_start_date >= %@) AND (task_start_date <= %@))",startTimeStamp,endTimeStamp];
            
            //NSLog(@"predicate is %@",predicate);
            
            //  NSArray *totalArr = [TodayTaskDic filteredArrayUsingPredicate:predicate];
            //TodayTaskDic=[[NSMutableArray alloc]init];
            //  TodayTaskDic = [totalArr mutableCopy];
            
            //   NSLog(@"NEW ARR==%@",totalArr);
            [HistoryTBL reloadData];
        }
        else
        {
            [AppDelegate showErrorMessageWithTitle:@"Alert..!" message:@"From date is greater than To date" delegate:nil];
        }
    }
   
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)Back_Click:(id)sender
{
    if (self.CheckPopupVw!=nil)
    {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[HomeVW class]]) {
                [self.navigationController popToViewController:controller animated:NO];
                break;
            }
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
