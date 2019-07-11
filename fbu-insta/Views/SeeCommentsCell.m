//
//  SeeCommentsCell.m
//  fbu-insta
//
//  Created by gilemos on 7/10/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "SeeCommentsCell.h"

@implementation SeeCommentsCell

#pragma mark - View lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - Data updating
- (void)refreshData {
    self.commentLabel.text = self.currentComment[@"commentText"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
