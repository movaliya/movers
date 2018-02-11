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
@end
