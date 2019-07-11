//
//  PostDetailsViewController.h
//  fbu-insta
//
//  Created by gilemos on 7/9/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostDetailsViewController : UIViewController
@property(strong, nonatomic) Post *tappedPost;
@property(strong, nonatomic)NSMutableArray *arrayOfComments;
@end

NS_ASSUME_NONNULL_END
