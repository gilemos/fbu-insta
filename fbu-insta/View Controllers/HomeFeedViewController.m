//
//  HomeFeedViewController.m
//  fbu-insta
//
//  Created by gilemos on 7/8/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "HomeFeedViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "PostCell.h"
#import "PostDetailsViewController.h"
#import "ComposeViewController.h"

@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource, composeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *homeFeedTableView;
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;
@end

@implementation HomeFeedViewController

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //implementing the deledate and datasource for the tableview
    self.homeFeedTableView.delegate = self;
    self.homeFeedTableView.dataSource = self;
    //putting the refresh at the top
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.homeFeedTableView insertSubview:refreshControl atIndex:0];
    //Constructing the array of posts
    [self fetchPosts];
}

#pragma mark - Table View Protocols
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = (PostCell*) [tableView dequeueReusableCellWithIdentifier:@"postcell" forIndexPath:indexPath];
    cell.post = self.arrayOfPosts[indexPath.row];
    [cell refreshData];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

#pragma mark - compose view controller protocol
- (void)getNewPost:(nonnull Post *)post {
    [self.arrayOfPosts addObject:post];
}

#pragma mark - Top Buttons
- (IBAction)tapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    [self performSegueWithIdentifier:@"logOutSegue" sender:nil];
}

#pragma mark - Helper methods
- (void)fetchPosts {
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            [self.arrayOfPosts arrayByAddingObjectsFromArray:posts];
        }
        else {
            NSLog(@"There was a problem getting the posts");
        }
    }];
}

-(void)beginRefresh: (UIRefreshControl *) refreshControl{
    [self fetchPosts];
    [self.homeFeedTableView reloadData];
    [refreshControl endRefreshing];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"segueToPostDetails"]) {
        [self postDetaislSegue:segue sender:sender];
    }
}

- (void)postDetaislSegue: (UIStoryboardSegue *)segue sender:(id)sender {
    PostDetailsViewController *postDetailsViewController = [segue destinationViewController];
    PostCell *tappedCell = sender;
    Post *curPost = tappedCell.post;
    postDetailsViewController.post  = curPost;
}

@end
