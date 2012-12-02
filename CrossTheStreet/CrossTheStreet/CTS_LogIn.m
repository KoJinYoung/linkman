//
//  CTS_LogIn.m
//  CrossTheStreet
//
//  Created by 고진영 on 12. 11. 29..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import "CTS_LogIn.h"

@interface CTS_LogIn ()

@end

@implementation CTS_LogIn
@synthesize strEmail;
@synthesize strPassword;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionLogin:(id)sender {
}
@end
