//
//  TremNconditionVW.m
//  MisterMovers
//
//  Created by jignesh solanki on 20/02/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "TremNconditionVW.h"
#import "misterMover.pch"
#import "SignatureVW.h"

@interface TremNconditionVW ()

@end

@implementation TremNconditionVW

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)AgreeBtn_Click:(id)sender
{
    
    SignatureVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignatureVW"];
    [self.navigationController pushViewController:vcr animated:YES];

   
    /*
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self StartTask];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];*/
}



-(void)StartTask
{
   
    // Get current datetime
    NSDate *currentDateTime = [NSDate date];
    
    // Instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // Set the dateFormatter format
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    // Get the date time in NSString
    NSString *dateInString = [dateFormatter stringFromDate:currentDateTime];

    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Start_Task  forKey:@"s"];
    [dictParams setObject:self.vehical_id  forKey:@"vehical_id"];
    [dictParams setObject:self.Task_ID  forKey:@"tid"];
    [dictParams setObject:dateInString  forKey:@"start_date"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleStartTaskResponse:response];
     }];
}
- (void)handleStartTaskResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (IBAction)Cancel_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)backBtn_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
