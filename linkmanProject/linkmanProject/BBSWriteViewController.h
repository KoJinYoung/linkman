//
//  BBSWriteViewController.h
//  linkmanProject
//
//  Created by 승원 김 on 12. 12. 5..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSWriteViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextView *BBSTextView;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *saveBBSButton;
- (IBAction)saveBBS:(id)sender;

@end
