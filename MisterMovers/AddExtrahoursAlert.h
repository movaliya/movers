//
//  CustomAlert.h
//  Wiings Delivery
//
//  Created by BacancyTechnology on 2/21/17.
//  Copyright © 2017 BacancyTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddExtrahoursAlert : UIView

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UIView *viewMultipleButtonView;
@property (strong, nonatomic) IBOutlet UIView *viewAlertController;
@property (strong, nonatomic) IBOutlet UIImageView *imgBackGround;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constYAxes;
@property (strong, nonatomic) IBOutlet UIView *FromDateView;
@property (strong, nonatomic) IBOutlet UITextField *FromDate_TXT;
@property (strong, nonatomic) IBOutlet UIView *ToDateView;
@property (strong, nonatomic) IBOutlet UITextField *ToDate_TXT;
@property (strong, nonatomic) IBOutlet UIButton *Cancel_BTN;
@property (strong, nonatomic) IBOutlet UIButton *Clear_BTN;
@property (strong, nonatomic) IBOutlet UIButton *Set_BTN;




- (id)initWithFrame:(CGRect)frame;
- (UIImage*)makeBlurBackground;

@end
