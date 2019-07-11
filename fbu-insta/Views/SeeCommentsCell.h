//
//  SeeCommentsCell.h
//  fbu-insta
//
//  Created by gilemos on 7/10/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comments.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeeCommentsCell : UITableViewCell
@property (strong, nonatomic) Comments *currentComment;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

- (void)refreshData;
@end

NS_ASSUME_NONNULL_END
