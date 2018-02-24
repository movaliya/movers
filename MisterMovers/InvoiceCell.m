//
//  InvoiceCell.m
//  MisterMovers
//
//  Created by kaushik on 24/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "InvoiceCell.h"

@implementation InvoiceCell
@synthesize BackView;

- (void)awakeFromNib {
    [super awakeFromNib];

    [BackView.layer setShadowColor:[UIColor blackColor].CGColor];
    [BackView.layer setShadowOpacity:0.8];
    [BackView.layer setShadowRadius:2.0];
    [BackView.layer setShadowOffset:CGSizeMake(1.0,1.0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
