//
//  ViewController.m
//  linkmanProject
//
//  Created by 승원 김 on 12. 12. 4..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import "ViewController.h"
#import "BBSViewController.h"
#import "MyInfoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_BbsButton release];
    [_profileButton release];
    [super dealloc];
}
- (IBAction)showBbsList:(id)sender {
    BBSViewController *bbsViewController = [[BBSViewController alloc] initWithNibName:@"BBSViewController" bundle:nil];
    [self.navigationController pushViewController:bbsViewController animated:YES];
    [bbsViewController release];
}

- (IBAction)showProfile:(id)sender {
    MyInfoViewController *myInfoViewController = [[MyInfoViewController alloc] initWithNibName:@"MyInfoViewController" bundle:nil];
    [self.navigationController pushViewController:myInfoViewController animated:YES];
    [myInfoViewController release];
}
@end
