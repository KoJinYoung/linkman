//
//  CTS_TeamCell.h
//  CrossTheStreet
//
//  Created by 고진영 on 12. 12. 3..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTS_TeamCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image_UserPic;
@property (weak, nonatomic) IBOutlet UILabel *label_nick;
@property (weak, nonatomic) IBOutlet UILabel *label_age;
@property (weak, nonatomic) IBOutlet UILabel *label_intro;

@end
