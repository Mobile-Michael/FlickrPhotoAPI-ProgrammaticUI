//
//  DetailViewController.m
//  EbatesCC_StoryBoard
//
//  Created by Mike Mullin on 1/9/19.
//  Copyright © 2019 EbatesInterview. All rights reserved.
//

#import "PhotoDetailVC.h"
#import "FlickrTableViewController.h"
#import "../Model/RecentPhotoInfo.h"
#import "../ebates.pch"

@interface PhotoDetailVC ()

@end

@implementation PhotoDetailVC
@synthesize detailItem,m_uiFullImage, presentingVC;

-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size
 {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    }
    else
    {
        UIGraphicsBeginImageContext(size);
    }
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(UIImage *)imageWithImage:(UIImage *)image scaledToMaxWidth:(CGFloat)width maxHeight:(CGFloat)height {
    CGFloat oldWidth = image.size.width;
    CGFloat oldHeight = image.size.height;
    
    CGFloat scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;
    
    CGFloat newHeight = oldHeight * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    return [self imageWithImage:image scaledToSize:newSize];
}

-(void) BackClicked
{
    [self dismissViewControllerAnimated:YES completion:^(void)
    {
        self.presentingVC.detailViewController = nil;
    }];
}

- (void)configureView {
    // Update the user interface for the detail item.
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: @"Back"
                                                                   style:UIBarButtonItemStylePlain target:self action:@selector(BackClicked)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    if (self.detailItem)
    {
        //transfrom the UIImage,  Per Yuriy's request centered, but take as much space you can wide and keep aspect the same,
        UIImage *pTransformed = [self imageWithImage:detailItem.m_theImage scaledToMaxWidth: self.view.frame.size.width maxHeight: self.view.frame.size.height];
        m_uiFullImage = [[UIImageView alloc] initWithFrame: self.view.frame];
        self.m_uiFullImage.image = pTransformed;// = [[UIImageView alloc] initWithImage: detailItem.m_theImage];
        
        m_uiFullImage.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        m_uiFullImage.contentMode = UIViewContentModeScaleAspectFit;
        m_uiFullImage.userInteractionEnabled = YES;
       
        [self.view addSubview: self.m_uiFullImage];
        self.view.backgroundColor = [UIColor blackColor];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


@end
