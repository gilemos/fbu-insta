//
//  MakeCommentCell.m
//  fbu-insta
//
//  Created by gilemos on 7/10/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "MakeCommentCell.h"
#import "Post.h"

@implementation MakeCommentCell

#pragma mark - View Lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Post method
- (IBAction)didTapPost:(id)sender {
    NSString *comment = self.commentField.text;
    [Post updatePost:self.post withComment:comment];
}

#pragma mark - Support methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
