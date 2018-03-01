//
//  CustomAlert.m
//  Wiings Delivery
//
//  Created by BacancyTechnology on 2/21/17.
//  Copyright © 2017 BacancyTechnology. All rights reserved.
//

#import "CustomAlert.h"
#import "UIImage+ImageEffects.h"

@implementation CustomAlert

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    CustomAlert *customView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAlert" owner:nil options:nil] lastObject];
    customView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);

    if ([customView isKindOfClass:[CustomAlert class]])
        return customView;
    else
        return nil;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.imgBackGround.image = [self makeBlurBackground];

    _viewAlertController.layer.cornerRadius = 5;
    _viewMultipleButtonView.layer.cornerRadius = 5;
    _Cancel_BTN.layer.cornerRadius = 5;
    _Set_BTN.layer.cornerRadius = 5;
    _Clear_BTN.layer.cornerRadius = 5;
    [self FromdatePicker];
     [self todatePicker];
   
    
    
//    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"disableSwipe"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
-(void)FromdatePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.backgroundColor=[UIColor whiteColor];
    [datePicker addTarget:self action:@selector(dateTextField1:) forControlEvents:UIControlEventValueChanged];
    
    //UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //toolbar.barStyle   = UIBarStyleBlackTranslucent;
    
    //UIBarButtonItem *itemDone  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.ToDate_TXT action:@selector(resignFirstResponder)];
   // UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
   // toolbar.items = @[itemSpace,itemDone];
    
   // self.FromDate_TXT.inputAccessoryView = toolbar;
    [self.FromDate_TXT setInputView:datePicker];
}
-(void) dateTextField1:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.FromDate_TXT.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.FromDate_TXT.text = [NSString stringWithFormat:@"%@",dateString];
}
-(void)todatePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.backgroundColor=[UIColor whiteColor];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    
   // UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
   // toolbar.barStyle   = UIBarStyleBlackTranslucent;
    
   // UIBarButtonItem *itemDone  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.ToDate_TXT action:@selector(resignFirstResponder)];
    //UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
   // toolbar.items = @[itemSpace,itemDone];
    
   // self.ToDate_TXT.inputAccessoryView = toolbar;
    [self.ToDate_TXT setInputView:datePicker];
}
-(void) dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.ToDate_TXT.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.ToDate_TXT.text = [NSString stringWithFormat:@"%@",dateString];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {

    }
    return self;
    
}

- (UIImage*)makeBlurBackground
{
    UIView *appView = [UIApplication sharedApplication].keyWindow.subviews.lastObject;
    
    UIImage *image = [UIImage convertViewToImage:appView];
    
    UIImage *blurSnapshotImage = [image applyBlurWithRadius:4.0f
                                                  tintColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.7f]
                                      saturationDeltaFactor:1.8f
                                                  maskImage:nil];
    
    NSLog(@"%@",self.imgBackGround);
    
    return blurSnapshotImage;

}



@end
