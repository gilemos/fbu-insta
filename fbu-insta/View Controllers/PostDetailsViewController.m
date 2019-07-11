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

@interface PostDetailsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *postDetailsTableView;

@end

@implementation PostDetailsViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.postDetailsTableView.delegate = self;
    self.postDetailsTableView.dataSource = self;
}

#pragma mark - UITableViewDataSource Protocol
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
    PostCell *cell = (PostCell*) [tableView dequeueReusableCellWithIdentifier:@"postcell" forIndexPath:indexPath];
    cell.post = self.tappedPost;
    [cell refreshData];
    return cell;
    }
    if(indexPath.row == 1) {
        MakeCommentCell *cell = (MakeCommentCell*) [tableView dequeueReusableCellWithIdentifier:@"makecommentcell" forIndexPath:indexPath];
        cell.post = self.tappedPost;
        return cell;
    }
    return nil;
        
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ([self.tappedPost.commentCount intValue] + 2);
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
