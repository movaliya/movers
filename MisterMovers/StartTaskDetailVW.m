//
//  StartTaskDetailVW.m
//  MisterMovers
//
//  Created by jignesh solanki on 20/02/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "StartTaskDetailVW.h"
#import "misterMover.pch"
#import "TremNconditionVW.h"
@interface StartTaskDetailVW ()

@end

@implementation StartTaskDetailVW
@synthesize FirstView,SecondView,TherdView,TherdViewBorder;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [FirstView.layer setShadowColor:[UIColor blackColor].CGColor];
    [FirstView.layer setShadowOpacity:0.8];
    [FirstView.layer setShadowRadius:2.0];
    [FirstView.layer setShadowOffset:CGSizeMake(1.0,1.0)];
    
    [SecondView.layer setShadowColor:[UIColor blackColor].CGColor];
    [SecondView.layer setShadowOpacity:0.8];
    [SecondView.layer setShadowRadius:2.0];
    [SecondView.layer setShadowOffset:CGSizeMake(1.0,1.0)];
    
    [TherdView.layer setShadowColor:[UIColor blackColor].CGColor];
    [TherdView.layer setShadowOpacity:0.8];
    [TherdView.layer setShadowRadius:2.0];
    [TherdView.layer setShadowOffset:CGSizeMake(1.0,1.0)];
    
    TherdViewBorder.layer.cornerRadius=2.0f;
    TherdViewBorder.layer.borderWidth=1.0f;
    TherdViewBorder.layer.borderColor=[[UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1.0f] CGColor];
    self.JobTitle_LBL.text=self.Task_NO;
    self.JobNo_LBL.text=self.Task_NO;
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetDetailTask];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
}
-(void)GetDetailTask
{
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Get_Detail_Task  forKey:@"s"];
    
    [dictParams setObject:self.Task_ID  forKey:@"tid"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleDetailTaskResponse:response];
     }];
}
- (void)handleDetailTaskResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        DetailTaskDic=[[response valueForKey:@"result"] mutableCopy];
        
        self.TaskTitle.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_title"]];
        self.preferredDate_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_start_date"]];
        self.EndDate_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_end_date"]];
        self.pickupAdreess_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_location_from"]];
        self.DropAddress_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_location_to"]];
        self.Address1_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_address1"]];
        self.Address2_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_address2"]];
        NSString *customfullname=[NSString stringWithFormat:@": %@ %@",[DetailTaskDic valueForKey:@"inquiry_first_name"],[DetailTaskDic valueForKey:@"inquiry_last_name"]];
        self.CutomerName_LBL.text=customfullname;
        self.CustomerNumber_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"inquiry_contact"]];
        self.CustomerEmail_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"inquiry_email"]];
        self.PerHourRate_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"price_per_rate"]];
        
        NSArray *helpers_details=[[DetailTaskDic valueForKey:@"helpers_details"]objectAtIndex:0];
        self.HelperNumber_LBL.text=[helpers_details valueForKey:@"employee_phone"];
        self.HelperName_LBL.text=[helpers_details valueForKey:@"employee_name"];
        self.MinumulHours_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"quotation_minimum_hour"]];
        
         self.vehicleReg_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_vehicle_no"]];
        //self.Pianoamount_LBL.text=[DetailTaskDic valueForKey:@"task_start_date"];
        //self.PoolTableAmount_LBL.text=[DetailTaskDic valueForKey:@"task_start_date"];
        //self.addSurhargeTitle_LBL.text=[DetailTaskDic valueForKey:@"task_start_date"];
        
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (IBAction)StartTask_Action:(id)sender
{
   
    TremNconditionVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TremNconditionVW"];
    vcr.Task_ID=[DetailTaskDic valueForKey:@"id"];
    vcr.vehical_id=[DetailTaskDic valueForKey:@"task_vehicle_id"];
    [self.navigationController pushViewController:vcr animated:YES];
}
- (IBAction)backBtn_Click:(id)sender
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
