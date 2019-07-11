//
//  Comments.h
//  fbu-insta
//
//  Created by gilemos on 7/11/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import <Parse/Parse.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comments : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *commentsID;
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *commentText;
@property (nonatomic, strong) NSMutableArray *arrayOfComments;

+ (void)postComment:(NSString * _Nullable )comment toPost:(Post *)post withCompletion:(PFBooleanResultBlock  _Nullable)completion;
+ (void)getCommentsFromPost:(Post *)post intoArray:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
