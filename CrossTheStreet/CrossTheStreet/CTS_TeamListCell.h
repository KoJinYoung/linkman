//
//  CTS_CellTeamList.h
//  CrossTheStreet
//
//  Created by 고진영 on 12. 11. 27..
//  Copyright (c) 2012년 LinkMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTS_TeamListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cell_title_lable;
@property (weak, nonatomic) IBOutlet UILabel *cell_age_lable;
@property (weak, nonatomic) IBOutlet UILabel *cell_num_lable;
@property (weak, nonatomic) IBOutlet UIImageView *cell_userpic1_image;
@property (weak, nonatomic) IBOutlet UIImageView *cell_userpic2_image;
@property (weak, nonatomic) IBOutlet UIImageView *cell_userpic3_image;
@property (weak, nonatomic) IBOutlet UIImageView *cell_userpic4_image;
@property (weak, nonatomic) IBOutlet UIImageView *cell_userpic5_image;
@property NSString *team_idx;
@end
