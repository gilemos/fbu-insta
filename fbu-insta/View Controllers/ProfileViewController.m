//
//  ProfileViewController.m
//  fbu-insta
//
//  Created by gilemos on 7/9/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCell.h"
#import "PostCell.h"
#import "Post.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;
@end

@implementation ProfileViewController

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.profileTableView.delegate = self;
    self.profileTableView.dataSource = self;
    [self getCurrentUser];
    [self fetchPosts];
}

#pragma mark - UITableViewDataSource protocol
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        ProfileCell *cell = (ProfileCell*) [tableView dequeueReusableCellWithIdentifier:@"profilecell" forIndexPath:indexPath];
        cell.author = self.author;
        [cell refreshData];
        return cell;
    }
    PostCell *cell = (PostCell*) [tableView dequeueReusableCellWithIdentifier:@"postcell" forIndexPath:indexPath];
    cell.post = self.arrayOfPosts[indexPath.row  - 1];
    [cell refreshData];
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.arrayOfPosts.count + 1);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 128;
    }
    return 560;
}

-(void)fetchPosts{
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"profilePicture"];
    [postQuery whereKey:@"author" equalTo:self.author];
    postQuery.limit = 20;
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.arrayOfPosts = [NSMutableArray arrayWithArray:posts];
        }
        else {
            NSLog(@"There was a problem getting the posts");
        }
        [self.profileTableView reloadData];
    }];
}

-(void)getCurrentUser {
    if(self.author == nil){
        self.author = [PFUser currentUser];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
