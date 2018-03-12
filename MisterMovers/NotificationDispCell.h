//
//  NotificationDispCell.h
//  MisterMovers
//
//  Created by kaushik on 10/03/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationDispCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *NotifTitle_LBL;
@property (weak, nonatomic) IBOutlet UILabel *NotifDescription_LBL;
@property (weak, nonatomic) IBOutlet UIView *CellViewBG;

@end
