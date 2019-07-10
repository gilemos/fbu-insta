//
//  Post.h
//  fbu-insta
//
//  Created by gilemos on 7/8/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;
@property (nonatomic, strong) NSDate *timeOfPosting;
@property (nonatomic) bool isLiked;

+ (void)postUserImage:( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+ (void)updatePost:(Post *)post withLikeCount:(NSNumber *)likeCount;
+ (PFFileObject *)getPFFileFromImage:(UIImage * _Nullable)image;
+ (void)updateProfileofUser:(PFUser *)user withImage:(UIImage *)image withCompletion:(PFBooleanResultBlock  _Nullable)completion;
@end


NS_ASSUME_NONNULL_END
