//
//  NotificationDispCell.m
//  MisterMovers
//
//  Created by kaushik on 10/03/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "NotificationDispCell.h"

@implementation NotificationDispCell
@synthesize CellViewBG;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [CellViewBG.layer setShadowColor:[UIColor blackColor].CGColor];
    [CellViewBG.layer setShadowOpacity:0.8];
    [CellViewBG.layer setShadowRadius:2.0];
    [CellViewBG.layer setShadowOffset:CGSizeMake(1.0,1.0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
