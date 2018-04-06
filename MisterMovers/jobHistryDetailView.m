//
//  jobHistryDetailView.m
//  MisterMovers
//
//  Created by kaushik on 10/03/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "jobHistryDetailView.h"
#import "misterMover.pch"

@interface jobHistryDetailView ()

@end
@implementation jobHistryDetailView
@synthesize FirstView,SecondView,TherdView,TherdViewBorder;

- (void)viewDidLoad
{
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
    self.DurationHour_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_actual_hour"]];
    
    if (![[DetailTaskDic valueForKey:@"task_ended_date"]isEqualToString:@""])
    {
        self.EndDate_LBL.text=[NSString stringWithFormat:@": %@",[DetailTaskDic valueForKey:@"task_ended_date"]];
    }
    else
    {
        self.EndDate_LBL.text= @": Not Yet Ended";
    }
    
    //Task Status setup button property
    
    
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
            UILabel *HelperName=[[UILabel alloc]initWithFrame:CGRectMake(0, y, screenWidth/2, 18)];
            HelperName.text=[[helpers_details objectAtIndex:i] valueForKey:@"employee_name"];
            //HelperName.text=@"Kaushik";
            HelperName.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            HelperName.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
            HelperName.textAlignment=NSTextAlignmentCenter;
            [self.Scroll_Helper addSubview:HelperName];
            
            UILabel *DoteLBL=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2-15, y, 5, 18)];
            DoteLBL.text=@":";
            DoteLBL.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            DoteLBL.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f];
            DoteLBL.textAlignment=NSTextAlignmentRight;
            [self.Scroll_Helper addSubview:DoteLBL];
            
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
    
    
    //Helper Extra Hours
    if (helpers_details.count>0)
    {
        int y = 6;
        for (int i=0; i<helpers_details.count; i++)
        {
            UILabel *HelperName=[[UILabel alloc]initWithFrame:CGRectMake(0, y, screenWidth/2, 18)];
            HelperName.text=[[helpers_details objectAtIndex:i] valueForKey:@"employee_name"];
            //HelperName.text=@"Kaushik";
            HelperName.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            HelperName.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
            HelperName.textAlignment=NSTextAlignmentCenter;
            [self.HelperHoursScroll addSubview:HelperName];
            
            UILabel *DoteLBL=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2-15, y, 5, 18)];
            DoteLBL.text=@":";
            DoteLBL.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            DoteLBL.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f];
            DoteLBL.textAlignment=NSTextAlignmentRight;
            [self.HelperHoursScroll addSubview:DoteLBL];
            
            UILabel *HelperPhoneNo=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2, y, screenWidth/2, 18)];
            HelperPhoneNo.text=[[helpers_details objectAtIndex:i] valueForKey:@"extra_hour"];
            //HelperPhoneNo.text=@"23233223232";
            HelperPhoneNo.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
            HelperPhoneNo.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f];
            HelperPhoneNo.textAlignment=NSTextAlignmentCenter;
            [self.HelperHoursScroll addSubview:HelperPhoneNo];
            
            if (helpers_details.count-1!=i)
            {
                UILabel *LineLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, y+23, TherdView.frame.size.width, 0.5)];
                LineLBL.backgroundColor=[UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
                [self.HelperHoursScroll addSubview:LineLBL];
                
            }
            y=y+30;
        }
        self.HelperHoursScrollHight.constant=y-5;
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
    
    NSString *Urlstr=[DetailTaskDic valueForKey:@"task_start_signature"];
    [self.StartSignatureIMG sd_setImageWithURL:[NSURL URLWithString:Urlstr] placeholderImage:[UIImage imageNamed:@"placeholder_img"]];
    [self.StartSignatureIMG setShowActivityIndicatorView:YES];
    
    NSString *Urlstr1=[DetailTaskDic valueForKey:@"task_signature"];
    [self.EndSignatureIMG sd_setImageWithURL:[NSURL URLWithString:Urlstr1] placeholderImage:[UIImage imageNamed:@"placeholder_img"]];
    [self.EndSignatureIMG setShowActivityIndicatorView:YES];
    
    [self ShowSendView];
}
-(void)ShowSendView
{
    self.SendView.hidden=NO;
    self.TotalTop.constant=10;
    self.TotalTitle_LBL.text=@"Total";
    self.Total_LBL.text=[NSString stringWithFormat:@": $ %@",[DetailTaskDic valueForKey:@"quotation_total_hour_charge"]];
    
    NSString *Extraitem1=[DetailTaskDic valueForKey:@"quotation_extra_charge_title1"];
    NSString *Extraitem2=[DetailTaskDic valueForKey:@"quotation_extra_charge_title2"];
    NSString *Extraitem3=[DetailTaskDic valueForKey:@"quotation_extra_charge_title3"];
    ExtraitemTotal=0;
    //Extra Item
    if (![Extraitem1 isEqualToString:@""])
    {
        self.Extra1Top.constant=10;
        self.ExtraTitle1_LBL.text=Extraitem1;
        self.Extra1_LBL.text=[NSString stringWithFormat:@": $ %@",[DetailTaskDic valueForKey:@"quotation_extra_charge1"]];
        ExtraitemTotal=ExtraitemTotal+[[DetailTaskDic valueForKey:@"quotation_extra_charge1"] integerValue];
    }
    else
    {
        self.Extra1Top.constant=0;
        self.ExtraTitle1_LBL.text=@"";
    }
    if (![Extraitem2 isEqualToString:@""])
    {
        self.Extra2Top.constant=10;
        self.ExtraTitle2_LBL.text=Extraitem2;
        self.Extra2_LBL.text=[NSString stringWithFormat:@": $ %@",[DetailTaskDic valueForKey:@"quotation_extra_charge2"]];
        ExtraitemTotal=ExtraitemTotal+[[DetailTaskDic valueForKey:@"quotation_extra_charge2"] integerValue];
    }
    else
    {
        self.Extra2Top.constant=0;
        self.ExtraTitle2_LBL.text=@"";
    }
    if (![Extraitem3 isEqualToString:@""])
    {
        self.Extra3Top.constant=10;
        self.ExtraTitle3_LBL.text=Extraitem3;
        self.Extra3_LBL.text=[NSString stringWithFormat:@": $ %@",[DetailTaskDic valueForKey:@"quotation_extra_charge3"]];
        ExtraitemTotal=ExtraitemTotal+[[DetailTaskDic valueForKey:@"quotation_extra_charge3"] integerValue];
        
    }
    else
    {
        self.Extra3Top.constant=0;
        self.ExtraTitle3_LBL.text=@"";
    }
    ExtraitemTotal=ExtraitemTotal+[[DetailTaskDic valueForKey:@"quotation_total_hour_charge"] integerValue];
    
    self.GrandTotalLBL.text=[NSString stringWithFormat:@": $ %ld",(long)ExtraitemTotal];
    self.SendViewTop.constant=12;
    [self SetDriverScroll];
    [self SetPhotoimageScroll];
    
}

-(void)SetDriverScroll
{
    
    NSArray* subviews = [[NSArray alloc] initWithArray: self.DriverScrollVw.subviews];
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
    int y = 6;
    for (int i=0; i<1; i++)
    {
        UILabel *HelperName=[[UILabel alloc]initWithFrame:CGRectMake(0, y, screenWidth/2, 18)];
        HelperName.text=[NSString stringWithFormat:@"%@",[DetailTaskDic valueForKey:@"task_leader_name"]];
        //HelperName.text=@"Kaushik";
        HelperName.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
        HelperName.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
        HelperName.textAlignment=NSTextAlignmentCenter;
        [self.DriverScrollVw addSubview:HelperName];
        
        UILabel *DoteLBL=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2-15, y, 5, 18)];
        DoteLBL.text=@":";
        DoteLBL.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
        DoteLBL.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f];
        DoteLBL.textAlignment=NSTextAlignmentRight;
        [self.DriverScrollVw addSubview:DoteLBL];
        
        UILabel *HelperPhoneNo=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2, y, screenWidth/2-5, 18)];
        HelperPhoneNo.text=[NSString stringWithFormat:@" %@",[DetailTaskDic valueForKey:@"task_extra_hour"]];
        //HelperPhoneNo.text=@"23233223232";
        
        HelperPhoneNo.textColor=[UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
        HelperPhoneNo.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f];
        HelperPhoneNo.textAlignment=NSTextAlignmentCenter;
        [self.DriverScrollVw addSubview:HelperPhoneNo];
        
        
        UILabel *LineLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, y+25, TherdView.frame.size.width, 0.5)];
        LineLBL.backgroundColor=[UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
        [self.DriverScrollVw addSubview:LineLBL];
        
        
        y=y+30;
    }
    // grandTotl=tempExtraTotal+ExtraitemTotal;
    //self.GrandTotalLBL.text=[NSString stringWithFormat:@": $ %ld",(long)grandTotl];
    self.DriverScroll_Hieght.constant=y-5;
    
    
}
-(void)SetPhotoimageScroll
{
    
    NSArray *task_images=[DetailTaskDic valueForKey:@"task_images"];
    
    NSArray* subviews = [[NSArray alloc] initWithArray: self.JobPhotoScrollVW.subviews];
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
    
    if (IS_IPHONE_6)
    {
        int x = 20,y=15;
        for (int i=0; i<task_images.count; i++)
        {
            NSString *Urlstr=[[task_images valueForKey:@"image_path"]objectAtIndex:i];
           
            
            if (x<300)
            {
                UIImageView *BTN=[[UIImageView alloc]initWithFrame:CGRectMake(x,  y, 160, 160)];
                [BTN sd_setImageWithURL:[NSURL URLWithString:Urlstr] placeholderImage:[UIImage imageNamed:@"placeholder_img"]];
                [BTN setShowActivityIndicatorView:YES];
                [self.JobPhotoScrollVW addSubview:BTN];
                
                
                x=x+175;
            }
            else
            {
                y=y+175;
                x=20;
                UIImageView *BTN=[[UIImageView alloc]initWithFrame:CGRectMake(x,  y, 160, 160)];
                [BTN sd_setImageWithURL:[NSURL URLWithString:Urlstr] placeholderImage:[UIImage imageNamed:@"placeholder_img"]];
                [BTN setShowActivityIndicatorView:YES];
                [self.JobPhotoScrollVW addSubview:BTN];
                x=x+175;
            }
        }
        
        y=y+220;
        
        [self.JobPhotoScrollVW setContentSize:CGSizeMake(SCREEN_WIDTH, y+20)];
        self.JobPhotoScroll_Height.constant=y;
    }
    else if (isIPhone5)
    {
        int x = 10,y=10;
        for (int i=0; i<task_images.count; i++)
        {
            NSString *Urlstr=[[task_images valueForKey:@"image_path"]objectAtIndex:i];
            if (x<250)
            {
                UIImageView *BTN=[[UIImageView alloc]initWithFrame:CGRectMake(x,  y, 160, 160)];
                [BTN sd_setImageWithURL:[NSURL URLWithString:Urlstr] placeholderImage:[UIImage imageNamed:@"placeholder_img"]];
                [BTN setShowActivityIndicatorView:YES];
                [self.JobPhotoScrollVW addSubview:BTN];
                x=x+155;
            }
            else
            {
                y=y+155;
                x=10;
                UIImageView *BTN=[[UIImageView alloc]initWithFrame:CGRectMake(x,  y, 160, 160)];
                [BTN sd_setImageWithURL:[NSURL URLWithString:Urlstr] placeholderImage:[UIImage imageNamed:@"placeholder_img"]];
                [BTN setShowActivityIndicatorView:YES];
                [self.JobPhotoScrollVW addSubview:BTN];
                x=x+155;
            }
        }
        
        y=y+190;
        
        [self.JobPhotoScrollVW setContentSize:CGSizeMake(SCREEN_WIDTH, y+20)];
        self.JobPhotoScroll_Height.constant=y;
    }
    else if (IS_IPHONE_6P)
    {
        
        int x = 15,y=10;
        for (int i=0; i<task_images.count; i++)
        {
            NSString *Urlstr=[[task_images valueForKey:@"image_path"]objectAtIndex:i];
            if (x<400)
            {
                UIImageView *BTN=[[UIImageView alloc]initWithFrame:CGRectMake(x,  y, 160, 160)];
                [BTN sd_setImageWithURL:[NSURL URLWithString:Urlstr] placeholderImage:[UIImage imageNamed:@"placeholder_img"]];
                [BTN setShowActivityIndicatorView:YES];
                [self.JobPhotoScrollVW addSubview:BTN];
                
                x=x+200;
            }
            else
            {
                y=y+200;
                x=15;
                UIImageView *BTN=[[UIImageView alloc]initWithFrame:CGRectMake(x,  y, 160, 160)];
                [BTN sd_setImageWithURL:[NSURL URLWithString:Urlstr] placeholderImage:[UIImage imageNamed:@"placeholder_img"]];
                [BTN setShowActivityIndicatorView:YES];
                [self.JobPhotoScrollVW addSubview:BTN];
                x=x+200;
            }
        }
        
        y=y+240;
        [self.JobPhotoScrollVW setContentSize:CGSizeMake(SCREEN_WIDTH, y+20)];
        self.JobPhotoScroll_Height.constant=y;
    }
}
- (IBAction)backBtn_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
