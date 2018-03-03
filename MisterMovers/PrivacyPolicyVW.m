//
//  PrivacyPolicyVW.m
//  MisterMovers
//
//  Created by jignesh solanki on 03/03/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "PrivacyPolicyVW.h"
#import "UIImage+ImageEffects.h"

@implementation PrivacyPolicyVW

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    PrivacyPolicyVW *customView = [[[NSBundle mainBundle] loadNibNamed:@"PrivacyPolicyVW" owner:nil options:nil] lastObject];
    customView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    if ([customView isKindOfClass:[PrivacyPolicyVW class]])
        return customView;
    else
        return nil;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    /*
    NSString *url=@"http://www.google.com";
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];*/

    self.WebVW.delegate = self;
     NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"policy" ofType:@"pdf"];
     NSURL *url = [NSURL fileURLWithPath:urlAddress];
     NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
     [self.WebVW loadRequest:urlRequest];
    
}
- (UIImage*)makeBlurBackground
{
    UIView *appView = [UIApplication sharedApplication].keyWindow.subviews.lastObject;
    
    UIImage *image = [UIImage convertViewToImage:appView];
    
    UIImage *blurSnapshotImage = [image applyBlurWithRadius:4.0f
                                                  tintColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.7f]
                                      saturationDeltaFactor:1.8f
                                                  maskImage:nil];
    
    
    return blurSnapshotImage;
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        
    }
    return self;
    
}
@end
