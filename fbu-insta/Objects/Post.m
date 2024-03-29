//
//  Post.m
//  fbu-insta
//
//  Created by gilemos on 7/8/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "Post.h"

@implementation Post
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic timeOfPosting;
@dynamic isLiked;


#pragma mark - Posting new things
+ (void)postUserImage:(UIImage * _Nullable )image withCaption:(NSString * _Nullable)caption withCompletion:(PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    NSDate *now = [NSDate date];
    newPost.timeOfPosting = now;
    
    [newPost saveInBackgroundWithBlock: completion];
}

#pragma mark - Updating methods
+ (void)updatePost:(Post *)post withLikeCount:(NSNumber *)likeCount {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    
    [query getObjectInBackgroundWithId:post.objectId
                                 block:^(PFObject *myPost, NSError *error) {
                                     myPost[@"likeCount"] = likeCount;
                                     [myPost saveInBackground];
                                 }];
}

+ (void)incrementCommentCountOfPost:(Post *)post {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    
    [query getObjectInBackgroundWithId:post.objectId
                                 block:^(PFObject *myPost, NSError *error) {
                                     int commentCountInt = [myPost[@"commentCount"] intValue];
                                     commentCountInt += 1;
                                     myPost[@"commentCount"] = [NSNumber numberWithInt:commentCountInt];
                                     [myPost saveInBackground];
                                 }];
 
}

+ (void)updateProfileofUser:(PFUser *)user withImage:(UIImage *)image withCompletion:(PFBooleanResultBlock  _Nullable)completion {
    user[@"profilePicture"] = [self getPFFileFromImage:image];
    [user saveInBackground];
}

#pragma mark - Overall helper methods
+ (PFFileObject *)getPFFileFromImage:(UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

+ (nonnull NSString *)parseClassName {
    return @"Post";
}
@end

