//
//  PostCell.h
//  fbu-insta
//
//  Created by gilemos on 7/8/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>
#import "PFimageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *profilePhoto;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextField *postTextField;
@property(strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

-(void)refreshData;
@end

NS_ASSUME_NONNULL_END
