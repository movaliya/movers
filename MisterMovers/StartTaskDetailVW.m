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
#import "PrivacyPolicyVW.h"
@interface StartTaskDetailVW ()
{
    PrivacyPolicyVW *policyAlert;
    
}

@property (strong, nonatomic) UIButton *CanclepolicyBTN;
@property (strong, nonatomic) UIButton *SubmitpolicyBTN;
@property (strong, nonatomic) UIWebView *policywevVw;

@end

@implementation StartTaskDetailVW
@synthesize FirstView,SecondView,TherdView,TherdViewBorder;

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    policyAlert = [[PrivacyPolicyVW alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:policyAlert];
//    policyAlert.hidden=YES;
//    
//    self.CanclepolicyBTN = (UIButton *)[policyAlert viewWithTag:200];
//    [self.CanclepolicyBTN addTarget:self action:@selector(CanclePolicy_Click:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.SubmitpolicyBTN = (UIButton *)[policyAlert viewWithTag:201];
//    [self.SubmitpolicyBTN addTarget:self action:@selector(SubmitPolicyBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.policywevVw = (UIWebView *)[policyAlert viewWithTag:202];
//    NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"policy" ofType:@"pdf"];
//    NSURL *url = [NSURL fileURLWithPath:urlAddress];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//    [self.policywevVw loadRequest:urlRequest];
    
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
        [self FilluptheTaskDetail];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

-(void)FilluptheTaskDetail
{
    self.TaskTitle.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_title"]];
    self.preferredDate_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_start_date"]];
    self.EndDate_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_end_date"]];
    
    
    //Pickup Address
    if ([[DetailTaskDic valueForKey:@"task_location_from"]isEqualToString:@""])
    {
        self.PickupAddressTop.constant=0;
        self.PickupAddressTitle_LBL.text=@"";
        self.pickupAdreess_LBL.text=@"";
    }
    else
    {
        self.pickupAdreess_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_location_from"]];
    }
    
    //Drope Address
    if ([[DetailTaskDic valueForKey:@"task_location_to"]isEqualToString:@""])
    {
        self.DropAddressTop.constant=0;
        self.DropAddressTitle_LBL.text=@"";
        self.DropAddress_LBL.text=@"";
    }
    else
    {
        self.DropAddress_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_location_to"]];
    }
    
    // Address 1
    if ([[DetailTaskDic valueForKey:@"task_address1"]isEqualToString:@""])
    {
        self.address1Top.constant=0;
        self.Address1Title_LBL.text=@"";
        self.Address1_LBL.text=@"";
    }
    else
    {
        self.Address1_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_address1"]];
    }
    
    // Address 2
    if ([[DetailTaskDic valueForKey:@"task_address2"]isEqualToString:@""])
    {
        self.address2Top.constant=0;
        self.Address2Title_LBL.text=@"";
        self.Address2_LBL.text=@"";
    }
    else
    {
        self.Address2_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_address2"]];
    }
    
    // Customer Name
    NSString *customfullname=[NSString stringWithFormat:@": %@ %@",[DetailTaskDic valueForKey:@"inquiry_first_name"],[DetailTaskDic valueForKey:@"inquiry_last_name"]];
    if ([customfullname isEqualToString:@""])
    {
        self.CustomerNameTop.constant=0;
        self.CustomerNmTitle_LBL.text=@"";
        self.CutomerName_LBL.text=@"";
    }
    else
    {
        self.CutomerName_LBL.text=customfullname;
    }
    
    // Customer Contact
    if ([[DetailTaskDic valueForKey:@"inquiry_contact"]isEqualToString:@""])
    {
        self.CustomerNumberTop.constant=0;
        self.CustomerNumber_LBL.text=@"";
        self.CustomerNumberTitle_LBL.text=@"";
    }
    else
    {
        self.CustomerNumber_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"inquiry_contact"]];
    }
    
    // Customer Email
    if ([[DetailTaskDic valueForKey:@"inquiry_email"]isEqualToString:@""])
    {
        self.CustomerEmailTop.constant=0;
        self.CustomerEmail_LBL.text=@"";
        self.CustomerEmailTitle_LBL.text=@"";
    }
    else
    {
        self.CustomerEmail_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"inquiry_email"]];
    }
    
    // PerHour Rate
    if ([[DetailTaskDic valueForKey:@"price_per_rate"]isEqualToString:@""])
    {
        self.PerHourRateTop.constant=0;
        self.PerHourRate_LBL.text=@"";
        self.PerHourTitle_LBL.text=@"";
    }
    else
    {
        self.PerHourRate_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"price_per_rate"]];
    }
    
    // Vehicle Name
    if ([[DetailTaskDic valueForKey:@"task_vehical_name"]isEqualToString:@""])
    {
        self.VehicleNameTop.constant=0;
        self.VehicleNameTitle_LBL.text=@"";
        self.VehicleName_LBL.text=@"";
    }
    else
    {
        self.VehicleName_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_vehical_name"]];
    }
    
    // Vehicle Number
    if ([[DetailTaskDic valueForKey:@"task_vehicle_no"]isEqualToString:@""])
    {
        self.VehicleRegTop.constant=0;
        self.vehicleReg_LBL.text=@"";
        self.VehicleRegTitle_LBL.text=@"";
    }
    else
    {
        self.vehicleReg_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_vehicle_no"]];
    }
    
    // Stair
    if ([[DetailTaskDic valueForKey:@"inquiry_stairs"]isEqualToString:@"0"])
    {
        self.StairTop.constant=0;
        self.StairTitle_LBL.text=@"";
        self.Stair_LBL.text=@"";
    }
    else
    {
        self.Stair_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"inquiry_stairs"]];
    }
    
    // Add Helper
    NSArray *helpers_details=[DetailTaskDic valueForKey:@"helpers_details"];

    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    
    if (helpers_details.count>0)
    {
        int y = 6;
        for (int i=0; i<helpers_details.count; i++)
        {
            UILabel *HelperName=[[UILabel alloc]initWithFrame:CGRectMake(0, y, screenWidth/2, 15)];
            HelperName.text=[[helpers_details objectAtIndex:i] valueForKey:@"employee_name"];
            //HelperName.text=@"Kaushik";
            HelperName.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            HelperName.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
            HelperName.textAlignment=NSTextAlignmentCenter;
            [self.Scroll_Helper addSubview:HelperName];
            
            UILabel *HelperPhoneNo=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2, y, screenWidth/2, 15)];
            HelperPhoneNo.text=[[helpers_details objectAtIndex:i] valueForKey:@"employee_phone"];
            //HelperPhoneNo.text=@"23233223232";
            HelperPhoneNo.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            HelperPhoneNo.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f];
            HelperPhoneNo.textAlignment=NSTextAlignmentCenter;
            [self.Scroll_Helper addSubview:HelperPhoneNo];
            
            if (helpers_details.count-1!=i)
            {
                UILabel *LineLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, y+23, TherdView.frame.size.width, 0.5)];
                LineLBL.backgroundColor=[UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
                [self.Scroll_Helper addSubview:LineLBL];
                
            }
            y=y+30;
        }
        self.ScrollHight.constant=y-5;
    }
    
    // MinimumHour
    if ([[DetailTaskDic valueForKey:@"quotation_minimum_hour"]isEqualToString:@"0"])
    {
        self.MinHourTop.constant=0;
        self.MinimumTitle_LBL.text=@"";
        self.MinumulHours_LBL.text=@"";
    }
    else
    {
        self.MinumulHours_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"quotation_minimum_hour"]];
    }
    
    // ExtraItems
    NSString *Extraitem1=[DetailTaskDic valueForKey:@"quotation_extra_charge_title1"];
    NSString *Extraitem2=[DetailTaskDic valueForKey:@"quotation_extra_charge_title2"];
    NSString *Extraitem3=[DetailTaskDic valueForKey:@"quotation_extra_charge_title3"];
    
    NSString *MainStr=[[NSString alloc]init];
    
    if (![Extraitem1 isEqualToString:@""])
    {
        MainStr=[NSString stringWithFormat:@"%@",Extraitem1];
    }
    if (![Extraitem2 isEqualToString:@""])
    {
        if (![MainStr isEqualToString:@""])
        {
            MainStr=[NSString stringWithFormat:@", %@",Extraitem2];
        }
        else
        {
            MainStr=[NSString stringWithFormat:@"%@",Extraitem2];
        }
    }
    if (![Extraitem3 isEqualToString:@""])
    {
        if (![MainStr isEqualToString:@""])
        {
            MainStr=[NSString stringWithFormat:@", %@",Extraitem3];
        }
        else
        {
            MainStr=[NSString stringWithFormat:@"%@",Extraitem3];
        }
    }
    
    
    if ([MainStr isEqualToString:@""])
    {
        self.ExtraItemTop.constant=0;
        self.ExtraItemTitle_LBL.text=@"";
        self.ExtraItem_LBL.text=@"";
    }
    else
    {
        self.ExtraItem_LBL.text=[NSString stringWithFormat:@": %@",MainStr];
    }

    //self.Pianoamount_LBL.text=[DetailTaskDic valueForKey:@"task_start_date"];
    //self.PoolTableAmount_LBL.text=[DetailTaskDic valueForKey:@"task_start_date"];
    //self.addSurhargeTitle_LBL.text=[DetailTaskDic valueForKey:@"task_start_date"];
}

- (IBAction)StartTask_Action:(id)sender
{
    [self.view endEditing:YES];
    policyAlert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    policyAlert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    policyAlert.hidden=NO;
    [UIView animateWithDuration:0.2 animations:
     ^{
         policyAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
     }];

   /*
    TremNconditionVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TremNconditionVW"];
    vcr.Task_ID=[DetailTaskDic valueForKey:@"id"];
    vcr.vehical_id=[DetailTaskDic valueForKey:@"task_vehicle_id"];
    vcr.Task_NO1=[DetailTaskDic valueForKey:@"task_no"];
    [self.navigationController pushViewController:vcr animated:YES];*/
}
- (IBAction)SubmitPolicyBTN_Click:(id)sender
{
    policyAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView animateWithDuration:0.2 animations:^{
        policyAlert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            policyAlert.hidden=YES;
        }];
    }];
}
- (IBAction)CanclePolicy_Click:(id)sender
{
    
    policyAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView animateWithDuration:0.2 animations:^{
        policyAlert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            policyAlert.hidden=YES;
        }];
    }];
}
- (IBAction)backBtn_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
