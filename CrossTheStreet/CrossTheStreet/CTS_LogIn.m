//
//  CTS_LogIn.m
//  CrossTheStreet
//
//  Created by 고진영 on 12. 11. 29..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import "CTS_LogIn.h"

#import "CTS_SingletonObject.h"

@interface CTS_LogIn ()

@end

@implementation CTS_LogIn
@synthesize strEmail;
@synthesize strPassword;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionLogin:(id)sender {
    
    NSString *token = nil;
    
    CTS_SingletonObject *singletonObj = [CTS_SingletonObject getSingletonObject];
    
    [singletonObj setToken:token];
    
    BOOL isWritten = [singletonObj saveStringToFile];
    
    if (isWritten) {
        NSLog(@"success to save token");
    }
    else {
        NSLog(@"fail to save token");
    }
    
}
@end
