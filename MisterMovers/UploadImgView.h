//
//  UploadImgView.h
//  MisterMovers
//
//  Created by kaushik on 06/03/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadImgView : UIViewController
{
    NSMutableDictionary *DetailTaskDic;
    NSMutableArray *helperDetail;
    NSString *CheckStrForSucess;
}
@property (strong, nonatomic) NSString *CheckPopup2;

@property (weak, nonatomic) IBOutlet UILabel *TaskNumberLBL;
- (IBAction)Back_click:(id)sender;
@property (strong, nonatomic) NSString *Task_ID;
@property (strong, nonatomic) NSString *Task_No;

@property (strong, nonatomic) IBOutlet UIScrollView *ImageScroll;
@end
