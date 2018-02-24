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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
