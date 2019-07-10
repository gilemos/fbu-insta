//
//  PostCell.m
//  fbu-insta
//
//  Created by gilemos on 7/8/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"
#import <Parse/Parse.h>
#import "PFImageView.h"

@implementation PostCell

#pragma mark - View lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - updating methods
- (void)refreshData {
    self.postImage.file = self.post.image;
    [self.postImage loadInBackground];
    self.postTextField.text = self.post.caption;
    self.profilePhoto.layer.cornerRadius = 25;;
    self.profilePhoto.clipsToBounds = YES;
    self.profilePhoto.file = self.post.author[@"profilePicture"];
    [self.profilePhoto loadInBackground];
    self.userNameLabel.text = self.post.author.username;
}

#pragma mark - Helper methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
