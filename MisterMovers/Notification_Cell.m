//
//  Notification_Cell.m
//  digitalmarketing
//
//  Created by Mango SW on 15/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "Notification_Cell.h"

@implementation Notification_Cell
@synthesize BackView;
- (void)awakeFromNib
{
    [super awakeFromNib];
    [BackView.layer setCornerRadius:3.0f];
    BackView.layer.borderWidth = 1.0f;
    [BackView.layer setMasksToBounds:YES];
    BackView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [BackView.layer setShadowColor:[UIColor blackColor].CGColor];
    [BackView.layer setShadowOpacity:0.8];
    [BackView.layer setShadowRadius:1.0];
    [BackView.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
