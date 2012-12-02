//
//  CTS_LogIn.h
//  CrossTheStreet
//
//  Created by 고진영 on 12. 11. 29..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTS_LogIn : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *strEmail;
@property (weak, nonatomic) IBOutlet UITextField *strPassword;
- (IBAction)actionLogin:(id)sender;

@end
