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
- (IBAction)Back_click:(id)sender;
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
@end
