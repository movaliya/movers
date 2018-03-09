//
//  RunningJobVW.h
//  MisterMovers
//
//  Created by jignesh solanki on 09/03/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunningJobVW : UIViewController
{
    NSMutableDictionary *runningJobDic;
}
@property (weak, nonatomic) IBOutlet UITableView *RunningJobTable;
@property (weak, nonatomic) IBOutlet UIButton *noDataButton;

@end
