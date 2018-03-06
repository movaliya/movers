//
//  UploadImgView.m
//  MisterMovers
//
//  Created by kaushik on 06/03/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "UploadImgView.h"
#import "misterMover.pch"

@interface UploadImgView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *ImageArr,*SetImageArr;
    BOOL ReplaceImage;
    NSInteger indx;
}
@end

@implementation UploadImgView
@synthesize ImageScroll;

- (void)viewDidLoad
{
    [super viewDidLoad];
    ReplaceImage=NO;
    SetImageArr=[[NSMutableArray alloc]initWithObjects:@"YES", nil];
    [self SetimageScroll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
                    BTN.backgroundColor=[UIColor redColor];
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
                    BTN.backgroundColor=[UIColor redColor];
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
    [self.navigationController popViewControllerAnimated:YES];
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

@end
