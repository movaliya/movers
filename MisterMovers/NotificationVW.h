//
//  NotificationVW.h
//  digitalmarketing
//
//  Created by Mango SW on 15/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationVW : UIViewController
{
    NSMutableDictionary *NotificationDic;
}
@property (strong, nonatomic) IBOutlet UITableView *NotifTBL;
@property (weak, nonatomic) IBOutlet UILabel *NoNotification_LBL;

@end
