//
//  InvoiceView.m
//  MisterMovers
//
//  Created by kaushik on 24/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "InvoiceView.h"
#import "misterMover.pch"
#import "InvoiceCell.h"

@interface InvoiceView ()

@end

@implementation InvoiceView
@synthesize InvoiceTBL,NoInvoiceBTN;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NoInvoiceBTN.hidden=YES;
    
    UINib *nib = [UINib nibWithNibName:@"InvoiceCell" bundle:nil];
    InvoiceCell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    InvoiceTBL.rowHeight = cell.frame.size.height;
    [InvoiceTBL registerNib:nib forCellReuseIdentifier:@"InvoiceCell"];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetInvoice];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}
-(void)GetInvoice
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Get_Invoice  forKey:@"s"];
    
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
   // [dictParams setObject:@"2"  forKey:@"eid"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleInvoiceResponse:response];
     }];
}
- (void)handleInvoiceResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        Get_InvoiceDic=[[response valueForKey:@"result"] mutableCopy];
        [InvoiceTBL reloadData];
    }
    else
    {
        Get_InvoiceDic=[[NSMutableDictionary alloc]init];
        [InvoiceTBL reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return Get_InvoiceDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"InvoiceCell";
    InvoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    NSString *fullName=[NSString stringWithFormat:@"%@ %@",[[Get_InvoiceDic valueForKey:@"first_name"] objectAtIndex:indexPath.section],[[Get_InvoiceDic valueForKey:@"last_name"] objectAtIndex:indexPath.section]];
    
    cell.CutomerName_LBL.text=[NSString stringWithFormat:@": %@",fullName];
    
    cell.Date_LBL.text=[NSString stringWithFormat:@": %@",[[Get_InvoiceDic valueForKey:@"invoice_date"] objectAtIndex:indexPath.section]];
    
    cell.Payment_LBL.text=[NSString stringWithFormat:@": $ %@",[[Get_InvoiceDic valueForKey:@"grand_total"] objectAtIndex:indexPath.section]];
    
    cell.PaymentBy_LBL.text= [NSString stringWithFormat:@": %@",[[Get_InvoiceDic valueForKey:@"payment_type"] objectAtIndex:indexPath.section]];
    
    cell.backgroundColor=[UIColor clearColor];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
- (IBAction)Back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
