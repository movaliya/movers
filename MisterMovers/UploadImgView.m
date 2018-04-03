//
//  UploadImgView.m
//  MisterMovers
//
//  Created by kaushik on 06/03/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "UploadImgView.h"
#import "misterMover.pch"
#import "AddExtrahoursAlert.h"
#import "JobView.h"
#import "CompleteTaskVW.h"
#import "HomeVW.h"

@interface UploadImgView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *ImageArr,*SetImageArr;
    BOOL ReplaceImage;
    NSInteger indx;
     AddExtrahoursAlert *ExtraHourAlert;
}
@property (strong, nonatomic) UIButton *CancleExtraHourBTN;
@property (strong, nonatomic) UIButton *SubmitExtraHourBTN;

@property (strong, nonatomic) UILabel *DriverNameLBL;
@property (strong, nonatomic) UILabel *HelperNameLBL;

@property (strong, nonatomic) UITextField *DriverHourTXT;
@property (strong, nonatomic) UITextField *HelperHourTXT;
@property (strong, nonatomic) UIStackView *HelperStackView;


@end

@implementation UploadImgView
@synthesize ImageScroll,TaskNumberLBL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    TaskNumberLBL.text=self.Task_No;
    ExtraHourAlert = [[AddExtrahoursAlert alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:ExtraHourAlert];
    ExtraHourAlert.hidden=YES;
    
    self.CancleExtraHourBTN = (UIButton *)[ExtraHourAlert viewWithTag:100];
    [self.CancleExtraHourBTN addTarget:self action:@selector(CanclePopup_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    self.SubmitExtraHourBTN = (UIButton *)[ExtraHourAlert viewWithTag:101];
    [self.SubmitExtraHourBTN addTarget:self action:@selector(SubmitPopup_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    self.DriverNameLBL = (UILabel *)[ExtraHourAlert viewWithTag:200];
    self.DriverHourTXT = (UITextField *)[ExtraHourAlert viewWithTag:201];
    self.HelperNameLBL = (UILabel *)[ExtraHourAlert viewWithTag:202];
    self.HelperHourTXT = (UITextField *)[ExtraHourAlert viewWithTag:203];
    self.HelperStackView = (UIStackView *)[ExtraHourAlert viewWithTag:204];
    
   
    
    /*
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[self class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }*/
    ReplaceImage=NO;
    SetImageArr=[[NSMutableArray alloc]initWithObjects:@"YES", nil];
    [self SetimageScroll];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetDetailTask];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
}



-(void)GetDetailTask
{
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Get_Detail_Task  forKey:@"s"];
    
    [dictParams setObject:self.Task_ID  forKey:@"tid"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleDetailTaskResponse:response];
     }];
}
- (void)handleDetailTaskResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        DetailTaskDic=[[response valueForKey:@"result"] mutableCopy];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)AddExtraHoursScroll
{
    NSArray* subviews = [[NSArray alloc] initWithArray: ExtraHourAlert.HelperExtraHourScroll.subviews];
    for (UIView* view in subviews)
    {
        if ([view isKindOfClass:[UIView class]])
        {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:[UIImageView class]])
        {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:[UIButton class]])
        {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:[UILabel class]])
        {
            [view removeFromSuperview];
        }
    }
    
    int x = 5,y=0;
    for (int i=0; i<helperDetail.count; i++)
    {
        UILabel *Title_LBL=[[UILabel alloc]initWithFrame:CGRectMake(x, y, SCREEN_WIDTH/2-5, 40)];
        Title_LBL.text=[[helperDetail objectAtIndex:i] valueForKey:@"employee_name"];
        Title_LBL.font=[UIFont systemFontOfSize:13];
        [ExtraHourAlert.HelperExtraHourScroll addSubview:Title_LBL];
        
        UITextField *Hour_TXT=[[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, y, SCREEN_WIDTH/2-5, 40)];
        Hour_TXT.placeholder=@"Add Extra Hours";
        Hour_TXT.keyboardType = UIKeyboardTypeNumberPad;
        Hour_TXT.tag=i;
        [ExtraHourAlert.HelperExtraHourScroll addSubview:Hour_TXT];
        
        UILabel *Line_LBL=[[UILabel alloc]initWithFrame:CGRectMake(0, y+41, SCREEN_WIDTH, 1)];
        Line_LBL.backgroundColor=[UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
        [ExtraHourAlert.HelperExtraHourScroll addSubview:Line_LBL];
        
        y=y+41;
    }
    [ExtraHourAlert.HelperExtraHourScroll setContentSize:CGSizeMake(20, y)];
    ExtraHourAlert.ExtraHourHight.constant=220+y;

    
}

-(void)SetimageScroll
{
    NSArray* subviews = [[NSArray alloc] initWithArray: self.ImageScroll.subviews];
    for (UIView* view in subviews)
    {
        if ([view isKindOfClass:[UIView class]])
        {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:[UIImageView class]])
        {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:[UIButton class]])
        {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:[UILabel class]])
        {
            [view removeFromSuperview];
        }
    }
    
    if (IS_IPHONE_6)
    {
        int x = 20,y=15;
        for (int i=0; i<SetImageArr.count; i++)
        {
            if (x<300)
            {
                UIButton *BTN=[[UIButton alloc]initWithFrame:CGRectMake(x,  y, 160, 160)];
                BTN.tag =i;
                if (SetImageArr.count-1==i)
                {
                    if ([[SetImageArr objectAtIndex:i] isKindOfClass:[UIImage class]])
                    {
                        [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [BTN addTarget:self action:@selector(AddImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        BTN.backgroundColor=[UIColor clearColor];
                        UIImage *PlusImage = [UIImage imageNamed:@"plusSign.png"];
                        [BTN setImage:PlusImage forState:UIControlStateNormal];
                        
                    }
                    
                }
                else
                {
                    [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                    [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                }
                [self.ImageScroll addSubview:BTN];
                
                x=x+175;
            }
            else
            {
                y=y+175;
                x=20;
                UIButton *BTN=[[UIButton alloc]initWithFrame:CGRectMake(x,  y, 160, 160)];
                BTN.tag =i;
                if (SetImageArr.count-1==i)
                {
                    if ([[SetImageArr objectAtIndex:i] isKindOfClass:[UIImage class]])
                    {
                        [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [BTN addTarget:self action:@selector(AddImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        BTN.backgroundColor=[UIColor clearColor];
                        UIImage *PlusImage = [UIImage imageNamed:@"plusSign.png"];
                        [BTN setImage:PlusImage forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                    [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                }
                [self.ImageScroll addSubview:BTN];
                
                x=x+175;
            }
        }
        
        y=y+220;
        
        UIButton *UploadBTN=[[UIButton alloc]initWithFrame:CGRectMake(10,  y-30, SCREEN_WIDTH-20, 40)];
        [UploadBTN addTarget:self action:@selector(Upload_click:) forControlEvents:UIControlEventTouchUpInside];
        UploadBTN.backgroundColor=[UIColor colorWithRed:62.0f/255.0f green:84.0f/255.0f blue:175.0f/255.0f alpha:1.0f];
        [UploadBTN setTitle:@"UPLOAD IMAGE" forState:UIControlStateNormal];
        [self.ImageScroll addSubview:UploadBTN];
        
        [self.ImageScroll setContentSize:CGSizeMake(SCREEN_WIDTH, y+20)];
    }
    else if (isIPhone5)
    {
        int x = 10,y=10;
        for (int i=0; i<SetImageArr.count; i++)
        {
            if (x<250)
            {
                UIButton *BTN=[[UIButton alloc]initWithFrame:CGRectMake(x,  y, 145, 145)];
                BTN.tag =i;
                if (SetImageArr.count-1==i)
                {
                    if ([[SetImageArr objectAtIndex:i] isKindOfClass:[UIImage class]])
                    {
                        [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [BTN addTarget:self action:@selector(AddImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        BTN.backgroundColor=[UIColor clearColor];
                        UIImage *PlusImage = [UIImage imageNamed:@"plusSign.png"];
                        [BTN setImage:PlusImage forState:UIControlStateNormal];
                        
                    }
                }
                else
                {
                    [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                    [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                }
                [self.ImageScroll addSubview:BTN];
                
                x=x+155;
            }
            else
            {
                y=y+155;
                x=10;
                UIButton *BTN=[[UIButton alloc]initWithFrame:CGRectMake(x,  y, 145, 145)];
                BTN.tag =i;
                if (SetImageArr.count-1==i)
                {
                    if ([[SetImageArr objectAtIndex:i] isKindOfClass:[UIImage class]])
                    {
                        [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [BTN addTarget:self action:@selector(AddImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        BTN.backgroundColor=[UIColor clearColor];
                        UIImage *PlusImage = [UIImage imageNamed:@"plusSign.png"];
                        [BTN setImage:PlusImage forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                    [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                }
                [self.ImageScroll addSubview:BTN];
                
                x=x+155;
            }
        }
        
        y=y+190;
        
        UIButton *UploadBTN=[[UIButton alloc]initWithFrame:CGRectMake(10,  y-30, SCREEN_WIDTH-20, 40)];
        [UploadBTN addTarget:self action:@selector(Upload_click:) forControlEvents:UIControlEventTouchUpInside];
        UploadBTN.backgroundColor=[UIColor colorWithRed:62.0f/255.0f green:84.0f/255.0f blue:175.0f/255.0f alpha:1.0f];
        [UploadBTN setTitle:@"UPLOAD IMAGE" forState:UIControlStateNormal];
        [self.ImageScroll addSubview:UploadBTN];
        
        [self.ImageScroll setContentSize:CGSizeMake(SCREEN_WIDTH, y+20)];
    }
    else if (IS_IPHONE_6P)
    {
        int x = 15,y=10;
        for (int i=0; i<SetImageArr.count; i++)
        {
            if (x<400)
            {
                UIButton *BTN=[[UIButton alloc]initWithFrame:CGRectMake(x,  y, 185, 185)];
                BTN.tag =i;
                if (SetImageArr.count-1==i)
                {
                    if ([[SetImageArr objectAtIndex:i] isKindOfClass:[UIImage class]])
                    {
                        [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [BTN addTarget:self action:@selector(AddImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        BTN.backgroundColor=[UIColor clearColor];
                        UIImage *PlusImage = [UIImage imageNamed:@"plusSign.png"];
                        [BTN setImage:PlusImage forState:UIControlStateNormal];
                        
                    }
                }
                else
                {
                    [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                    [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                }
                [self.ImageScroll addSubview:BTN];
                
                x=x+200;
            }
            else
            {
                y=y+200;
                x=15;
                UIButton *BTN=[[UIButton alloc]initWithFrame:CGRectMake(x,  y, 185, 185)];
                BTN.tag =i;
                if (SetImageArr.count-1==i)
                {
                    if ([[SetImageArr objectAtIndex:i] isKindOfClass:[UIImage class]])
                    {
                        [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [BTN addTarget:self action:@selector(AddImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                        BTN.backgroundColor=[UIColor clearColor];
                        UIImage *PlusImage = [UIImage imageNamed:@"plusSign.png"];
                        [BTN setImage:PlusImage forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [BTN addTarget:self action:@selector(ImageBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
                    [BTN setBackgroundImage:[SetImageArr objectAtIndex:i] forState:UIControlStateNormal];
                }
                [self.ImageScroll addSubview:BTN];
                
                x=x+200;
            }
        }
        
        y=y+240;
        
        UIButton *UploadBTN=[[UIButton alloc]initWithFrame:CGRectMake(10,  y-30, SCREEN_WIDTH-20, 40)];
        [UploadBTN addTarget:self action:@selector(Upload_click:) forControlEvents:UIControlEventTouchUpInside];
        UploadBTN.backgroundColor=[UIColor colorWithRed:62.0f/255.0f green:84.0f/255.0f blue:175.0f/255.0f alpha:1.0f];
        [UploadBTN setTitle:@"UPLOAD IMAGE" forState:UIControlStateNormal];
        [self.ImageScroll addSubview:UploadBTN];
        
        [self.ImageScroll setContentSize:CGSizeMake(SCREEN_WIDTH, y+20)];
    }
}

-(void)ImageBTN_Click:(id)sender
{
    ReplaceImage=YES;
    indx=[sender tag];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)Upload_click:(id)sender
{
    NSMutableArray *uploadImages=[[NSMutableArray alloc]init];
    for(int i=0; i<[SetImageArr count];i++)
    {
        if ([[SetImageArr objectAtIndex:i] isKindOfClass:[UIImage class]])
        {
            [uploadImages addObject:[SetImageArr objectAtIndex:i]];
        }
    }
    
    
    if (uploadImages.count==0)
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:@"Please select job image" delegate:nil];
    }
    else
    {
        UIAlertController *ExtraHouralert = [UIAlertController alertControllerWithTitle:@"" message:@"Do you want to enter any extra hours?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *No = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            // No Action
            CheckStrForSucess=@"No";
            BOOL internet=[AppDelegate connectedToNetwork];
            if (internet)
                [self uploadJobimage];
            else
                [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
        }];
        UIAlertAction *Yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            CheckStrForSucess=@"Yes";
            self.DriverNameLBL.text=[DetailTaskDic valueForKey:@"task_leader_name"];
            helperDetail=[DetailTaskDic valueForKey:@"helpers_details"];
            if (helperDetail.count==0)
            {
                self.HelperStackView.hidden=YES;
            }
            else
            {
                  self.HelperNameLBL.text=[[helperDetail valueForKey:@"employee_name"]  objectAtIndex:0];
            }
         
            [self.view endEditing:YES];
            ExtraHourAlert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
            ExtraHourAlert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
            ExtraHourAlert.hidden=NO;
            [UIView animateWithDuration:0.2 animations:
             ^{
                 ExtraHourAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
             }];
            
            // YES action
            [self AddExtraHoursScroll];
//            BOOL internet=[AppDelegate connectedToNetwork];
//            if (internet)
//                [self uploadJobimage];
//            else
//                [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
           
        }];
        [ExtraHouralert addAction:No];
        [ExtraHouralert addAction:Yes];
        [self presentViewController:ExtraHouralert animated:YES completion:nil];

    }
   
}
-(void)uploadJobimage
{
       
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
   
    [KVNProgress show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Task_Image_Upload  forKey:@"s"];
    [dictParams setObject:self.Task_ID  forKey:@"tid"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    
    [manager.requestSerializer setValue:@"application/json; text/html" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    [manager POST:[NSString stringWithFormat:@"%@",BaseUrl] parameters:dictParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
        
         for(int i=0; i<[SetImageArr count];i++)
         {
             if ([[SetImageArr objectAtIndex:i] isKindOfClass:[UIImage class]])
             {
                 NSData *imageData =UIImageJPEGRepresentation( SetImageArr[i], 0.8);
                 NSString *strName = [NSString stringWithFormat:@"name%d.jpeg",i];
                 
                 [formData appendPartWithFileData:imageData name:@"files" fileName:strName mimeType:@"image/jpeg"];
             }
         }
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
             if ([CheckStrForSucess isEqualToString:@"No"])
             {
                 CompleteTaskVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CompleteTaskVW"];
                 [self.navigationController pushViewController:vcr animated:YES];
                 [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[responseObject objectForKey:@"ack_msg"] delegate:nil];
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
-(void)AddImageBTN_Click:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)Back_click:(id)sender
{
    if (self.CheckPopup2!=nil)
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (ReplaceImage==YES)
    {
        [SetImageArr replaceObjectAtIndex:indx withObject:info[UIImagePickerControllerEditedImage]];
        ReplaceImage=NO;

    }
    else
    {
        [SetImageArr insertObject:info[UIImagePickerControllerEditedImage] atIndex:0];
        
        if (SetImageArr.count>5)
        {
            [SetImageArr removeObjectAtIndex:SetImageArr.count-1];
        }
    }
    
    [self SetimageScroll];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    ReplaceImage=NO;

    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)SubmitPopup_Click:(id)sender
{
    if ([_DriverHourTXT.text isEqualToString:@""])
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:@"Please enter Driver Hours" delegate:nil];
    }
    else
    {
        ExtraHourAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        [UIView animateWithDuration:0.2 animations:^{
            ExtraHourAlert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                
                ExtraHourAlert.hidden=YES;
                BOOL internet=[AppDelegate connectedToNetwork];
                if (internet)
                    [self AddExtrahour];
                else
                    [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
            }];
        }];
       
    }
    
}
- (IBAction)CanclePopup_Click:(id)sender
{
    
    ExtraHourAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView animateWithDuration:0.2 animations:^{
        ExtraHourAlert.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            ExtraHourAlert.hidden=YES;
        }];
    }];
}
-(void)AddExtrahour
{
    NSMutableArray *HourArr=[[NSMutableArray alloc]init];
    
    NSArray* subviews = [[NSArray alloc] initWithArray: ExtraHourAlert.HelperExtraHourScroll.subviews];
    for (UIView* view in subviews)
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            UITextField *TXT=(UITextField *)view;
            for (int i=0; i<helperDetail.count; i++)
            {
                if (TXT.tag==i)
                {
                    NSLog(@"TEXT==%@",TXT.text);
                    
                    if (![TXT.text isEqualToString:@""])
                    {
                        NSMutableDictionary *inddic22=[[NSMutableDictionary alloc]init];

                        [inddic22 setObject:TXT.text forKey:@"hour"];
                        [inddic22 setObject:[[helperDetail objectAtIndex:i] valueForKey:@"employee_id"] forKey:@"id"];
                        [HourArr addObject:inddic22];
                    }
                }
            }
        }
    }
    
    NSDictionary *json;
    NSInteger totalHour=0;
    if (helperDetail.count!=0)
    {

         totalHour=[_DriverHourTXT.text integerValue]+[_HelperHourTXT.text integerValue];
        NSMutableDictionary *inddic=[[NSMutableDictionary alloc]init];
        [inddic setObject:HourArr forKey:@"Key"];
        NSDictionary *dic=[HourArr mutableCopy];
        NSError* error = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"");
        
    }
    else
    {
         totalHour=[_DriverHourTXT.text integerValue];
    }
    NSString *totalhr=[NSString stringWithFormat:@"%ld",(long)totalHour];
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Add_Extra_hour  forKey:@"s"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    [dictParams setObject:self.Task_ID  forKey:@"tid"];
    [dictParams setObject:_DriverHourTXT.text  forKey:@"extra_hour"];
    if (json.count!=0) {
         [dictParams setObject:json forKey:@"helpers"];
    }
    else
    {
         [dictParams setObject:@"" forKey:@"helpers"];
    }
   

    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleAddExtrahourResponse:response];
     }];
}
- (void)handleAddExtrahourResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        if ([CheckStrForSucess isEqualToString:@"Yes"])
        {
            CompleteTaskVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CompleteTaskVW"];
            [self.navigationController pushViewController:vcr animated:YES];
            [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        }
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

@end
