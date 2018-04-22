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
}

@property (weak, nonatomic) IBOutlet UITableView *AccountTBL;
@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@end
