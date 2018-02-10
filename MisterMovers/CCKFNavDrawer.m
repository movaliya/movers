//
//  CCKFNavDrawer.m
//  CCKFNavDrawer
//
//  Created by calvin on 23/1/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import "CCKFNavDrawer.h"
#import "DrawerView.h"
#import "MenuCell.h"
#import "AppDelegate.h"

#import "HomeVW.h"
#import "LogInVW.h"
#import "ProfileVIEW.h"

#define SHAWDOW_ALPHA 0.5
#define MENU_DURATION 0.3
#define MENU_TRIGGER_VELOCITY 350

@interface CCKFNavDrawer ()
{
    NSMutableArray *TitleArr,*ImgArr;
}
@property AppDelegate *appDelegate;

@property (nonatomic) BOOL isOpen;
@property (nonatomic) float meunHeight;
@property (nonatomic) float menuWidth;
@property (nonatomic) CGRect outFrame;
@property (nonatomic) CGRect inFrame;
@property (strong, nonatomic) UIView *shawdowView;
@property (strong, nonatomic) DrawerView *drawerView;

@end

@implementation CCKFNavDrawer

#pragma mark - VC lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appDelegate = [AppDelegate sharedInstance];
    
    
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    NSString *makeStrVersion=[NSString stringWithFormat:@"Version %@",appVersion];
    if ([self.appDelegate isUserLoggedIn] == NO)
    {
        TitleArr=[[NSMutableArray alloc] initWithObjects:makeStrVersion, nil];
        //TitleArr=[[NSMutableArray alloc] initWithObjects:@"Export Database",@"Import Database",@"Logout",@"My Account",@"Share",@"Send", nil];
    }
    else
    {
        //TitleArr=[[NSMutableArray alloc] initWithObjects:@"Export Database",@"Import Database",@"Logout",@"My Account",@"Share",@"Send", nil];
         TitleArr=[[NSMutableArray alloc] initWithObjects:makeStrVersion, nil];
    }
    
    
    //ImgArr=[[NSMutableArray alloc] initWithObjects:@"ExportIcon",@"importicon",@"importicon",@"settingicon",@"shareicon",@"sendIcon" ,nil];
     ImgArr=[[NSMutableArray alloc] initWithObjects:@"VersionIcon",nil];
    
    
    [self setUpDrawer];
    
    if (SCREEN_HEIGHT==480)
    {
        self.drawerView.LogoWidht.constant=170;
        self.drawerView.LogoHight.constant=86;
        self.drawerView.LBLLeading.constant=25;
        self.drawerView.LBL_Trailing.constant=25;
        self.drawerView.LogoLBLGap.constant=20;
    }
    else
        
    {
        self.drawerView.LogoWidht.constant=212;
        self.drawerView.LogoHight.constant=114;
        self.drawerView.LBLLeading.constant=20;
        self.drawerView.LBL_Trailing.constant=20;
        self.drawerView.LogoLBLGap.constant=29;
    }
    
    
    //Username 
    if ([KmyappDelegate isUserLoggedIn] == YES)
    {
        NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
        self.drawerView.Username_LBL.text=[UserSaveData valueForKey:@"username"];
    }

}

-(void)CheckLoginArr
{
    self.appDelegate = [AppDelegate sharedInstance];
    
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSString *makeStrVersion=[NSString stringWithFormat:@"Version %@",appVersion];
    if ([self.appDelegate isUserLoggedIn] == NO)
    {
        //TitleArr=[[NSMutableArray alloc] initWithObjects:@"Export Database",@"Import Database",@"Logout",@"My Account",@"Share",@"Send", nil];
         TitleArr=[[NSMutableArray alloc] initWithObjects:makeStrVersion, nil];
    }
    else
    {
        //TitleArr=[[NSMutableArray alloc] initWithObjects:@"Export Database",@"Import Database",@"Logout",@"My Account",@"Share",@"Send", nil];
         TitleArr=[[NSMutableArray alloc] initWithObjects:makeStrVersion, nil];
    }
    
    //ImgArr=[[NSMutableArray alloc] initWithObjects:@"ExportIcon",@"importicon",@"importicon",@"settingicon",@"shareicon",@"sendIcon" ,nil];
    ImgArr=[[NSMutableArray alloc] initWithObjects:@"VersionIcon",nil];
    
    [self.drawerView.drawerTableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self BackClick:self];
}

#pragma mark - push & pop

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    // disable gesture in next vc
    [self.pan_gr setEnabled:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    
    // enable gesture in root vc
    if ([self.viewControllers count]==1){
        [self.pan_gr setEnabled:YES];
    }
    return vc;
}

#pragma mark - drawer

- (void)setUpDrawer
{
    self.isOpen = NO;
    
    // load drawer view
    self.drawerView = [[[NSBundle mainBundle] loadNibNamed:@"DrawerView" owner:self options:nil] objectAtIndex:0];
    
    self.meunHeight = self.view.frame.size.height;
    self.menuWidth = self.view.frame.size.width;
    self.outFrame = CGRectMake(-self.menuWidth,0,self.menuWidth,self.meunHeight);
    self.inFrame = CGRectMake (0,0,self.menuWidth,self.meunHeight);
    
    // drawer shawdow and assign its gesture
    self.shawdowView = [[UIView alloc] initWithFrame:self.view.frame];
    self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    self.shawdowView.hidden = YES;
    UITapGestureRecognizer *tapIt = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(tapOnShawdow:)];
    [self.shawdowView addGestureRecognizer:tapIt];
    self.shawdowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.shawdowView];
    
    // add drawer view
    [self.drawerView setFrame:self.outFrame];
    [self.view addSubview:self.drawerView];
    
    // drawer list
//    [self.drawerView.drawerTableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)]; // statuesBarHeight+navBarHeight
//    self.drawerView.drawerTableView.dataSource = self;
//    self.drawerView.drawerTableView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"MenuCell" bundle:nil];
    MenuCell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    self.drawerView.drawerTableView.rowHeight = cell.frame.size.height;
    [self.drawerView.drawerTableView registerNib:nib forCellReuseIdentifier:@"MenuCell"];
    
    self.drawerView.drawerTableView.dataSource = self;
    self.drawerView.drawerTableView.delegate = self;
    
    
    [self.drawerView.Back_BTN addTarget:self action:@selector(BackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // gesture on self.view
    self.pan_gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveDrawer:)];
    self.pan_gr.maximumNumberOfTouches = 1;
    self.pan_gr.minimumNumberOfTouches = 1;
    //self.pan_gr.delegate = self;
    [self.view addGestureRecognizer:self.pan_gr];
    
    [self.view bringSubviewToFront:self.navigationBar];
    
//    for (id x in self.view.subviews){
//        NSLog(@"%@",NSStringFromClass([x class]));
//    }
}

-(void)BackClick:(id)sender
{
    [self closeNavigationDrawer];
}

- (void)drawerToggle
{
    if (!self.isOpen) {
        [self openNavigationDrawer];
    }else{
        [self closeNavigationDrawer];
    }
}

#pragma open and close action

- (void)openNavigationDrawer
{
//    NSLog(@"open x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    self.shawdowView.hidden = NO;
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:SHAWDOW_ALPHA];
                     }
                     completion:nil];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.drawerView.frame = self.inFrame;
                     }
                     completion:nil];
    
    self.isOpen= YES;
}

- (void)closeNavigationDrawer
{
//    NSLog(@"close x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         self.shawdowView.hidden = YES;
                     }];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.drawerView.frame = self.outFrame;
                     }
                     completion:nil];
    self.isOpen= NO;
}

#pragma gestures

- (void)tapOnShawdow:(UITapGestureRecognizer *)recognizer
{
    [self closeNavigationDrawer];
}

-(void)moveDrawer:(UIPanGestureRecognizer *)recognizer
{
    
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)recognizer velocityInView:self.view];
//    NSLog(@"velocity x=%f",velocity.x);
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateBegan)
    {
//        NSLog(@"start");
        if ( velocity.x > MENU_TRIGGER_VELOCITY && !self.isOpen) {
            [self openNavigationDrawer];
        }else if (velocity.x < -MENU_TRIGGER_VELOCITY && self.isOpen) {
            [self closeNavigationDrawer];
        }
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateChanged) {
//        NSLog(@"changing");
        float movingx = self.drawerView.center.x + translation.x;
        if ( movingx > -self.menuWidth/2 && movingx < self.menuWidth/2){
            
            self.drawerView.center = CGPointMake(movingx, self.drawerView.center.y);
            [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
            
            float changingAlpha = SHAWDOW_ALPHA/self.menuWidth*movingx+SHAWDOW_ALPHA/2; // y=mx+c
            self.shawdowView.hidden = NO;
            self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:changingAlpha];
        }
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateEnded) {
//        NSLog(@"end");
        if (self.drawerView.center.x>0){
            [self openNavigationDrawer];
        }else if (self.drawerView.center.x<0){
            [self closeNavigationDrawer];
        }
    }

}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *LineLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    LineLBL.backgroundColor=[UIColor colorWithRed:(209/255.0) green:(209/255.0) blue:(209/255.0) alpha:1.0];
    
    UILabel *TextLBL=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH, 15)];
    TextLBL.text=@"Communicate";
    TextLBL.font=[UIFont boldSystemFontOfSize:15];
    TextLBL.textColor=[UIColor colorWithRed:(109/255.0) green:(109/255.0) blue:(109/255.0) alpha:1.0];
    [headerView addSubview:TextLBL];

    [headerView addSubview:LineLBL];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 4)
    {
        return 35;
    }
    return 0.0; // you can have your own choice, of course
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SCREEN_HEIGHT==480)
    {
        return 44;
    }
    else
    {
        return 45;
    }
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 4)
    {
        return @"Communicate";
    }
    
    return @"";
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return TitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    if (indexPath.section==0)
    {
        cell.IconWidth.constant=19;
        cell.IconHeight.constant=15;
       // cell.IconX.constant=8;
        //cell.ImgLblGap.constant=16;
        
    }
    if (indexPath.section==1)
    {
        cell.IconWidth.constant=20;
        cell.IconHeight.constant=20;
       // cell.IconX.constant=8;
        //cell.ImgLblGap.constant=15.5;
        
    }
    if (indexPath.section==2)
    {
        cell.IconWidth.constant=20;
        cell.IconHeight.constant=20;
        // cell.IconX.constant=8;
        //cell.ImgLblGap.constant=15.5;
        
    }
    if (indexPath.row==3)
    {
        cell.IconWidth.constant=20;
        cell.IconHeight.constant=20;
        // cell.IconX.constant=8;
        //cell.ImgLblGap.constant=15.5;
        
    }
    
    /*
    
    
    if (indexPath.row==2)
    {
        cell.IconWidth.constant=14;
        cell.IconHeight.constant=14;
        cell.IconX.constant=8;
        cell.ImgLblGap.constant=19;
    }
    if (indexPath.row==3)
    {
        cell.IconWidth.constant=17;
        cell.IconHeight.constant=17;
        cell.IconX.constant=8;
        cell.ImgLblGap.constant=16;
    }
    if (indexPath.row==4)
    {
        cell.IconWidth.constant=14;
        cell.IconHeight.constant=13;
        cell.IconX.constant=8;
        cell.ImgLblGap.constant=19;
    }
    if (indexPath.row==5)
    {
        cell.IconWidth.constant=15;
        cell.IconHeight.constant=15;
        cell.IconX.constant=8;
        cell.ImgLblGap.constant=18;
    }
    if (indexPath.row==6)
    {
        cell.IconWidth.constant=14;
        cell.IconHeight.constant=20;
        cell.IconX.constant=8;
        cell.ImgLblGap.constant=18;
        
    }*/
    cell.Title_LBL.text=[TitleArr objectAtIndex:indexPath.section];
    cell.IconIMG.image=[UIImage imageNamed:[ImgArr objectAtIndex:indexPath.section]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row==0)
    {
        HomeVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeVW"];
        [super pushViewController:vcr animated:YES];
    }
    else if (indexPath.row==2)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Are you sure want to Logout?"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Logout",nil];
            alert.tag=50;
            [alert show];
    }
    else if (indexPath.row==3)
    {
        ProfileVIEW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileVIEW"];
        [super pushViewController:vcr animated:YES];
    }
    /*
    else if (indexPath.row==1)
    {
        MapNearbyPlace *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MapNearbyPlace"];
        [super pushViewController:vcr animated:YES];
    }
    else if (indexPath.row==2)
    {
        SearchByShop *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SearchByShop"];
        [super pushViewController:vcr animated:YES];
    }
    else if (indexPath.row==3)
    {
        if ([self.appDelegate isUserLoggedIn] == NO)
        {
            [self performSelector:@selector(checkLoginAndPresentContainer) withObject:nil afterDelay:0.0];
        }
        else
        {
            ShoppingCartView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShoppingCartView"];
            [super pushViewController:vcr animated:YES];
        }
        
    }
    else if (indexPath.row==4)
    {
        if ([self.appDelegate isUserLoggedIn] == NO)
        {
            [self performSelector:@selector(checkLoginAndPresentContainer) withObject:nil afterDelay:0.0];
        }
        else
        {
            OrderHistoryView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderHistoryView"];
            [super pushViewController:vcr animated:YES];
        }
        
    }
    else if (indexPath.row==5)
    {
        MyAccountVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MyAccountVW"];
        [super pushViewController:vcr animated:YES];
        
        //ProfileView *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileView"];
        //[super pushViewController:vcr animated:YES];
    }
    */
    [self closeNavigationDrawer];
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuCell *cell = (MenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    //[cell.Title_LBL setTextColor:[UIColor redColor]];
    return indexPath;
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // the user clicked Logout
    if (alertView.tag==50)
    {
        if (buttonIndex == 1)
        {
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"LoginUserDic"];
            [super popToRootViewControllerAnimated:NO];
        }
    }
}

-(void)checkLoginAndPresentContainer
{
    LogInVW *vcr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LogInVW"];
    [super  pushViewController:vcr animated:YES];
}

@end
