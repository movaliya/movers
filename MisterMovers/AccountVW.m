//
//  AccountVW.m
//  MisterMovers
//
//  Created by jignesh solanki on 21/04/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "AccountVW.h"
#import "misterMover.pch"


@interface AccountVW ()

@end

@implementation AccountVW

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetAccount];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
    
}
-(void)GetAccount
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"userid"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",AccountBaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleAccountResponse:response];
     }];
}

- (void)handleAccountResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"success"]stringValue ] isEqualToString:@"1"])
    {
        accountDict=[[response valueForKey:@"report"] mutableCopy];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackBtn_Click:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
