//
//  StartTaskDetailVW.m
//  MisterMovers
//
//  Created by jignesh solanki on 20/02/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "StartTaskDetailVW.h"
#import "misterMover.pch"
#import "PrivacyPolicyVW.h"
#import "SignatureVW.h"

@interface StartTaskDetailVW ()
{
    PrivacyPolicyVW *policyAlert;
    NSMutableArray *SurchargeTitleArr,*SurchargeArr;
    NSMutableDictionary *SurchargeDic;
    
}

@property (strong, nonatomic) UIButton *CanclepolicyBTN;
@property (strong, nonatomic) UIButton *SubmitpolicyBTN;

@end

@implementation StartTaskDetailVW
@synthesize FirstView,SecondView,TherdView,TherdViewBorder;
@synthesize StartBtn;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    SurchargeTitleArr=[[NSMutableArray alloc]init];
    SurchargeArr=[[NSMutableArray alloc]init];
    SurchargeDic=[[NSMutableDictionary alloc]init];
    
    policyAlert = [[PrivacyPolicyVW alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:policyAlert];
    policyAlert.hidden=YES;
    
    self.CanclepolicyBTN = (UIButton *)[policyAlert viewWithTag:200];
    [self.CanclepolicyBTN addTarget:self action:@selector(CanclePolicy_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    self.SubmitpolicyBTN = (UIButton *)[policyAlert viewWithTag:201];
    [self.SubmitpolicyBTN addTarget:self action:@selector(SubmitPolicyBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
    [self.SendView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.SendView.layer setShadowOpacity:0.8];
    [self.SendView.layer setShadowRadius:2.0];
    [self.SendView.layer setShadowOffset:CGSizeMake(1.0,1.0)];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}
-(void)TmpCountdown
{
    
    self.DurationHour_LBL.text=[NSString stringWithFormat:@": %@ Hours",KmyappDelegate.TimerValue];
}
-(void)appdegatValu
{
    [KmyappDelegate updateCountdown];
    self.DurationHour_LBL.text=[NSString stringWithFormat:@": %@ Hours",KmyappDelegate.TimerValue];
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
    self.RefreshBTN.hidden=YES;
    self.TaskTitle.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_title"]];
    self.preferredDate_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_start_date"]];
   
    
    if (![[DetailTaskDic valueForKey:@"task_ended_date"]isEqualToString:@""])
    {
        self.EndDate_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_ended_date"]];
    }
    else
    {
        self.EndDate_LBL.text= @": Not Yet Ended";
    }
    
    //Task Status setup button property
    Task_Status=[DetailTaskDic valueForKey:@"task_status"];
    if ([Task_Status isEqualToString:@"0"])
    {
        [self HideSendView];
        self.DurationHourTitle_LBL.text=@"";
        self.DurationHour_LBL.text=@"";
        self.DurationHourTop.constant=0;
        
        
        StartBtn.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:123.0/255.0 blue:48.0/255.0 alpha:1.0];
        [StartBtn setTitle:@"START" forState:UIControlStateNormal];


    }
    else if ([Task_Status isEqualToString:@"1"])
    {
        [self HideSendView];
        self.DurationHourTitle_LBL.text=@"Duration Hours";
        self.DurationHourTop.constant=10;
        StartBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
        [StartBtn setTitle:@"END" forState:UIControlStateNormal];
        
        if ( [KmyappDelegate.Mytimer isValid])
        {
            TMPTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(TmpCountdown) userInfo:nil repeats: YES];
        }
        else
        {
            KmyappDelegate.Mytimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(appdegatValu) userInfo:nil repeats: YES];
        }
    }
    else
    {
        [self ShowSendView];
        StartBtn.backgroundColor = [UIColor colorWithRed:63.0/255.0 green:82.0/255.0 blue:169.0/255.0 alpha:1.0];
        [StartBtn setTitle:@"SEND" forState:UIControlStateNormal];
    }
    
    
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
        self.PerHourRate_LBL.text=[NSString stringWithFormat:@": $ %@",[DetailTaskDic valueForKey:@"price_per_rate"]];
    }
    
    // Vehicle Name
    if ([DetailTaskDic valueForKey:@"task_vehical_name"] == (id)[NSNull null])
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
            UILabel *HelperName=[[UILabel alloc]initWithFrame:CGRectMake(2, y, screenWidth/2, 15)];
            HelperName.text=[[helpers_details objectAtIndex:i] valueForKey:@"employee_name"];
            //HelperName.text=@"Kaushik";
            HelperName.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            HelperName.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
            HelperName.textAlignment=NSTextAlignmentLeft;
            [self.Scroll_Helper addSubview:HelperName];
            

            UILabel *HelperPhoneNo=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2-5, y, screenWidth/2-20, 15)];
            HelperPhoneNo.text=[[helpers_details objectAtIndex:i] valueForKey:@"employee_phone"];
            //HelperPhoneNo.text=@"23233223232";
            HelperPhoneNo.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            HelperPhoneNo.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f];
            HelperPhoneNo.textAlignment=NSTextAlignmentRight;
            [self.Scroll_Helper addSubview:HelperPhoneNo];
            
            UILabel *DoteLBL=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2-15, y, 5, 18)];
            DoteLBL.text=@":";
            DoteLBL.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            DoteLBL.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f];
            DoteLBL.textAlignment=NSTextAlignmentRight;
            [self.Scroll_Helper addSubview:DoteLBL];
            
            
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
            MainStr=[NSString stringWithFormat:@"%@, %@",MainStr,Extraitem2];
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
            MainStr=[NSString stringWithFormat:@"%@, %@",MainStr,Extraitem3];
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
    
    if ([Task_Status isEqualToString:@"0"])
    {
       //START Action
        [self.view endEditing:YES];
        policyAlert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
        policyAlert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
        policyAlert.hidden=NO;
        [UIView animateWithDuration:0.2 animations:
         ^{
             policyAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
         }];
    }
    else if ([Task_Status isEqualToString:@"1"])
    {
        
        UIAlertController *Endalert = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure want to end job?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *No = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            // No Action
        }];
        UIAlertAction *Yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            // YES action
            BOOL internet=[AppDelegate connectedToNetwork];
            if (internet)
                [self ENDTask];
            else
                [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
        }];
        [Endalert addAction:No];
        [Endalert addAction:Yes];
        // Present action where needed
        [self presentViewController:Endalert animated:YES completion:nil];
    }
    else
    {
        //grandTotl
        
        NSString *Onlinetotal=self.OnlinePayment_TXT.text;
        NSString *cashtotal=self.CashPayment_TXT.text;
        NSInteger cashNonlineTotal=[Onlinetotal integerValue]+[cashtotal integerValue];
        NSString *grantTotalLBL=self.GrandTotalLBL.text;
        grantTotalLBL = [grantTotalLBL stringByReplacingOccurrencesOfString:@": $ " withString:@""];
        //SEND enble
        if([self.CashPayment_TXT.text isEqualToString:@""] && self.CashBTN.selected)
        {
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please enter cash payment." delegate:nil];
        }
        else if ([self.OnlinePayment_TXT.text isEqualToString:@""]&& self.OnlineBTN.selected)
        {
             [AppDelegate showErrorMessageWithTitle:@"" message:@"Please enter online payment." delegate:nil];
        }
        else if ([Onlinetotal integerValue]>[grantTotalLBL integerValue] && self.OnlineBTN.selected)
        {
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Online payment is greater then grand total." delegate:nil];
        }
        else if ([cashtotal integerValue]>[grantTotalLBL integerValue] && self.CashBTN.selected)
        {
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Cash payment is greater then grand total." delegate:nil];
        }
       
        else if (cashNonlineTotal>[grantTotalLBL integerValue])
        {
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Cash payment and Online payment is greater then grand total." delegate:nil];
        }
        else if (cashNonlineTotal<[grantTotalLBL integerValue])
        {
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Payment is lesser then grand total." delegate:nil];
        }
        else
        {
            BOOL internet=[AppDelegate connectedToNetwork];
            if (internet)
                [self SNDTask];
            else
                [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
        }
        
        
        
        
    }
   
}

- (IBAction)SubmitPolicyBTN_Click:(id)sender
{
    policyAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView animateWithDuration:0.2 animations:^{
        policyAlert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            policyAlert.hidden=YES;
            SignatureVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignatureVW"];
            vcr.Task_ID=[DetailTaskDic valueForKey:@"id"];
            vcr.vehical_id=[DetailTaskDic valueForKey:@"task_vehicle_id"];
            vcr.Task_No2=[DetailTaskDic valueForKey:@"task_no"];
            
            [self.navigationController pushViewController:vcr animated:YES];
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
-(void)ENDTask
{
    // Get current datetime
    NSDate *currentDateTime = [NSDate date];
    
    // Instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // Set the dateFormatter format
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    // Get the date time in NSString
    NSString *dateInString = [dateFormatter stringFromDate:currentDateTime];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:End_Task  forKey:@"s"];
    [dictParams setObject:[DetailTaskDic valueForKey:@"id"] forKey:@"tid"];
    [dictParams setObject:dateInString  forKey:@"end_date"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleEndTaskResponse:response];
     }];
}
- (void)handleEndTaskResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        if ( [KmyappDelegate.Mytimer isValid])
        {
             [KmyappDelegate.Mytimer invalidate], KmyappDelegate.Mytimer=nil;
        }
        if ( [TMPTimer isValid])
        {
            [TMPTimer invalidate], TMPTimer=nil;
        }
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
            [self GetDetailTask];
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
         [self ShowSendView];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
-(void)SNDTask
{
  
    StartBtn.backgroundColor = [UIColor colorWithRed:63.0/255.0 green:82.0/255.0 blue:169.0/255.0 alpha:1.0];
    [StartBtn setTitle:@"SEND" forState:UIControlStateNormal];
    
    NSMutableArray *task_items=[[NSMutableArray alloc]init];
    for (int k=0; k<SurchargeTitleArr.count; k++)
    {
        NSMutableDictionary *inddic=[[NSMutableDictionary alloc]init];
        [inddic setObject:[SurchargeTitleArr objectAtIndex:k] forKey:@"title"];
        [inddic setObject:[SurchargeArr objectAtIndex:k] forKey:@"amount"];
        [task_items addObject:inddic];
    }
    NSLog(@"task_items==%@",task_items);
    NSError* error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:task_items options:NSJSONWritingPrettyPrinted error:&error];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers  error:&error];
    
    
    
    
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    //task_items=[{"title":"task1","amount":"500"},{"title":"task2","amount":"600"}]
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Send_Task  forKey:@"s"];
    [dictParams setObject:[DetailTaskDic valueForKey:@"id"] forKey:@"tid"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    [dictParams setObject:@"cash"  forKey:@"payment_type"];
    [dictParams setObject:json  forKey:@"task_items"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleSendTaskResponse:response];
     }];
}
- (void)handleSendTaskResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        SignatureVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignatureVW"];
        vcr.Task_ID=[DetailTaskDic valueForKey:@"id"];
        vcr.Task_No2=[DetailTaskDic valueForKey:@"task_no"];
        if (self.CheckPopup!=nil)
        {
            vcr.CheckPopup1=self.CheckPopup;
        }
        
        [self.navigationController pushViewController:vcr animated:YES];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}


- (IBAction)backBtn_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if ( [TMPTimer isValid])
    {
        [TMPTimer invalidate], TMPTimer=nil;
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ( [TMPTimer isValid])
    {
        [TMPTimer invalidate], TMPTimer=nil;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Plush_Click:(id)sender
{
    if (![self.AddSurChargeTitle_TXT.text isEqualToString:@""] && ![self.AddSurChargeTXT.text isEqualToString:@""])
    {
        [SurchargeTitleArr addObject:self.AddSurChargeTitle_TXT.text];
        [SurchargeArr addObject:self.AddSurChargeTXT.text];
        
        self.AddSurChargeTitle_TXT.text=@"";
        self.AddSurChargeTXT.text=@"";
        
        [self SetSendScroll];
     
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:@"Please enter Charge." delegate:nil];
    }
}

-(void)HideSendView
{
     self.RefreshBTN.hidden=YES;
    self.SendView.hidden=YES;
    self.TotalTop.constant=0;
    self.Total_LBL.text=@"";
    self.TotalTitle_LBL.text=@"";
    self.totalDotLBL.text=@"";
    
    self.extraitemDotLBL.text=@"";
    self.durationhrDotLBL.text=@"";
    self.MinimumHorDotLBL.text=@"";
    
    self.Extra1Top.constant=0;
    self.ExtraTitle1_LBL.text=@"";
    self.Extra2Top.constant=0;
    self.ExtraTitle2_LBL.text=@"";
    self.Extra3Top.constant=0;
    self.ExtraTitle3_LBL.text=@"";
    self.Extra1Top.constant=0;
    self.ExtraTitle1_LBL.text=@"";
    
    self.AddSurchargeHight.constant=0.0f;
    self.SendCaseViewHight.constant=0.0f;
    self.SendViewTop.constant=0;
    self.StartBTNTop.constant=0;
}


-(void)ShowSendView
{
    
    self.RefreshBTN.hidden=NO;
    StartBtn.backgroundColor = [UIColor colorWithRed:63.0/255.0 green:82.0/255.0 blue:169.0/255.0 alpha:1.0];
    [StartBtn setTitle:@"SEND" forState:UIControlStateNormal];
    
    UIImage *btnImage1 = [UIImage imageNamed:@"check.png"];
    UIImage *selected = [UIImage imageNamed:@"uncheck.png"];
    
    [self.CashBTN setImage:btnImage1 forState:UIControlStateSelected];
    [self.CashBTN setImage:selected forState:UIControlStateNormal];
    self.CashBTN.selected=YES;
    [self.OnlineBTN setImage:btnImage1 forState:UIControlStateSelected];
    [self.OnlineBTN setImage:selected forState:UIControlStateNormal];
    self.OnlinePayment_TXT.hidden=YES;
    self.onlinepayLINE.hidden=YES;
    
    [self.CreditBTN setImage:btnImage1 forState:UIControlStateSelected];
    [self.CreditBTN setImage:selected forState:UIControlStateNormal];
    self.CreaditTXT.hidden=YES;
    self.CreditePayLINE.hidden=YES;
    
    self.SendView.hidden=NO;
    self.TotalTop.constant=10;
    self.TotalTitle_LBL.text=@"Total";
     self.totalDotLBL.text=@":";
     self.Total_LBL.text=[NSString stringWithFormat:@"$ %@",[DetailTaskDic valueForKey:@"quotation_total_hour_charge"]];
    
    // self.DurationHour_LBL.text=[NSString stringWithFormat:@"%@",[DetailTaskDic valueForKey:@"task_duration"]];
     self.DurationHour_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_actual_hour"]];
    
    NSString *Extraitem1=[DetailTaskDic valueForKey:@"quotation_extra_charge_title1"];
    NSString *Extraitem2=[DetailTaskDic valueForKey:@"quotation_extra_charge_title2"];
    NSString *Extraitem3=[DetailTaskDic valueForKey:@"quotation_extra_charge_title3"];
    ExtraitemTotal=0;
    //Extra Item
    if (![Extraitem1 isEqualToString:@""])
    {
        self.Extra1Top.constant=10;
        self.ExtraTitle1_LBL.text=Extraitem1;
         self.extraitemDotLBL.text=@":";
        self.Extra1_LBL.text=[NSString stringWithFormat:@"$ %@",[DetailTaskDic valueForKey:@"quotation_extra_charge1"]];
        ExtraitemTotal=ExtraitemTotal+[[DetailTaskDic valueForKey:@"quotation_extra_charge1"] integerValue];
    }
    else
    {
        self.extraitemDotLBL.text=@"";
        self.Extra1Top.constant=0;
        self.ExtraTitle1_LBL.text=@"";
    }
    if (![Extraitem2 isEqualToString:@""])
    {
        self.Extra2Top.constant=10;
        self.ExtraTitle2_LBL.text=Extraitem2;
        self.MinimumHorDotLBL.text=@":";

        self.Extra2_LBL.text=[NSString stringWithFormat:@"$ %@",[DetailTaskDic valueForKey:@"quotation_extra_charge2"]];
        ExtraitemTotal=ExtraitemTotal+[[DetailTaskDic valueForKey:@"quotation_extra_charge2"] integerValue];
    }
    else
    {
         self.MinimumHorDotLBL.text=@"";
        self.Extra2Top.constant=0;
        self.ExtraTitle2_LBL.text=@"";
    }
    if (![Extraitem3 isEqualToString:@""])
    {
        self.Extra3Top.constant=10;
        self.ExtraTitle3_LBL.text=Extraitem3;
        self.durationhrDotLBL.text=@":";
        self.Extra3_LBL.text=[NSString stringWithFormat:@"$ %@",[DetailTaskDic valueForKey:@"quotation_extra_charge3"]];
        ExtraitemTotal=ExtraitemTotal+[[DetailTaskDic valueForKey:@"quotation_extra_charge3"] integerValue];

    }
    else
    {
        self.durationhrDotLBL.text=@"";
        self.Extra3Top.constant=0;
        self.ExtraTitle3_LBL.text=@"";
    }
     ExtraitemTotal=ExtraitemTotal+[[DetailTaskDic valueForKey:@"quotation_total_hour_charge"] integerValue];
     grandTotl=tempExtraTotal+ExtraitemTotal;
    NSInteger discountint=[[DetailTaskDic valueForKey:@"task_discount"] integerValue];
    grandTotl=grandTotl-discountint;
    self.GrandTotalLBL.text=[NSString stringWithFormat:@"$ %ld",(long)grandTotl];
    self.DiscountLBL.text= [NSString stringWithFormat:@"$ %@",[DetailTaskDic valueForKey:@"task_discount"]];
   
    self.AddSurchargeHight.constant=35.0f;
    
    if ([[DetailTaskDic valueForKey:@"customer_credit_flag"] isEqualToString:@""])
    {
         self.SendCaseViewHight.constant=117.0f;
        self.CreaditTXT.hidden=YES;
        self.CreditePayLINE.hidden=YES;
        self.CreditBTN.hidden=YES;
         self.creditTitleLBL.hidden=YES;
        
    }
    else
    {
         self.SendCaseViewHight.constant=150.0f;
    }
   
    self.SendViewTop.constant=12;
    self.StartBTNTop.constant=15;
}



-(void)SetSendScroll
{
    
    NSArray* subviews = [[NSArray alloc] initWithArray: self.SendScroll.subviews];
    for (UIView* view in subviews)
    {
        if ([view isKindOfClass:[UIView class]])
        {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:[UIImageView class]])
        {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:[UIButton class]])
        {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:[UILabel class]])
        {
            [view removeFromSuperview];
        }
    }
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    tempExtraTotal=0;
    if (SurchargeArr.count>0)
    {
        int y = 6;
        for (int i=0; i<SurchargeArr.count; i++)
        {
            UILabel *HelperName=[[UILabel alloc]initWithFrame:CGRectMake(0, y, screenWidth/2, 18)];
            HelperName.text=[NSString stringWithFormat:@"%@",[SurchargeTitleArr objectAtIndex:i]];
            //HelperName.text=@"Kaushik";
            HelperName.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            HelperName.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
            HelperName.textAlignment=NSTextAlignmentLeft;
            [self.SendScroll addSubview:HelperName];
            
            UILabel *HelperPhoneNo=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2-30, y, screenWidth/2-20, 18)];
            HelperPhoneNo.text=[NSString stringWithFormat:@"$ %@",[SurchargeArr objectAtIndex:i]];
            //HelperPhoneNo.text=@"23233223232";
            
            tempExtraTotal=tempExtraTotal+[[SurchargeArr objectAtIndex:i] integerValue];
            HelperPhoneNo.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            HelperPhoneNo.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f];
            HelperPhoneNo.textAlignment=NSTextAlignmentRight;
            [self.SendScroll addSubview:HelperPhoneNo];

            UILabel *DoteLBL=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2-20, y, 5, 18)];
            DoteLBL.text=@":";
            DoteLBL.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            DoteLBL.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f];
            DoteLBL.textAlignment=NSTextAlignmentRight;
            [self.SendScroll addSubview:DoteLBL];

            
            UIButton *CloseBTN=[[UIButton alloc]initWithFrame:CGRectMake(screenWidth-42, y+2, 15, 15)];
            [CloseBTN setTitle:@"x" forState:UIControlStateNormal];
            CloseBTN.titleLabel.font=[UIFont boldSystemFontOfSize:18];
            [CloseBTN setTitleColor:[UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [CloseBTN addTarget:self action:@selector(Close_click:) forControlEvents:UIControlEventTouchUpInside];
            CloseBTN.tag=i;
            CloseBTN.layer.cornerRadius=7.5;
            CloseBTN.layer.masksToBounds=YES;
            CloseBTN.layer.borderColor=[[UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1.0f] CGColor];
            CloseBTN.layer.borderWidth=1.0f;
            [self.SendScroll addSubview:CloseBTN];
            
            
            y=y+30;
        }
       grandTotl=tempExtraTotal+ExtraitemTotal;
        NSInteger discountint=[[DetailTaskDic valueForKey:@"task_discount"] integerValue];
        grandTotl=grandTotl-discountint;
        self.GrandTotalLBL.text=[NSString stringWithFormat:@"$ %ld",(long)grandTotl];
        self.SendScrollHight.constant=y-5;
    }
}

-(void)Close_click:(id)Sender
{
    [SurchargeArr removeObjectAtIndex:[Sender tag]];
    [SurchargeTitleArr removeObjectAtIndex:[Sender tag]];
    
    [self SetSendScroll];
}
- (IBAction)CashBtn_Click:(id)sender
{
    if (self.CashBTN.selected)
    {
       
        self.CashPayment_TXT.hidden=YES;
        self.CashpayLINE.hidden=YES;
        self.CashPayment_TXT.text=@"";
    }
    else
    {
         self.CashPayment_TXT.hidden=NO;
        self.CashpayLINE.hidden=NO;
    }
    self.CashBTN.selected = !self.CashBTN.selected;
    
}
- (IBAction)OnlineBtn_click:(id)sender
{
    if (self.OnlineBTN.selected)
    {
        self.OnlinePayment_TXT.hidden=YES;
        self.onlinepayLINE.hidden=YES;
        self.OnlinePayment_TXT.text=@"";
    }
    else
    {
        self.OnlinePayment_TXT.hidden=NO;
        self.onlinepayLINE.hidden=NO;


    }
    self.OnlineBTN.selected = !self.OnlineBTN.selected;

}
- (IBAction)CreditBtn_Click:(id)sender
{
    if (self.CreditBTN.selected)
    {
        self.CreaditTXT.hidden=YES;
        self.CreditePayLINE.hidden=YES;
        self.CreaditTXT.text=@"";
    }
    else
    {
        self.CreaditTXT.hidden=NO;
        self.CreditePayLINE.hidden=NO;
    }
    self.CreditBTN.selected = !self.CreditBTN.selected;
}
- (IBAction)RefreshBtn_Click:(id)sender
{
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetDetailTask];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}


@end
