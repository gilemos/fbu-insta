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
#import "DateTools.h"

@implementation PostCell

#pragma mark - View lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - Methods to Update Data
- (void)refreshData {
    self.postImage.file = self.post.image;
    [self.postImage loadInBackground];
    self.profilePhoto.layer.cornerRadius = 25;;
    self.profilePhoto.clipsToBounds = YES;
    self.profilePhoto.file = self.post.author[@"profilePicture"];
    [self.profilePhoto loadInBackground];
    
    self.userNameLabel.text = self.post.author.username;
    self.postTextField.text = self.post.caption;
    self.timeLabel.text = self.post.timeOfPosting.shortTimeAgoSinceNow;
    self.numberOfLikesLabel.text = [NSString stringWithFormat:@"%@ likes", self.post.likeCount];
    if(self.post.isLiked) {
        self.loveButton.selected = YES;
    }
}

#pragma mark - User interaction buttons
- (IBAction)didTapLike:(id)sender {
    if(self.post.isLiked) {
        self.post.isLiked = NO;
        self.loveButton.selected = NO;
        
        int likeCountInt = [self.post.likeCount intValue];
        likeCountInt -= 1;
        self.post.likeCount = [NSNumber numberWithInt:likeCountInt];
    }
    else {
        self.post.isLiked = YES;
        self.loveButton.selected = YES;
        
        int likeCountInt = [self.post.likeCount intValue];
        likeCountInt += 1;
        self.post.likeCount = [NSNumber numberWithInt:likeCountInt];
    }
    [Post updatePost:self.post withLikeCount:self.post.likeCount];
    [self refreshData];
}

#pragma mark - Helper methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
