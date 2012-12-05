//
//  BBSListCell.m
//  linkmanProject
//
//  Created by 승원 김 on 12. 12. 5..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import "BBSListCell.h"

@implementation BBSListCell

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

- (void)dealloc {
    [_profileImageView release];
    [_commentLabel release];
    [_userNickLabel release];
    [_timeLabel release];
    [_contentTextView release];
    [super dealloc];
}
@end
