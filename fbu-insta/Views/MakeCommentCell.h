//
//  MakeCommentCell.h
//  fbu-insta
//
//  Created by gilemos on 7/10/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface MakeCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *commentField;
@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
