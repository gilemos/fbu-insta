//
//  PostCell.m
//  fbu-insta
//
//  Created by gilemos on 7/8/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"

@implementation PostCell

#pragma mark - View lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - updating methods
- (void)refreshData {
    self.postImage.image = self.post.image;
    self.postTextField.text = self.post.caption;
}

#pragma mark - Helper methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
