//
//  PrivacyPolicyVW.h
//  MisterMovers
//
//  Created by jignesh solanki on 03/03/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacyPolicyVW : UIView<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *WebVW;
@property (weak, nonatomic) IBOutlet UIButton *CancelPolicyBtn;
@property (weak, nonatomic) IBOutlet UIButton *AgreePolicyBtn;

@end
