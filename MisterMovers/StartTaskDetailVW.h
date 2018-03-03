//
//  StartTaskDetailVW.h
//  MisterMovers
//
//  Created by jignesh solanki on 20/02/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartTaskDetailVW : UIViewController
{
    NSMutableDictionary *DetailTaskDic;
}

@property (weak, nonatomic) IBOutlet UILabel *TaskTitle;
@property (weak, nonatomic) IBOutlet UILabel *JobNo_LBL;
@property (weak, nonatomic) IBOutlet UILabel *JobTitle_LBL;

@property (strong, nonatomic) NSString *Task_ID;
@property (strong, nonatomic) NSString *Task_NO;

@property (strong, nonatomic) IBOutlet UIView *FirstView;
@property (strong, nonatomic) IBOutlet UIView *SecondView;
@property (strong, nonatomic) IBOutlet UIView *TherdView;
@property (strong, nonatomic) IBOutlet UIView *TherdViewBorder;

@property (weak, nonatomic) IBOutlet UILabel *preferredDate_LBL;
@property (weak, nonatomic) IBOutlet UILabel *EndDate_LBL;
@property (weak, nonatomic) IBOutlet UILabel *pickupAdreess_LBL;
@property (weak, nonatomic) IBOutlet UILabel *DropAddress_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Address1_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Address2_LBL;
@property (weak, nonatomic) IBOutlet UILabel *CutomerName_LBL;
@property (weak, nonatomic) IBOutlet UILabel *CustomerNumber_LBL;
@property (weak, nonatomic) IBOutlet UILabel *CustomerEmail_LBL;
@property (weak, nonatomic) IBOutlet UILabel *PerHourRate_LBL;
@property (weak, nonatomic) IBOutlet UILabel *HelperNumber_LBL;
@property (weak, nonatomic) IBOutlet UILabel *HelperName_LBL;

@property (weak, nonatomic) IBOutlet UILabel *MinumulHours_LBL;

@property (weak, nonatomic) IBOutlet UILabel *vehicleReg_LBL;
@property (strong, nonatomic) IBOutlet UILabel *VehicleName_LBL;
@property (strong, nonatomic) IBOutlet UILabel *Stair_LBL;
@property (strong, nonatomic) IBOutlet UIScrollView *Scroll_Helper;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ScrollHight;


@property (strong, nonatomic) IBOutlet UILabel *PickupAddressTitle_LBL;
@property (strong, nonatomic) IBOutlet UILabel *DropAddressTitle_LBL;
@property (strong, nonatomic) IBOutlet UILabel *Address1Title_LBL;
@property (strong, nonatomic) IBOutlet UILabel *Address2Title_LBL;
@property (strong, nonatomic) IBOutlet UILabel *CustomerNmTitle_LBL;
@property (strong, nonatomic) IBOutlet UILabel *CustomerNumberTitle_LBL;
@property (strong, nonatomic) IBOutlet UILabel *CustomerEmailTitle_LBL;
@property (strong, nonatomic) IBOutlet UILabel *PerHourTitle_LBL;

@property (strong, nonatomic) IBOutlet UILabel *VehicleRegTitle_LBL;
@property (strong, nonatomic) IBOutlet UILabel *VehicleNameTitle_LBL;
@property (strong, nonatomic) IBOutlet UILabel *StairTitle_LBL;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *VehicleRegTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *VehicleNameTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *StairTop;

@property (strong, nonatomic) IBOutlet UILabel *MinimumTitle_LBL;
@property (strong, nonatomic) IBOutlet UILabel *ExtraItemTitle_LBL;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *MinHourTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ExtraItemTop;
@property (strong, nonatomic) IBOutlet UILabel *ExtraItem_LBL;




@property (strong, nonatomic) IBOutlet NSLayoutConstraint *PickupAddressTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *DropAddressTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *address1Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *address2Top;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *CustomerNameTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *CustomerNumberTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *CustomerEmailTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *PerHourRateTop;


@end
