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

@property (strong, nonatomic) NSString *Task_No2;
@property (strong, nonatomic) NSString *Task_ID;
@property (strong, nonatomic) NSString *vehical_id;
@property (weak, nonatomic) IBOutlet UIButton *StartBtn;

@property (weak, nonatomic) IBOutlet UviSignatureView *signatureView;
@property (weak, nonatomic) IBOutlet UILabel *TaskTitle_LBL;

@end
