//
//  MakeCommentCell.m
//  fbu-insta
//
//  Created by gilemos on 7/10/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "MakeCommentCell.h"
#import "Post.h"
#import "Comments.h"

@implementation MakeCommentCell

#pragma mark - View Lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Post method
- (IBAction)didTapPost:(id)sender {
    NSString *comment = self.commentField.text;
    if(comment != nil) {
        [Comments postComment:comment toPost:self.post withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"Comment posted");
            self.commentField.text = nil;
            [Post incrementCommentCountOfPost:self.post];
        }];
    }
}

#pragma mark - Support methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
