    //
//  ProfileCell.h
//  fbu-insta
//
//  Created by gilemos on 7/9/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *userProfilePhoto;
@property (weak, nonatomic) IBOutlet PFFileObject *profilePhotoFile;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) PFUser *author;

-(void)refreshData;
@end

NS_ASSUME_NONNULL_END
