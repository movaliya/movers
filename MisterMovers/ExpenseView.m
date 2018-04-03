//
//  ExpenseView.m
//  MisterMovers
//
//  Created by kaushik on 11/02/18.
//  Copyright © 2018 jkinfoway. All rights reserved.
//

#import "ExpenseView.h"
#import "misterMover.pch"

@interface ExpenseView ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *JobArr,*ExpenseArr,*FeaulPaymentArr,*HelperArr;
    NSString *SelectedTextfield;
    NSMutableDictionary *jobDict;
    NSMutableDictionary *HelperDetailDict;
}
@end

@implementation ExpenseView
@synthesize JobView,JobTXT,ExpenseTXT,RemarkTXT,RemarkView,ExpenseView,AmountTXT,AmountView,InfoView;
@synthesize SelectJobTBL,JobTableTop;
@synthesize OtherView,OtherAmount_TXT,OtherRemark_TXT;
@synthesize FealView,FealAmoutTop,FeaulUploadinvoise_BTN,ScrollHight,FeaulPaymentType_TXT;
@synthesize Helper_TXT,HelperView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    SelectedTextfield=@"OTHER";
    
    JobArr=[[NSMutableArray alloc] initWithObjects:@"John",@"Marko",@"Fabio", nil];
    
    HelperArr=[[NSMutableArray alloc] initWithObjects:@"Lisa",@"Jaini",@"Laura", nil];
    ExpenseArr=[[NSMutableArray alloc] initWithObjects:@"Fuel and oil",@"Helper",@"Other", nil];
    FeaulPaymentArr=[[NSMutableArray alloc] initWithObjects:@"Please select payment type",@"Cash", nil];
    SelectJobTBL.layer.cornerRadius=3.0f;
    SelectJobTBL.layer.borderColor=[[UIColor blueColor] CGColor];
    SelectJobTBL.layer.borderWidth=1.0f;
    SelectJobTBL.hidden=YES;
    
    FealView.hidden=YES;
    HelperView.hidden=YES;
    ScrollHight.constant=490.0f;
    
    
    [InfoView.layer setShadowColor:[UIColor blackColor].CGColor];
    [InfoView.layer setShadowOpacity:0.8];
    [InfoView.layer setShadowRadius:2.0];
    [InfoView.layer setShadowOffset:CGSizeMake(1.0,1.0)];
    
    [KmyappDelegate SettextfieldViewBorder:JobView];
    [KmyappDelegate SettextfieldViewBorder:ExpenseView];
    [KmyappDelegate SettextfieldViewBorder:RemarkView];
    [KmyappDelegate SettextfieldViewBorder:AmountView];
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetJobList];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];

}
-(void)GetJobList
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Get_Task  forKey:@"s"];
    
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    [dictParams setObject:@"expense_all_task"  forKey:@"type"];
    
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleJobListResponse:response];
     }];
}

- (void)handleJobListResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        jobDict=[[response valueForKey:@"result"] mutableCopy];
        [SelectJobTBL reloadData];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
-(void)Get_Task_Detail:(NSString *)TaskId
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Get_Detail_Task  forKey:@"s"];
    [dictParams setObject:TaskId  forKey:@"tid"];
    
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleTaskDetailResponse:response];
     }];
}
- (void)handleTaskDetailResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        NSMutableDictionary *result=[[response valueForKey:@"result"] mutableCopy];
        HelperDetailDict=[[result valueForKey:@"helpers_details"] mutableCopy];
        [SelectJobTBL reloadData];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (IBAction)Back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    SelectJobTBL.hidden=YES;
    if (textField==JobTXT)
    {
        if (jobDict.count==0)
        {
            [AppDelegate showErrorMessageWithTitle:@"Alert" message:@"No Job Found." delegate:nil];
        }
        else
        {
            //ExpenseTXT.text=@"Please Select Expense Type.";
            SelectedTextfield=@"OTHER";
            JobTableTop.constant=0.0f;
            SelectJobTBL.hidden=NO;
            [SelectJobTBL reloadData];
        }
       
        return NO;
    }
    if (textField==ExpenseTXT)
    {
        if (taskID==nil)
        {
            [AppDelegate showErrorMessageWithTitle:@"Alert" message:@"Please Select Job First." delegate:nil];
        }
        else
        {
            SelectedTextfield=@"EXPENSE";
            SelectJobTBL.hidden=NO;
            JobTableTop.constant=89.0f;
            [SelectJobTBL reloadData];
        }
        
        return NO;
    }
    if (textField==FeaulPaymentType_TXT)
    {
        SelectedTextfield=@"FeaulPaymentType";
        SelectJobTBL.hidden=NO;
        JobTableTop.constant=265.0f;
        [SelectJobTBL reloadData];
        return NO;
    }
    if (textField==Helper_TXT)
    {
        if (HelperDetailDict.count==0)
        {
            [AppDelegate showErrorMessageWithTitle:@"Alert" message:@"There is No Helper." delegate:nil];
        }
        else
        {
            SelectedTextfield=@"HELPER";
            SelectJobTBL.hidden=NO;
            JobTableTop.constant=175.0f;
            [SelectJobTBL reloadData];
        }
        
        return NO;
    }
    return YES;
}

#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==SelectJobTBL)
    {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==SelectJobTBL)
    {
        if ([SelectedTextfield isEqualToString:@"OTHER"])
        {
            return jobDict.count;
        }
        else if ([SelectedTextfield isEqualToString:@"EXPENSE"])
        {
            return ExpenseArr.count;
        }
        else if ([SelectedTextfield isEqualToString:@"HELPER"])
        {
            return HelperDetailDict.count;
        }
        else
        {
            return FeaulPaymentArr.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==SelectJobTBL)
    {
        static NSString *CellIdentifier1 = @"Cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        cell=nil;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.accessoryView = nil;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if ([SelectedTextfield isEqualToString:@"OTHER"])
        {
            cell.textLabel.text=[[jobDict valueForKey:@"task_title"] objectAtIndex:indexPath.row];
        }
        else if ([SelectedTextfield isEqualToString:@"EXPENSE"])
        {
            cell.textLabel.text=[ExpenseArr objectAtIndex:indexPath.row];
        }
        else if ([SelectedTextfield isEqualToString:@"HELPER"])
        {
            cell.textLabel.text=[[HelperDetailDict valueForKey:@"employee_name"] objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text=[FeaulPaymentArr objectAtIndex:indexPath.row];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectJobTBL.hidden=YES;
    if (tableView==SelectJobTBL)
    {
        if ([SelectedTextfield isEqualToString:@"OTHER"])
        {
            
            JobTXT.text=[[jobDict valueForKey:@"task_title"] objectAtIndex:indexPath.row];
            taskID=[NSString stringWithFormat:@"%@",[[jobDict valueForKey:@"id"] objectAtIndex:indexPath.row]];
            
            if ([ExpenseTXT.text isEqualToString:@"Helper"])
            {
                 Helper_TXT.text=@"";
                BOOL internet=[AppDelegate connectedToNetwork];
                if (internet)
                    [self Get_Task_Detail:taskID];
                else
                    [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
            }
            
            if ([[jobDict valueForKey:@"task_vehicle_no"] objectAtIndex:indexPath.row] != (id)[NSNull null])
            {
               VehicleNameSTR=[NSString stringWithFormat:@"%@",[[jobDict valueForKey:@"task_vehicle_no"] objectAtIndex:indexPath.row]];
                self.FuelVehicleName_TXT.text=VehicleNameSTR;
                VehicleID=[NSString stringWithFormat:@"%@",[[jobDict valueForKey:@"task_vehicle_id"] objectAtIndex:indexPath.row]];
            }
        }
        else if ([SelectedTextfield isEqualToString:@"FeaulPaymentType"])
        {
            FeaulPaymentType_TXT.text=[FeaulPaymentArr objectAtIndex:indexPath.row];

            HelperView.hidden=YES;
            OtherView.hidden=YES;
            FealView.hidden=NO;
            
            if ([FeaulPaymentType_TXT.text isEqualToString:@"Cash"])
            {
                FeaulUploadinvoise_BTN.hidden=NO;
                FealAmoutTop.constant=70;
                ScrollHight.constant=720.0f;
            }
            else
            {
                FeaulUploadinvoise_BTN.hidden=YES;
                FealAmoutTop.constant=10;
                ScrollHight.constant=670.0f;
            }
        }
        else if ([SelectedTextfield isEqualToString:@"HELPER"])
        {
            Helper_TXT.text=[[HelperDetailDict valueForKey:@"employee_name"] objectAtIndex:indexPath.row];
            helperID=[NSString stringWithFormat:@"%@",[[HelperDetailDict valueForKey:@"id"] objectAtIndex:indexPath.row]];
        }
        else
        {
            if (taskID == nil)
            {
                [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please select Job first." delegate:nil];
            }
            else
            {
                ExpenseTXT.text=[ExpenseArr objectAtIndex:indexPath.row];
            }
            if ([ExpenseTXT.text isEqualToString:@"Fuel and oil"])
            {
                HelperView.hidden=YES;
                OtherView.hidden=YES;
                FealView.hidden=NO;
                FeaulUploadinvoise_BTN.hidden=YES;
                FealAmoutTop.constant=10;
                ScrollHight.constant=680.0f;
                self.FuelVehicleName_TXT.text=VehicleNameSTR;
                if (VehicleNameSTR)
                {
                    self.FuelVehicleName_TXT.enabled=NO;
                }
                else
                {
                     self.FuelVehicleName_TXT.enabled=YES;
                }
               
            }
            else if ([ExpenseTXT.text isEqualToString:@"Helper"])
            {
                if (taskID == nil)
                {
                    [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please select Job first." delegate:nil];
                }
                else
                {
                    Helper_TXT.text=@"";
                    BOOL internet=[AppDelegate connectedToNetwork];
                    if (internet)
                        [self Get_Task_Detail:taskID];
                    else
                        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
                    OtherView.hidden=YES;
                    FealView.hidden=YES;
                    HelperView.hidden=NO;
                    
                    ScrollHight.constant=570.0f;
                }
               
                
            }
            else if ([ExpenseTXT.text isEqualToString:@"Other"])
            {
                HelperView.hidden=YES;
                OtherView.hidden=NO;
                FealView.hidden=YES;
                ScrollHight.constant=490.0f;
            }
        }
    }
}
- (IBAction)FuelSubmitBtn_Click:(id)sender
{
    if (taskID == nil)
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please Select Job." delegate:nil];
    }
    else if ([ExpenseTXT.text isEqualToString:@"Please Select Expense Type"])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please Select Expense Type." delegate:nil];
    }
    else if (VehicleID == nil)
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Vehicle Name" delegate:nil];
    }
    else if ([FeaulPaymentType_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please Select Payment Type." delegate:nil];
    }
    else if ([FeaulPaymentType_TXT.text isEqualToString:@"Please select payment type"])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please Select Payment Type." delegate:nil];
    }
    else if ([self.FuelAmount_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Amount." delegate:nil];
    }
    else
    {
        if ([FeaulPaymentType_TXT.text isEqualToString:@"Cash"])
        {
            if (chosenImage)
            {
                NSData *photoData = UIImageJPEGRepresentation(chosenImage, 0.8);
                BOOL internet=[AppDelegate connectedToNetwork];
                if (internet)
                    [self CashFuelAddExpense:photoData];
                else
                    [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
            }
            else
            {
                [AppDelegate showErrorMessageWithTitle:@"" message:@"Please Upload Invoice" delegate:nil];
            }
            
        }
        else
        {
            BOOL internet=[AppDelegate connectedToNetwork];
            if (internet)
                [self CardFuelAddExpenseService];
            
            else
                [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
        }
        
    }
}
-(void)CardFuelAddExpenseService
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init]; //Fuel Helper Others
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Add_Expense  forKey:@"s"];
    [dictParams setObject:taskID  forKey:@"tid"];
    [dictParams setObject:@"Fuel"  forKey:@"type"];
    [dictParams setObject:VehicleID  forKey:@"vehical_id"];
    [dictParams setObject:self.FuelRemark_TXT.text  forKey:@"remark"];
    [dictParams setObject:self.FuelAmount_TXT.text  forKey:@"amount"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    [dictParams setObject:@""  forKey:@"helper_id"];
    [dictParams setObject:@"card"  forKey:@"payment_type"];
    [dictParams setObject:@""  forKey:@"invoice_file"];
    
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleCardFuelAddExpenseResponse:response];
     }];
}
- (void)handleCardFuelAddExpenseResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (IBAction)HelperSubmitBtn_Click:(id)sender
{
    
    if (taskID == nil)
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please Select Job." delegate:nil];
    }
    else if ([ExpenseTXT.text isEqualToString:@"Please Select Expense Type"])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please Select Expense Type." delegate:nil];
    }
    else if ([Helper_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please Select Helper." delegate:nil];
    }
    else if ([self.helperAmount_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Amount." delegate:nil];
    }
    else
    {
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
            [self HelperAddExpenseService];
        
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
        
    }
}

-(void)HelperAddExpenseService
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init]; //Fuel Helper Others
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Add_Expense  forKey:@"s"];
    [dictParams setObject:taskID  forKey:@"tid"];
    [dictParams setObject:@"Helper"  forKey:@"type"];
    [dictParams setObject:@""  forKey:@"vehical_id"];
    [dictParams setObject:self.helperRemarkTXT.text  forKey:@"remark"];
    [dictParams setObject:self.helperAmount_TXT.text  forKey:@"amount"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    [dictParams setObject:helperID  forKey:@"helper_id"];
    [dictParams setObject:@""  forKey:@"payment_type"];
    [dictParams setObject:@""  forKey:@"invoice_file"];
    
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleHelperAddExpenseResponse:response];
     }];
}
- (void)handleHelperAddExpenseResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (IBAction)OtherSubmitBtn_Click:(id)sender
{
    if (taskID == nil)
    {
       [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please select job." delegate:nil];
    }
    else if ([ExpenseTXT.text isEqualToString:@"Please Select Expense Type"])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please select expense type." delegate:nil];
    }
    else if ([OtherAmount_TXT.text isEqualToString:@""])
    {
        
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter amount." delegate:nil];
    }
    else
    {
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
            [self OtherAddExpenseService];

        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    }
}
-(void)OtherAddExpenseService
{
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init]; //Fuel Helper
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Add_Expense  forKey:@"s"];
    [dictParams setObject:taskID  forKey:@"tid"];
    [dictParams setObject:@"Others"  forKey:@"type"];
    [dictParams setObject:@""  forKey:@"vehical_id"];
    [dictParams setObject:OtherRemark_TXT.text  forKey:@"remark"];
    [dictParams setObject:OtherAmount_TXT.text  forKey:@"amount"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    [dictParams setObject:@""  forKey:@"helper_id"];
    [dictParams setObject:@""  forKey:@"payment_type"];
    [dictParams setObject:@""  forKey:@"invoice_file"];
    
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleOtherExpenseResponse:response];
     }];
}
- (void)handleOtherExpenseResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}


-(void)CashFuelAddExpense:(NSData *)imageData
{
     [KVNProgress show];
    NSDictionary *UserSaveData=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserDic"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:Add_Expense  forKey:@"s"];
    [dictParams setObject:taskID  forKey:@"tid"];
    [dictParams setObject:@"Fuel"  forKey:@"type"];
    [dictParams setObject:VehicleID  forKey:@"vehical_id"];
    [dictParams setObject:self.FuelRemark_TXT.text  forKey:@"remark"];
    [dictParams setObject:self.FuelAmount_TXT.text  forKey:@"amount"];
    [dictParams setObject:[UserSaveData valueForKey:@"id"]  forKey:@"eid"];
    [dictParams setObject:@""  forKey:@"helper_id"];
    [dictParams setObject:@"cash"  forKey:@"payment_type"];
    //[dictParams setObject:@""  forKey:@"invoice_file"];
    
    [manager.requestSerializer setValue:@"application/json; text/html" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    [manager POST:[NSString stringWithFormat:@"%@",BaseUrl] parameters:dictParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         [formData appendPartWithFileData:imageData name:@"invoice_file" fileName:@"signature.jpeg" mimeType:@"image/jpeg"];
     }
         progress:^(NSProgress * _Nonnull uploadProgress)
     {
     }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [KVNProgress dismiss];

         NSLog(@"JSON: %@", responseObject);
         if ([[[responseObject objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
         {
             [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[responseObject objectForKey:@"ack_msg"] delegate:nil];
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
         {
             [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[responseObject objectForKey:@"ack_msg"] delegate:nil];
         }
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError*  _Nonnull error)
     {
         NSLog(@"%@",error.localizedDescription);
         [KVNProgress dismiss];
         
     }];
    
}
- (IBAction)UploadInvoiceBtn_Click:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Choose From" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Cemera button tapped.
        
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
             [AppDelegate showErrorMessageWithTitle:@"Error" message:@"Device has no camera." delegate:nil];
            
        }
        else{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = NO;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
        
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Gallery button tapped.
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }]];

    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // output image
    chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
@end
