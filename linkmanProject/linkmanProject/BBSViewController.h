//
//  BBSViewController.h
//  linkmanProject
//
//  Created by 승원 김 on 12. 12. 4..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface BBSViewController : UIViewController <UITextViewDelegate> {
    NSOperationQueue *queue;
    
//    NSMutableDictionary *BBSListDic;
    NSMutableArray *BBSListArray;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
