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
#import "PFImageView.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;
@property (strong, nonatomic) UIImage *placeholderProfileImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveChangesButton;
@property (strong, nonatomic) NSMutableArray *toolbarButtons;
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
        return [self makeProfileCellWithTableView:tableView atIndexPath:indexPath];
    }
    return [self makePostCellWithTableView:tableView atIndexPath:indexPath];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.arrayOfPosts.count + 1);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 86;
    }
    return 600;
}

#pragma mark - Methods to make cells
- (PostCell *)makePostCellWithTableView:(nonnull UITableView *)tableView atIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = (PostCell*) [tableView dequeueReusableCellWithIdentifier:@"postcell" forIndexPath:indexPath];
    cell.post = self.arrayOfPosts[indexPath.row  - 1];
    [cell refreshData];
    return cell;
}

- (ProfileCell *)makeProfileCellWithTableView:(nonnull UITableView *)tableView atIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCell *cell = (ProfileCell*) [tableView dequeueReusableCellWithIdentifier:@"profilecell" forIndexPath:indexPath];
    cell.author = self.author;
    if(self.placeholderProfileImage != nil) {
        cell.profilePhotoFile = [Post getPFFileFromImage:self.placeholderProfileImage];
    }
    else {
        cell.profilePhotoFile = self.author[@"profilePicture"];
    }
    [cell refreshData];
    return cell;
}

#pragma mark - UIIMagePicker protocol
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    //UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.placeholderProfileImage = [self resizeImage:originalImage withSize:CGSizeMake(400, 400)];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.profileTableView reloadData];
}

#pragma mark - Methods to set profile image
- (IBAction)tapPicture:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    if (![self.toolbarButtons containsObject:self.saveChangesButton]) {
        [self.toolbarButtons addObject:self.saveChangesButton];
        [self setToolbarItems:self.toolbarButtons animated:YES];
    }
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (IBAction)tapSaveChanges:(id)sender {
    if(self.placeholderProfileImage != nil) {
        [Post updateProfileofUser:self.author withImage:self.placeholderProfileImage withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"New profile image saved");
            self.placeholderProfileImage = nil;
            [self.profileTableView reloadData];
        }];
    }
}

#pragma mark - Methods to fetch data
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
