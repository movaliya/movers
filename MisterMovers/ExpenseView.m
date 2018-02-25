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
{
    NSMutableArray *JobArr,*ExpenseArr,*FeaulPaymentArr,*HelperArr;
    NSString *SelectedTextfield;
}
@end

@implementation ExpenseView
@synthesize JobView,JobTXT,ExpenseTXT,RemarkTXT,RemarkView,ExpenseView,AmountTXT,AmountView,InfoView;
@synthesize SelectJobTBL,JobTableTop;
@synthesize OtherView,OtherAmount_TXT,OtherRemark_TXT;
@synthesize FealView,FealAmoutTop,FeaulUploadinvoise_BTN,ScrollHight,FeaulPaymentType_TXT;
@synthesize Helper_TXT,HelperView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    SelectedTextfield=@"OTHER";
    
    JobArr=[[NSMutableArray alloc] initWithObjects:@"John",@"Marko",@"Fabio", nil];
    HelperArr=[[NSMutableArray alloc] initWithObjects:@"Lisa",@"Jaini",@"Laura", nil];
    ExpenseArr=[[NSMutableArray alloc] initWithObjects:@"Fuel and oil",@"Helper",@"Other", nil];
    FeaulPaymentArr=[[NSMutableArray alloc] initWithObjects:@"Please select payment type",@"Cash",@"Card", nil];
    SelectJobTBL.layer.cornerRadius=3.0f;
    SelectJobTBL.layer.borderColor=[[UIColor blueColor] CGColor];
    SelectJobTBL.layer.borderWidth=1.0f;
    SelectJobTBL.hidden=YES;
    
    FealView.hidden=YES;
    HelperView.hidden=YES;
    ScrollHight.constant=490.0f;
    
    
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    SelectJobTBL.hidden=YES;
    if (textField==JobTXT)
    {
        SelectedTextfield=@"OTHER";
        JobTableTop.constant=0.0f;
        SelectJobTBL.hidden=NO;
        [SelectJobTBL reloadData];
        return NO;
    }
    if (textField==ExpenseTXT)
    {
        SelectedTextfield=@"EXPENSE";
        SelectJobTBL.hidden=NO;
        JobTableTop.constant=89.0f;
        [SelectJobTBL reloadData];
        return NO;
    }
    if (textField==FeaulPaymentType_TXT)
    {
        SelectedTextfield=@"FeaulPaymentType";
        SelectJobTBL.hidden=NO;
        JobTableTop.constant=265.0f;
        [SelectJobTBL reloadData];
        return NO;
    }
    if (textField==Helper_TXT)
    {
        SelectedTextfield=@"HELPER";
        SelectJobTBL.hidden=NO;
        JobTableTop.constant=175.0f;
        [SelectJobTBL reloadData];
        return NO;
    }
    return YES;
}

#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==SelectJobTBL)
    {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==SelectJobTBL)
    {
        if ([SelectedTextfield isEqualToString:@"OTHER"])
        {
            return JobArr.count;
        }
        else if ([SelectedTextfield isEqualToString:@"EXPENSE"])
        {
            return ExpenseArr.count;
        }
        else if ([SelectedTextfield isEqualToString:@"HELPER"])
        {
            return HelperArr.count;
        }
        else
        {
            return FeaulPaymentArr.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==SelectJobTBL)
    {
        static NSString *CellIdentifier1 = @"Cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        cell=nil;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.accessoryView = nil;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if ([SelectedTextfield isEqualToString:@"OTHER"])
        {
            cell.textLabel.text=[JobArr objectAtIndex:indexPath.row];
        }
        else if ([SelectedTextfield isEqualToString:@"EXPENSE"])
        {
            cell.textLabel.text=[ExpenseArr objectAtIndex:indexPath.row];
        }
        else if ([SelectedTextfield isEqualToString:@"HELPER"])
        {
            cell.textLabel.text=[HelperArr objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text=[FeaulPaymentArr objectAtIndex:indexPath.row];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectJobTBL.hidden=YES;
    if (tableView==SelectJobTBL)
    {
        if ([SelectedTextfield isEqualToString:@"OTHER"])
        {
            JobTXT.text=[JobArr objectAtIndex:indexPath.row];
            
        }
        else if ([SelectedTextfield isEqualToString:@"FeaulPaymentType"])
        {
            FeaulPaymentType_TXT.text=[FeaulPaymentArr objectAtIndex:indexPath.row];

            HelperView.hidden=YES;
            OtherView.hidden=YES;
            FealView.hidden=NO;
            
            if ([FeaulPaymentType_TXT.text isEqualToString:@"Cash"])
            {
                FeaulUploadinvoise_BTN.hidden=NO;
                FealAmoutTop.constant=70;
                ScrollHight.constant=720.0f;
            }
            else
            {
                FeaulUploadinvoise_BTN.hidden=YES;
                FealAmoutTop.constant=10;
                ScrollHight.constant=670.0f;
            }
        }
        else if ([SelectedTextfield isEqualToString:@"HELPER"])
        {
            Helper_TXT.text=[HelperArr objectAtIndex:indexPath.row];
        }
        else
        {
        
            ExpenseTXT.text=[ExpenseArr objectAtIndex:indexPath.row];
            if ([ExpenseTXT.text isEqualToString:@"Fuel and oil"])
            {
                HelperView.hidden=YES;
                OtherView.hidden=YES;
                FealView.hidden=NO;
                FeaulUploadinvoise_BTN.hidden=YES;
                FealAmoutTop.constant=10;
                ScrollHight.constant=680.0f;
            }
            else if ([ExpenseTXT.text isEqualToString:@"Helper"])
            {
                OtherView.hidden=YES;
                FealView.hidden=YES;
                HelperView.hidden=NO;
                
                ScrollHight.constant=570.0f;
            }
            else if ([ExpenseTXT.text isEqualToString:@"Other"])
            {
                HelperView.hidden=YES;
                OtherView.hidden=NO;
                FealView.hidden=YES;
                ScrollHight.constant=490.0f;
            }
        }
    }
}


@end
