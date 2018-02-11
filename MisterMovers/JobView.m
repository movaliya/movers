//
//  JobView.m
//  MisterMovers
//
//  Created by kaushik on 11/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "JobView.h"
#import "TodayJobCell.h"
#import "JobDetailView.h"

#define SelectedLabelColor [UIColor colorWithRed:255.0/255.0 green:175.0/255.0 blue:77.0/255.0 alpha:1.0]
#define Whitecolortitle [UIColor whiteColor]


@interface JobView ()

@end

@implementation JobView
@synthesize Today_BTN,Today_LBL,All_BTN,All_LBL,FilterBTN,MainTBL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    FilterBTN.hidden=YES;
    
    UINib *nib = [UINib nibWithNibName:@"TodayJobCell" bundle:nil];
    TodayJobCell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    MainTBL.rowHeight = cell.frame.size.height;
    [MainTBL registerNib:nib forCellReuseIdentifier:@"TodayJobCell"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)Back_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Tab_Click:(id)sender
{
    FilterBTN.hidden=YES;
    MainTBL.hidden=NO;
    if ([sender isEqual:Today_BTN])
    {
        Today_LBL.backgroundColor=SelectedLabelColor;
        [Today_BTN setTitleColor:SelectedLabelColor forState:UIControlStateNormal];
        
        All_LBL.backgroundColor=[UIColor clearColor];
        [All_BTN setTitleColor:Whitecolortitle forState:UIControlStateNormal];
    }
    else if ([sender isEqual:All_BTN])
    {
        FilterBTN.hidden=NO;
        MainTBL.hidden=YES;
        All_LBL.backgroundColor=SelectedLabelColor;
        [All_BTN setTitleColor:SelectedLabelColor forState:UIControlStateNormal];
        
        Today_LBL.backgroundColor=[UIColor clearColor];
        [Today_BTN setTitleColor:Whitecolortitle forState:UIControlStateNormal];
    }
}

- (IBAction)Filter_Click:(id)sender
{
    
}


#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"TodayJobCell";
    TodayJobCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobDetailView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"JobDetailView"];
    [self.navigationController pushViewController:vcr animated:YES];

}

@end
