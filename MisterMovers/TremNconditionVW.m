//
//  TremNconditionVW.m
//  MisterMovers
//
//  Created by jignesh solanki on 20/02/2018.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "TremNconditionVW.h"
#import "misterMover.pch"
#import "SignatureVW.h"

@interface TremNconditionVW ()

@end

@implementation TremNconditionVW

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)AgreeBtn_Click:(id)sender
{
    
    
   
}

- (IBAction)Cancel_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)backBtn_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
