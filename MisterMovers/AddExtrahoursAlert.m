//
//  CustomAlert.m
//  Wiings Delivery
//
//  Created by BacancyTechnology on 2/21/17.
//  Copyright © 2017 BacancyTechnology. All rights reserved.
//

#import "AddExtrahoursAlert.h"
#import "UIImage+ImageEffects.h"

@implementation AddExtrahoursAlert

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
    
    AddExtrahoursAlert *customView = [[[NSBundle mainBundle] loadNibNamed:@"AddExtrahoursAlert" owner:nil options:nil] lastObject];
    customView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);

    if ([customView isKindOfClass:[AddExtrahoursAlert class]])
        return customView;
    else
        return nil;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
   // self.imgBackGround.image = [self makeBlurBackground];

    _viewAlertController.layer.cornerRadius = 5;
    _viewMultipleButtonView.layer.cornerRadius = 5;
    _Cancel_BTN.layer.cornerRadius = 5;
     _Submit_BTN.layer.cornerRadius = 5;
   
    
   
    
    
//    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"disableSwipe"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
    
   // NSLog(@"%@",self.imgBackGround);
    
    return blurSnapshotImage;

}



@end
