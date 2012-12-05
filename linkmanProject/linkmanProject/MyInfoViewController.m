//
//  MyInfoViewController.m
//  linkmanProject
//
//  Created by 승원 김 on 12. 12. 5..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import "MyInfoViewController.h"
#import "ModifyMyInfoViewController.h"
#import "AFNetworking.h"

@interface MyInfoViewController ()

@end

@implementation MyInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.rightBarButtonItem = _modifyInfoButton;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *urlString = @"http://incom.or.kr/ko28/?service=InfoMY&version=0";
    NSDictionary *httpParams = [[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"Token", @"my", @"Sort", nil];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
    NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:nil parameters:httpParams];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        //HTTP연동이 성공하였을 경우 서버로 부터 리턴된 값이 JSON이란 id형태로 리턴됩니다.
        NSLog(@"%@", JSON);
        
        infoDic = [JSON objectForKey:@"Data"];
        NSLog(@"%@, %@", [infoDic class], infoDic);
        
//        _userAge.text = [infoDic objectForKey:@"UserAge"];
//        _userNick.text = [infoDic objectForKey:@"UserNick"];
//        _userGender.text = [infoDic objectForKey:@"UserSex"];
//        _myCharacterTextView.delegate = self;
//        _myCharacterTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        _myCharacterTextView.text = [infoDic objectForKey:@"UserIntro"];
//        _userDuty.text = [infoDic objectForKey:@"UserRole"];
//        _userAlcoholLevel.text = [infoDic objectForKey:@"UserLevel"];
//        _howAboutPay.text = [infoDic objectForKey:@"UserPay"];

    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"실패:%@",error);
        //실패시 처리.
    }];
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_modifyInfoButton release];
    [_userNick release];
    [_userGender release];
    [_myCharacterTextView release];
    [_userDuty release];
    [_userAlcoholLevel release];
    [_howAboutPay release];
    [_userAge release];
    [super dealloc];
}
- (IBAction)modifyInfo:(id)sender {
    ModifyMyInfoViewController *modifyMyInfoViewController = [[ModifyMyInfoViewController alloc] initWithNibName:@"ModifyMoInfoViewController" bundle:nil];
    [self.navigationController pushViewController:modifyMyInfoViewController animated:YES];
    [modifyMyInfoViewController release];
}


@end