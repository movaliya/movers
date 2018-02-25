//
//  InvoiceView.h
//  MisterMovers
//
//  Created by kaushik on 24/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceView : UIViewController
{
    NSMutableDictionary *Get_InvoiceDic;
}

@property (strong, nonatomic) IBOutlet UITableView *InvoiceTBL;
- (IBAction)Back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *NoInvoiceBTN;
@end
