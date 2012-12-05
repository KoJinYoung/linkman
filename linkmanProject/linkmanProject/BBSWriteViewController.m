//
//  BBSWriteViewController.m
//  linkmanProject
//
//  Created by 승원 김 on 12. 12. 5..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import "BBSWriteViewController.h"
#import "AFNetworking.h"

@interface BBSWriteViewController ()

@end

@implementation BBSWriteViewController

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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = _saveBBSButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_BBSTextView release];
    [_saveBBSButton release];
    [super dealloc];
}
- (IBAction)saveBBS:(id)sender {
    if (!_BBSTextView.text) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"내용이 없습니다" message:@"내용을 확인해주세요" delegate:self cancelButtonTitle:@"네" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else {
        NSString *urlString = @"http://incom.or.kr/ko28/?service=BBSWrite&version=0";
        NSDictionary *httpParams = [[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"Token", @" ", @"BBSIdx", _BBSTextView.text, @"BBS", nil];

        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
        NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:nil parameters:httpParams];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
            //HTTP연동이 성공하였을 경우 서버로 부터 리턴된 값이 JSON이란 id형태로 리턴됩니다.
            NSLog(@"%@", JSON);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"등록 성공" message:@"등록 되었습니다" delegate:self cancelButtonTitle:@"네" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
            
            NSLog(@"실패:%@",error);
            //실패시 처리.
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"등록 실패" message:@"다시 등록해주세요" delegate:self cancelButtonTitle:@"네" otherButtonTitles:nil];
            [alertView show];
            [alertView release];

            
        }];
        [operation start];
    }
}
@end
