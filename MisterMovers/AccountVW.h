//
//  AccountVW.h
//  MisterMovers
//
//  Created by jignesh solanki on 21/04/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "misterMover.pch"

@interface AccountVW : UIViewController<CCKFNavDrawerDelegate>

{
    NSMutableDictionary *accountDict;
    NSMutableArray *ForSortData;
    NSArray *sortedArray;
}
@property (weak, nonatomic) IBOutlet UILabel *AccountNO_LBL;
@property (weak, nonatomic) IBOutlet UILabel *DriverName_LBL;
@property (weak, nonatomic) IBOutlet UILabel *FromDate_LBL;
@property (weak, nonatomic) IBOutlet UILabel *ToDate_LBL;
@property (weak, nonatomic) IBOutlet UILabel *DebitTotal_LBL;
@property (weak, nonatomic) IBOutlet UILabel *CreditTotal_LBL;
@property (weak, nonatomic) IBOutlet UILabel *ClosingBalance_LBL;

@property (strong, nonatomic) CCKFNavDrawer *rootNav;
@property (weak, nonatomic) IBOutlet UITableView *AccountTBL;

@end
