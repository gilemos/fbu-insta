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

@interface PostDetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextField *caption;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshPost];
    // Do any additional setup after loading the view.
}

-(void)refreshPost {
    self.postImage.file = self.post.image;
    self.caption.text = self.post.caption;
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
