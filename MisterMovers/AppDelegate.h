//
//  AppDelegate.h
//  digitalmarketing
//
//  Created by Mango SW on 14/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <UserNotifications/UserNotifications.h>
@import Firebase;

@interface AppDelegate : UIResponder <UIApplicationDelegate,FIRMessagingDelegate>
{
    UIBackgroundTaskIdentifier locationUpdater;
    int secondsLeft;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *strDeviceToken;
@property (strong, nonatomic) NSString *FCMDeviceToken;
@property(nonatomic, strong) NSTimer *Mytimer;
@property (strong, nonatomic) NSString *TimerValue;
-(void)updateCountdown;
+(BOOL)connectedToNetwork;
+ (AppDelegate *)sharedInstance;
+(BOOL)IsValidEmail:(NSString *)checkString;

+ (void)showErrorMessageWithTitle:(NSString *)title
                          message:(NSString*)message
                         delegate:(id)delegate;

+(void)showInternetErrorMessageWithTitle:(NSString *)title delegate:(id)delegate;
- (BOOL)isUserLoggedIn;

-(void)SettextfieldViewBorder:(UIView *)FieldView;

@end

