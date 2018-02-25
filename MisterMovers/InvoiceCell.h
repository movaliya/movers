//
//  InvoiceCell.h
//  MisterMovers
//
//  Created by kaushik on 24/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CutomerName_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Date_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Payment_LBL;
@property (weak, nonatomic) IBOutlet UILabel *PaymentBy_LBL;

@property (strong, nonatomic) IBOutlet UIView *BackView;
@end
