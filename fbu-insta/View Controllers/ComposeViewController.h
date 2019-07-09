//
//  ComposeViewController.h
//  fbu-insta
//
//  Created by gilemos on 7/8/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol composeViewControllerDelegate
-(void)getNewPost:(Post *) post;
@end

@interface ComposeViewController : UIViewController
@property(nonatomic, weak) id<composeViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
