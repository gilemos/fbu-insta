//
//  PostDetailsViewController.m
//  fbu-insta
//
//  Created by gilemos on 7/9/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "PostDetailsViewController.h"
#import <Parse/Parse.h>
#import "PFimageView.h"
#import "DateTools.h"
#import "Post.h"
#import "PostCell.h"
#import "MakeCommentCell.h"
#import "SeeCommentsCell.h"
#import "Comments.h"
#import "ProfileViewController.h"

@interface PostDetailsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *postDetailsTableView;
@end

@implementation PostDetailsViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.postDetailsTableView.delegate = self;
    self.postDetailsTableView.dataSource = self;
    [self getCommentsFromPost];
}

#pragma mark - UITableViewDataSource Protocol
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        PostCell *cell = (PostCell *) [tableView dequeueReusableCellWithIdentifier:@"postcell" forIndexPath:indexPath];
        cell.post = self.tappedPost;
        [cell refreshData];
        return cell;
    }
    if(indexPath.row == 1) {
        MakeCommentCell *cell = (MakeCommentCell *) [tableView dequeueReusableCellWithIdentifier:@"makecommentcell" forIndexPath:indexPath];
        cell.post = self.tappedPost;
        return cell;
    }
    SeeCommentsCell *cell = (SeeCommentsCell *)[tableView dequeueReusableCellWithIdentifier:@"seecommentscell" forIndexPath:indexPath];
    cell.currentComment = self.arrayOfComments[indexPath.row - 2];
    [cell refreshData];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.arrayOfComments.count + 2);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 576;
    }
    else if(indexPath.row == 1) {
        return 70;
    }
    return 102;
}

#pragma mark - Getting data methods
- (void)getCommentsFromPost {
    
    PFQuery *commentQuery = [Comments query];
    [commentQuery orderByDescending:@"createdAt"];
    [commentQuery includeKey:@"commentText"];
    [commentQuery includeKey:@"postID"];
    [commentQuery whereKey:@"postID" equalTo:self.tappedPost.objectId];
    commentQuery.limit = 20;
    
    [commentQuery findObjectsInBackgroundWithBlock:^(NSArray<Comments *> * _Nullable comments, NSError * _Nullable error) {
        if (comments) {
            //[self.arrayOfComments addObjectsFromArray:comments];
            self.arrayOfComments = (NSMutableArray *) comments;
        }
        else {
            NSLog(@"There was a problem getting the comments");
        }
        [self.postDetailsTableView reloadData];
    }];
}
- (IBAction)didTapPost:(id)sender {
    [self getCommentsFromPost];
}


 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"seguetofriendprofile"]) {
         [self friendProfilelSegue:segue sender:sender];
     }
 }

- (void)friendProfilelSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ProfileViewController *profileViewController = [segue destinationViewController];
    PFUser *postUser = self.tappedPost.author;
    profileViewController.author = postUser;
}



@end
