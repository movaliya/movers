//
//  SignatureVW.h
//  MisterMovers
//
//  Created by jignesh solanki on 20/02/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UviSignatureView.h"

@interface SignatureVW : UIViewController
@property (strong, nonatomic) NSString *Task_NO;
@property (weak, nonatomic) IBOutlet UviSignatureView *signatureView;

@end
