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
#import "InfiniteScrollActivityView.h"
#import "MBProgressHUD.h"
#import "ProfileViewController.h"

@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UITableView *homeFeedTableView;
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (nonatomic) int numOfPosts;
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation HomeFeedViewController
InfiniteScrollActivityView* loadingMoreView;

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeFeedTableView.delegate = self;
    self.homeFeedTableView.dataSource = self;
    self.numOfPosts = 20;
    self.isMoreDataLoading = NO;
    
    [self setTopRefreshControl];
    [self setInfiniteScrollingRefreshControl];
    [self addMBProgress];
    
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

#pragma mark - UIScrollViewDelegate protocol
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        int scrollViewContentHeight = self.homeFeedTableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.homeFeedTableView.bounds.size.height;
        
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.homeFeedTableView.isDragging) {
            self.isMoreDataLoading = true;
            CGRect frame = CGRectMake(0, self.homeFeedTableView.contentSize.height, self.homeFeedTableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
            loadingMoreView.frame = frame;
            [loadingMoreView startAnimating];
            [self loadMoreData];
        }
    }
}

#pragma mark - Top Buttons
- (IBAction)tapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    [self performSegueWithIdentifier:@"logOutSegue" sender:nil];
}

#pragma mark - Helper methods for refresh controls
- (void)setInfiniteScrollingRefreshControl {
    CGRect frame = CGRectMake(0, self.homeFeedTableView.contentSize.height, self.homeFeedTableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    loadingMoreView.hidden = true;
    [self.homeFeedTableView addSubview:loadingMoreView];
    
    UIEdgeInsets insets = self.homeFeedTableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.homeFeedTableView.contentInset = insets;
}

- (void)setTopRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.homeFeedTableView insertSubview:refreshControl atIndex:0];
}

- (void)addMBProgress {
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.delegate = self;
    self.HUD.label.text = @"Loading";
    [self.homeFeedTableView addSubview:self.HUD];
}

#pragma mark - Helper Methods for Loading
- (void)fetchPosts {
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"profilePicture"];
    postQuery.limit = self.numOfPosts;
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.arrayOfPosts = [NSMutableArray arrayWithArray:posts];
        }
        else {
            NSLog(@"There was a problem getting the posts");
        }
        [self.homeFeedTableView reloadData];
        [self.HUD hideAnimated:NO];
    }];
}

- (void)loadMoreData {
    self.isMoreDataLoading = false;
    self.numOfPosts += 20;
    [loadingMoreView stopAnimating];
    [self fetchPosts];
}

- (void)beginRefresh: (UIRefreshControl *) refreshControl {
    [self fetchPosts];
    [self.homeFeedTableView reloadData];
    [refreshControl endRefreshing];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"seguetodetails"]) {
        [self postDetaislSegue:segue sender:sender];
    }
}

- (void)postDetaislSegue: (UIStoryboardSegue *)segue sender:(id)sender {
    PostDetailsViewController *postDetailsViewController = [segue destinationViewController];
    PostCell *tappedCell = sender;
    Post *curPost = tappedCell.post;
    postDetailsViewController.tappedPost = curPost;
}

@end
