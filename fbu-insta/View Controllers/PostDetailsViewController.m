//
//  PostDetailsViewController.m
//  fbu-insta
//
//  Created by gilemos on 7/9/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "PostDetailsViewController.h"
#import <Parse/Parse.h>
#import "PFimageView.h"
#import "DateTools.h"
#import "Post.h"

@interface PostDetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet UITextField *caption;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLovesLabel;
@end

@implementation PostDetailsViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshPost];
}

#pragma mark - refresh methods
-(void)refreshPost {
    self.postImage.file = self.post.image;
    self.caption.text = self.post.caption;
    self.usernameLabel.text = self.post.author.username;
    self.timeStampLabel.text = self.post.timeOfPosting.shortTimeAgoSinceNow;
    self.numberOfLovesLabel.text = [NSString stringWithFormat:@"<3 %@ likes", self.post.likeCount];
    if(self.post.isLiked) {
        self.loveButton.selected = YES;
    }
}


#pragma mark - User interaction buttons
- (IBAction)didTapLove:(id)sender {
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
    [self refreshPost];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
