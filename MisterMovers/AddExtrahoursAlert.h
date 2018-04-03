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
@property (strong, nonatomic) IBOutlet UIView *viewMultipleButtonView;
@property (strong, nonatomic) IBOutlet UIView *viewAlertController;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constYAxes;
@property (strong, nonatomic) IBOutlet UIButton *Cancel_BTN;
@property (strong, nonatomic) IBOutlet UIButton *Submit_BTN;
@property (weak, nonatomic) IBOutlet UILabel *DriverName_LBL;
@property (weak, nonatomic) IBOutlet UILabel *HelperName_LBL;
@property (weak, nonatomic) IBOutlet UIStackView *HelperView;
@property (weak, nonatomic) IBOutlet UITextField *DriverHour_TXT;

@property (weak, nonatomic) IBOutlet UITextField *HelperHour_TXT;


@property (strong, nonatomic) IBOutlet UIScrollView *HelperExtraHourScroll;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *HelperHourScrollHight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ExtraHourHight;

- (id)initWithFrame:(CGRect)frame;
- (UIImage*)makeBlurBackground;

@end
