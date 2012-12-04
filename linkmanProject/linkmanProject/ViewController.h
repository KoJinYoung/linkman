//
//  ViewController.h
//  linkmanProject
//
//  Created by 승원 김 on 12. 12. 4..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIButton *BbsButton;
@property (retain, nonatomic) IBOutlet UIButton *profileButton;
- (IBAction)showBbsList:(id)sender;
- (IBAction)showProfile:(id)sender;

@end
