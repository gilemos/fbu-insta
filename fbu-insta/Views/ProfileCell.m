//
//  ProfileCell.m
//  fbu-insta
//
//  Created by gilemos on 7/9/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

#pragma mark - View Lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    [self refreshData];
}

#pragma mark - Methods to update data
-(void)refreshData {
    self.usernameLabel.text = self.author.username;
}

#pragma mark - Helper methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
