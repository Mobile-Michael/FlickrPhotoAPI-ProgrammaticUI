//
//  MasterViewController.h
//  EbatesCC_StoryBoard
//
//  Created by Mike Mullin on 1/9/19.
//  Copyright © 2019 EbatesInterview. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoDetailVC;

@interface FlickrTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) PhotoDetailVC *detailViewController;


@end

