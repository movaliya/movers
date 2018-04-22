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
#import "UploadImgView.h"
#import "JobView.h"
#import "HomeVW.h"


@interface SignatureVW ()

@end

@implementation SignatureVW
- (NSUInteger)supportedInterfaceOrientations // iOS 6 autorotation fix
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation // iOS 6 autorotation fix
{
    return UIInterfaceOrientationPortrait;
}

-(void)Setlockoriantation
{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self performSelector:@selector(Setlockoriantation) withObject:nil afterDelay:0.1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.vehical_id==nil)
    {
        self.customerSignatureTitle.text=@"Customer Signature End";
        [self.StartBtn setTitle:@"END" forState:UIControlStateNormal];

    }
    else
    {
        [self.StartBtn setTitle:@"START" forState:UIControlStateNormal];
         self.customerSignatureTitle.text=@"Customer Signature Start";
    }
    self.TaskTitle_LBL.text=self.Task_No2;
    self.StartBtn.enabled=NO;
    self.StartBtn.alpha=0.5f;
    
    /*
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[self class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }*/

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
        if ( [KmyappDelegate.Mytimer isValid])
        {
            [AppDelegate showErrorMessageWithTitle:@"" message:@"One Job is Running. Please End job first." delegate:nil];
        }
        else
        {
            UIGraphicsBeginImageContextWithOptions(self.signatureView.bounds.size, YES, 0.0f);
            CGContextRef context = UIGraphicsGetCurrentContext();
            [self.signatureView.layer renderInContext:context];
            UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            NSData *photoData = UIImageJPEGRepresentation(snapshotImage, 0.8);
            
            BOOL internet=[AppDelegate connectedToNetwork];
            if (internet)
                [self StartTask:photoData];
            else
                [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
        }
        
       
    }
    
}
-(void)StartTask :(NSData *)imageData
{
    
    // Get current datetime
    NSDate *currentDateTime = [NSDate date];
    
    // Instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // Set the dateFormatter format
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    // Get the date time in NSString
    NSString *dateInString = [dateFormatter stringFromDate:currentDateTime];
    
    [KVNProgress show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
     NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
     [dictParams setObject:Base_Key  forKey:@"key"];
     [dictParams setObject:Start_Task  forKey:@"s"];
     //[dictParams setObject:self.vehical_id  forKey:@"vehical_id"];
     [dictParams setObject:self.Task_ID  forKey:@"tid"];
     [dictParams setObject:dateInString  forKey:@"start_date"];
     
    // [dictParams setObject:@""  forKey:@"file"];
    [manager.requestSerializer setValue:@"application/json; text/html" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    [manager POST:[NSString stringWithFormat:@"%@",BaseUrl] parameters:dictParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         [formData appendPartWithFileData:imageData name:@"file" fileName:@"Startsignature.jpeg" mimeType:@"image/jpeg"];
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
              [self.navigationController popViewControllerAnimated:YES];
             [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[responseObject objectForKey:@"ack_msg"] delegate:nil];
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

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
-(void)SignatureUpload:(NSData *)imageData
{
     [KVNProgress show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Signature_Upload  forKey:@"s"];
    [dictParams setObject:self.Task_ID  forKey:@"tid"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
   // [dictParams setObject:@""  forKey:@"file"];
    [manager.requestSerializer setValue:@"application/json; text/html" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    [manager POST:[NSString stringWithFormat:@"%@",BaseUrl] parameters:dictParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         [formData appendPartWithFileData:imageData name:@"file" fileName:@"Endsignature.jpeg" mimeType:@"image/jpeg"];
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
            
            if (self.vehical_id==nil)
            {
                UploadImgView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UploadImgView"];
                vcr.Task_ID=self.Task_ID;
                 vcr.Task_No=self.Task_No2;
                if (self.CheckPopup1!=nil)
                {
                     vcr.CheckPopup2=self.CheckPopup1;
                }
                [self.navigationController pushViewController:vcr animated:YES];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
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
    
    if (self.vehical_id==nil)
    {
        if (self.CheckPopup1!=nil)
        {
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[HomeVW class]])
                {
                    [self.navigationController popToViewController:controller animated:YES];
                    break;
                }
            }
        }
        else
        {
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[JobView class]])
                {
                    [self.navigationController popToViewController:controller animated:YES];
                    break;
                }
            }
        }
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    

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
