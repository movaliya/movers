//
//  AccountVW.h
//  MisterMovers
//
//  Created by jignesh solanki on 21/04/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountVW : UIViewController

{
    NSMutableDictionary *accountDict;
}
@property (weak, nonatomic) IBOutlet UITableView *AccountTBL;
@end
