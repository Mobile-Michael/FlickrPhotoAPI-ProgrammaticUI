//
//  DetailViewController.h
//  EbatesCC_StoryBoard
//
//  Created by Mike Mullin on 1/9/19.
//  Copyright © 2019 EbatesInterview. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecentPhotoInfo;
@class FlickrTableViewController;

@interface PhotoDetailVC : UIViewController

@property (strong, nonatomic) RecentPhotoInfo *detailItem;
@property (weak, nonatomic) FlickrTableViewController *presentingVC;
@property (strong, nonatomic) IBOutlet UIImageView *m_uiFullImage;

@end

