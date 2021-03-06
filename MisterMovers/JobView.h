//
//  JobView.h
//  MisterMovers
//
//  Created by kaushik on 11/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobView : UIViewController
{
    NSMutableDictionary *TodayTaskDic;
    NSString *buttonTabTitle;
}
- (IBAction)Back_Click:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *Today_LBL;
@property (strong, nonatomic) IBOutlet UILabel *All_LBL;
@property (strong, nonatomic) IBOutlet UIButton *Today_BTN;
@property (strong, nonatomic) IBOutlet UIButton *All_BTN;
@property (weak, nonatomic) IBOutlet UILabel *NoJobsFound_LBL;
- (IBAction)Tab_Click:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *FilterBTN;
- (IBAction)Filter_Click:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *MainTBL;

@end
