//
//  BBSListCell.h
//  linkmanProject
//
//  Created by 승원 김 on 12. 12. 5..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSListCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *profileImageView;
@property (nonatomic, retain) IBOutlet UITextView *contentTextView;
@property (nonatomic, retain) IBOutlet UILabel *userNickLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UILabel *commentLabel;


@end
