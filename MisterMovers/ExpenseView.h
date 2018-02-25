//
//  ExpenseView.h
//  MisterMovers
//
//  Created by kaushik on 11/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"

@interface ExpenseView : UIViewController
{
    
}
- (IBAction)Back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *InfoView;

@property (strong, nonatomic) IBOutlet UIView *JobView;
@property (strong, nonatomic) IBOutlet UITextField *JobTXT;
@property (strong, nonatomic) IBOutlet UIView *ExpenseView;
@property (strong, nonatomic) IBOutlet UITextField *ExpenseTXT;
@property (strong, nonatomic) IBOutlet UIView *AmountView;
@property (strong, nonatomic) IBOutlet UITextField *AmountTXT;
@property (strong, nonatomic) IBOutlet UIView *RemarkView;
@property (strong, nonatomic) IBOutlet IQTextView *RemarkTXT;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ScrollHight;

@property (strong, nonatomic) IBOutlet UITableView *SelectJobTBL;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *JobTableTop;

@property (strong, nonatomic) IBOutlet UIView *OtherView;
@property (strong, nonatomic) IBOutlet UITextField *OtherAmount_TXT;
@property (strong, nonatomic) IBOutlet IQTextView *OtherRemark_TXT;
@property (strong, nonatomic) IBOutlet UIView *FealView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *FealAmoutTop;
@property (strong, nonatomic) IBOutlet UIButton *FeaulUploadinvoise_BTN;
@property (strong, nonatomic) IBOutlet UITextField *FeaulPaymentType_TXT;

@property (strong, nonatomic) IBOutlet UIView *HelperView;
@property (strong, nonatomic) IBOutlet UITextField *Helper_TXT;


@end
