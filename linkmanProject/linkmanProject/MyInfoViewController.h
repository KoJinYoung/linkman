//
//  MyInfoViewController.h
//  linkmanProject
//
//  Created by 승원 김 on 12. 12. 5..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate> {
    NSMutableDictionary *infoDic;
}
@property (retain, nonatomic) NSString *sortString; // my이면 내정보 UserIdx이면 다른 유저
@property (retain, nonatomic) IBOutlet UIBarButtonItem *modifyInfoButton;
@property (retain, nonatomic) IBOutlet UILabel *userNick;
@property (retain, nonatomic) IBOutlet UILabel *userAge;
@property (retain, nonatomic) IBOutlet UILabel *userGender;
@property (retain, nonatomic) IBOutlet UITextView *myCharacterTextView;
@property (retain, nonatomic) IBOutlet UILabel *userDuty;
@property (retain, nonatomic) IBOutlet UILabel *userAlcoholLevel;
@property (retain, nonatomic) IBOutlet UILabel *howAboutPay;
- (IBAction)modifyInfo:(id)sender;

@end
