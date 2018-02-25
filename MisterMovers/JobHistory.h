//
//  JobHistory.h
//  MisterMovers
//
//  Created by kaushik on 24/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobHistory : UIViewController
{
    NSMutableDictionary *JobHrtyDic;
}

- (IBAction)Back_Click:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *HistoryTBL;
@property (strong, nonatomic) IBOutlet UIButton *NoJobHistoryBTN;
@end
