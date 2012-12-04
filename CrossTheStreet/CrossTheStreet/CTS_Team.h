//
//  CTS_TeamController.h
//  CrossTheStreet
//
//  Created by 고진영 on 12. 10. 19..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTS_Team : UIViewController {
    NSString *teamIdx;
}
- (IBAction)actionTeamEdit:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *NavigationBar;
@property (weak, nonatomic) IBOutlet UIView *NavTitleView;
@property (weak, nonatomic) IBOutlet UITableView *tblMemberList;
@property (nonatomic, retain) NSString *teamIdx;
- (IBAction)action_backtomain:(id)sender;

@end
