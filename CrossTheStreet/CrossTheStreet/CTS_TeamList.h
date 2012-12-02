//
//  CTS_TeamViewController.h
//  CrossTheStreet
//
//  Created by 고진영 on 12. 9. 23..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTS_TeamListCell.h"

@interface CTS_TeamList : UIViewController<NSURLConnectionDataDelegate, NSURLConnectionDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate> {
    
    UITableView *tbl_TeamList;
    
    NSThread *thread_TeamList;
    
    NSDictionary *TeamDic;
    
    NSMutableArray *TeamListArr;
}
@property (nonatomic, retain) IBOutlet UITableView *tbl_TeamList;
@property (retain, nonatomic) IBOutlet UITextField *SearchBar;
@property (retain, nonatomic) NSMutableData *data_Team;
@property (retain, nonatomic) NSMutableArray *arr_TeamTitle;
@property (retain, nonatomic) NSMutableArray *arr_TeamAge;
@property (retain, nonatomic) NSMutableArray *arr_UserPic;
@end
