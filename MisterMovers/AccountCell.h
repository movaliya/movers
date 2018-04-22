//
//  AccountCell.h
//  MisterMovers
//
//  Created by kaushik on 22/04/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *SRNo_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Date_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Description_LBL;
@property (weak, nonatomic) IBOutlet UILabel *debitamount_LBL;
@property (weak, nonatomic) IBOutlet UILabel *CreditAmount_LBL;

@end
