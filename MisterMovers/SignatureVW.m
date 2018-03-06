//
//  SignatureVW.m
//  MisterMovers
//
//  Created by jignesh solanki on 20/02/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "SignatureVW.h"
#import <PhotosUI/PhotosUI.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "misterMover.pch"
#import "AFHTTPSessionManager.h"
#import "HomeVW.h"


@interface SignatureVW ()

@end

@implementation SignatureVW

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.vehical_id==nil)
    {
        self.customerSignatureTitle.text=@"Customer Signature End";
    }
    else
    {
         self.customerSignatureTitle.text=@"Customer Signature Start";
    }
    self.TaskTitle_LBL.text=self.Task_No2;
    self.StartBtn.enabled=NO;
    self.StartBtn.alpha=0.5f;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // get touch event
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(self.signatureView.frame, touchLocation)) {
        //Your logic
        NSLog(@"touched");
        self.StartBtn.enabled=YES;
        self.StartBtn.alpha=1.0f;

    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventTypeTouches)
    {
        // your code
    }
}
- (IBAction)StartBtn_Click:(id)sender
{
    if (self.vehical_id==nil)
    {
        UIGraphicsBeginImageContextWithOptions(self.signatureView.bounds.size, YES, 0.0f);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.signatureView.layer renderInContext:context];
        UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *photoData = UIImageJPEGRepresentation(snapshotImage, 0.8);
        
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
            [self SignatureUpload:photoData];
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    }
    else
    {
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
            [self StartTask];
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    }
    
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
         [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        
        UIGraphicsBeginImageContextWithOptions(self.signatureView.bounds.size, YES, 0.0f);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.signatureView.layer renderInContext:context];
        UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *photoData = UIImageJPEGRepresentation(snapshotImage, 0.8);
        
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
            [self SignatureUpload:photoData];
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
-(void)SignatureUpload:(NSData *)imageData
{
     [KVNProgress show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Signature_Upload  forKey:@"s"];
    [dictParams setObject:self.Task_ID  forKey:@"tid"];
   // [dictParams setObject:@""  forKey:@"file"];
    [manager.requestSerializer setValue:@"application/json; text/html" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    [manager POST:[NSString stringWithFormat:@"%@",BaseUrl] parameters:dictParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         [formData appendPartWithFileData:imageData name:@"file" fileName:@"signature.jpeg" mimeType:@"image/jpeg"];
     }
         progress:^(NSProgress * _Nonnull uploadProgress)
    {
    }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
         [KVNProgress dismiss];
          NSLog(@"JSON: %@", responseObject);
        if ([[[responseObject objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
        {
           [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }
        else
        {
            [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[responseObject objectForKey:@"ack_msg"] delegate:nil];
        }
     }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError*  _Nonnull error)
    {
          NSLog(@"%@",error.localizedDescription);
          [KVNProgress dismiss];
        
     }];
    
}

- (IBAction)ClearBtn_Click:(id)sender
{
     [self.signatureView erase];
     self.StartBtn.enabled=NO;
    self.StartBtn.alpha=0.5f;

}
- (IBAction)BackBtn_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

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
