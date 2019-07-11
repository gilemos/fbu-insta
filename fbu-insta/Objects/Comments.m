//
//  Comments.m
//  fbu-insta
//
//  Created by gilemos on 7/11/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "Comments.h"
#import "Post.h"

@implementation Comments
@dynamic commentsID;
@dynamic postID;
@dynamic commentText;
@dynamic arrayOfComments;

#pragma mark - posting comments
+ (void)postComment:(NSString * _Nullable )comment toPost:(Post *)post withCompletion:(PFBooleanResultBlock  _Nullable)completion {
    Comments *newComment = [Comments new];
    newComment.postID = [NSString stringWithFormat:@"%@", post.objectId];
    newComment.commentText = comment;
    [newComment saveInBackgroundWithBlock: completion];
}

#pragma mark - PFSubclass required method
+ (nonnull NSString *)parseClassName {
    return @"Comments";
}

//+ (void)getCommentsFromPost:(Post *)post intoArray:(NSMutableArray *)array{
//    
//    PFQuery *commentQuery = [Comments query];
//    [commentQuery orderByDescending:@"createdAt"];
//    [commentQuery includeKey:@"commentText"];
//    [commentQuery includeKey:@"postID"];
//    [commentQuery whereKey:@"postID" equalTo:post.objectId];
//    commentQuery.limit = 20;
//    
//    [commentQuery findObjectsInBackgroundWithBlock:^(NSArray<Comments *> * _Nullable comments, NSError * _Nullable error) {
//        if (comments) {
//            [array addObjectsFromArray:comments];
//        }
//        else {
//            NSLog(@"There was a problem getting the comments");
//        }
//    }];
//}


@end
