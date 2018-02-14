//
//  TodayJobCell.h
//  MisterMovers
//
//  Created by kaushik on 11/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayJobCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *BakView;
@property (weak, nonatomic) IBOutlet UILabel *JobTitle_LBL;
@property (weak, nonatomic) IBOutlet UILabel *JobName_LBL;
@property (weak, nonatomic) IBOutlet UILabel *JobStartdate_LBL;
@property (weak, nonatomic) IBOutlet UILabel *jobEnddate_LBL;

@end
