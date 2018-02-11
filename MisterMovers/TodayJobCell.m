//
//  TodayJobCell.m
//  MisterMovers
//
//  Created by kaushik on 11/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "TodayJobCell.h"

@implementation TodayJobCell
@synthesize BakView;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [BakView.layer setShadowColor:[UIColor blackColor].CGColor];
    [BakView.layer setShadowOpacity:0.8];
    [BakView.layer setShadowRadius:2.0];
    [BakView.layer setShadowOffset:CGSizeMake(1.0,1.0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
