//
//  ExpenseView.m
//  MisterMovers
//
//  Created by kaushik on 11/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "ExpenseView.h"
#import "misterMover.pch"

@interface ExpenseView ()

@end

@implementation ExpenseView
@synthesize JobView,JobTXT,ExpenseTXT,RemarkTXT,RemarkView,ExpenseView,AmountTXT,AmountView,InfoView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [InfoView.layer setShadowColor:[UIColor blackColor].CGColor];
    [InfoView.layer setShadowOpacity:0.8];
    [InfoView.layer setShadowRadius:2.0];
    [InfoView.layer setShadowOffset:CGSizeMake(1.0,1.0)];
    
    [KmyappDelegate SettextfieldViewBorder:JobView];
    [KmyappDelegate SettextfieldViewBorder:ExpenseView];
    [KmyappDelegate SettextfieldViewBorder:RemarkView];
    [KmyappDelegate SettextfieldViewBorder:AmountView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)Back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
