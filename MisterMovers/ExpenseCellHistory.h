//
//  ExpenseCell.h
//  MisterMovers
//
//  Created by kaushik on 24/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseCellHistory : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UILabel *Jobtitle_LBL;
@property (weak, nonatomic) IBOutlet UILabel *ExpenseType_LBL;
@property (weak, nonatomic) IBOutlet UILabel *VehicleNo_LBL;
@property (weak, nonatomic) IBOutlet UILabel *VehicleName_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Amount_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Remark_LBL;

@property (strong, nonatomic) IBOutlet UILabel *VehicletNoTitle_LBL;
@property (strong, nonatomic) IBOutlet UILabel *VehicleNameTitle_LBL;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *AmountTop;
@end
