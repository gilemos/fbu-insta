//
//  ProfileCell.m
//  fbu-insta
//
//  Created by gilemos on 7/9/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //[self getCurrentUser];
    [self refreshData];
}

-(void)refreshData {
    self.usernameLabel.text = self.author.username;
}

//-(void)getCurrentUser {
//    if(self.author == nil){
//        self.author = [PFUser currentUser];
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
