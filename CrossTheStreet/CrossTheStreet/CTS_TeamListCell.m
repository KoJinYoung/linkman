//
//  CTS_CellTeamList.m
//  CrossTheStreet
//
//  Created by 고진영 on 12. 11. 27..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import "CTS_TeamListCell.h"

@implementation CTS_TeamListCell
@synthesize cell_title_lable;
@synthesize cell_age_lable;
@synthesize cell_num_lable;
@synthesize cell_userpic1_image;
@synthesize cell_userpic2_image;
@synthesize cell_userpic3_image;
@synthesize cell_userpic4_image;
@synthesize cell_userpic5_image;
@synthesize team_idx;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
