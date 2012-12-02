//
//  CTS_TeamController.m
//  CrossTheStreet
//
//  Created by 고진영 on 12. 10. 19..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import "CTS_Team.h"
#import "CTS_CommonValues.h"

@interface CTS_Team ()

@end

@implementation CTS_Team
@synthesize teamIdx;

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
    
    NSLog(@"teamIdx:%@", teamIdx);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 팀 정보 수정
- (IBAction)actionTeamEdit:(id)sender {
}

#pragma mark - 뒤로가기
- (IBAction)action_backtomain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
