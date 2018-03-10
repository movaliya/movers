//
//  NotificationVW.m
//  digitalmarketing
//
//  Created by Mango SW on 15/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "NotificationVW.h"
#import "Notification_Cell.h"
#import "misterMover.pch"
#import "NotificationDispCell.h"

@interface NotificationVW ()

@end

@implementation NotificationVW
@synthesize NotifTBL;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UINib *nib = [UINib nibWithNibName:@"NotificationDispCell" bundle:nil];
    NotificationDispCell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    NotifTBL.rowHeight = cell.frame.size.height;
    [NotifTBL registerNib:nib forCellReuseIdentifier:@"NotificationDispCell"];
    
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetNotificationTask];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
   
}
-(void)GetNotificationTask
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
   
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleNotificationTaskResponse:response];
     }];
}

- (void)handleNotificationTaskResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        //NoJobsFound_LBL.hidden=YES;
        NotificationDic=[[response valueForKey:@"result"] mutableCopy];
        //[MainTBL reloadData];
    }
    else
    {
       // NoJobsFound_LBL.hidden=NO;
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)Back_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
