//
//  MasterViewController.m
//  EbatesCC_StoryBoard
//
//  Created by Mike Mullin on 1/9/19.
//  Copyright © 2019 EbatesInterview. All rights reserved.
//

#import "FlickrTableViewController.h"
#import "PhotoDetailVC.h"
#import "../View/FlickrImageTVC.h"

#import "../ThirdParty/SDWebImage/UIImageView+WebCache.h"

#import "../Model/Constants.h"
#import "../Model/PhotoManager.h"
#import "../Model/RecentPhotoInfo.h"

#import "../View/UIConstants.h"

#import "ebates.pch"



@interface FlickrTableViewController ()

@property(nonatomic, weak) PhotoManager *m_pPhotoManager;
@property(nonatomic,strong) UIActivityIndicatorView *m_pActivityIndicator;
@property(nonatomic,assign) BOOL m_bInNetworkCall;
@end

@implementation FlickrTableViewController
{
    CGFloat m_fUILabelWidth;
}

@synthesize m_pPhotoManager, m_pActivityIndicator, m_bInNetworkCall, detailViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self onViewDidLoadHelper];
}

-(void) RefreshList
{
    [self getPhotos];
}

-(void) getPhotos
{
    m_bInNetworkCall = YES;
    [self.m_pActivityIndicator startAnimating];
    [m_pPhotoManager flickrAPIGetRecentFlickrImages:^(NSString *error)
     {
         void (^resultBlock)(void) = nil;
         if( error == nil)
         {
             resultBlock = ^()
             {
                 [self.tableView reloadData];
             };
         }
         else
         {
             resultBlock = ^()
             {
                 [self showAlertWithTitle: NSLocalizedString(@"Flickr API Failed!",nil) andMessage: error];
                 [self.tableView reloadData];
             };
         }
         
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            self.m_bInNetworkCall = NO;
                            [self.m_pActivityIndicator stopAnimating];
                            resultBlock();
                        });
     }];
    
}

-(void) setupTheTableView
{
    //lets register our custom uitableviewcells
    [self.tableView  registerClass:[FlickrImageTVC class] forCellReuseIdentifier:NSStringFromClass([FlickrImageTVC class])];
    
    
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView setSeparatorColor: [UIColor lightGrayColor]];
    
    
    CGRect rectForTableView = self.view.bounds;
    self.tableView.frame = rectForTableView;
    self.tableView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent: .5];
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.tableView setAllowsSelection: YES];
    self.tableView.scrollEnabled = YES;
    self.tableView.userInteractionEnabled = YES;
    self.tableView.bounces = NO;
    
    self.tableView.estimatedRowHeight = ROW_HEIGHT_MIN;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

-(void) setupNavBar
{
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh_30x30"] style:UIBarButtonItemStylePlain target:self action:@selector(RefreshList)];
    refreshBtn.customView.frame = CGRectMake(0,0,30,30);
    
    self.navigationItem.rightBarButtonItem = refreshBtn;
    self.navigationItem.title = @"EbatesCC-Flickr";
}

-(void)onViewDidLoadHelper
{
    m_pPhotoManager = [PhotoManager sharedInstance];
    m_fUILabelWidth = UILABEL_WIDTH_IN_CELL;
    m_pActivityIndicator = [[UIActivityIndicatorView alloc] init];
    
    [self setupTheTableView];
    [self setupNavBar];
    [self setupActivityIndicator];
    [self getPhotos];
}

-(void)showAlertWithTitle:(NSString*)pTitle andMessage:(NSString*)pMsg
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: pTitle message: pMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString( @"Dismiss", @"Flickr API Failed" ) style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController: alertController animated:YES completion:nil];
}

-(void) setupActivityIndicator
{
    m_pActivityIndicator.center = self.view.center;
    m_pActivityIndicator.hidesWhenStopped = YES;
    m_pActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview: m_pActivityIndicator];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark - Segues


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RecentPhotoInfo *pInfo = [self.m_pPhotoManager getPhotoAtIndex: indexPath.row];
        PhotoDetailVC *controller = (PhotoDetailVC *)[[segue destinationViewController] topViewController];
        controller.detailItem = pInfo;
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.m_pPhotoManager getNumPhotos];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( !detailViewController)
    {
        detailViewController = [[PhotoDetailVC alloc] init];
        detailViewController.presentingVC = self;
    }
    
    RecentPhotoInfo *pInfo = [self.m_pPhotoManager getPhotoAtIndex: indexPath.row];
    detailViewController.detailItem = pInfo;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: detailViewController];
    [self presentViewController: navController animated: YES completion:^
     {
     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlickrImageTVC *cell = [tableView dequeueReusableCellWithIdentifier:
                            NSStringFromClass([FlickrImageTVC class])
                                              forIndexPath:indexPath];
    
    m_fUILabelWidth = cell.m_lblTheTitle.bounds.size.width;
    __block RecentPhotoInfo *photoInfo = [self.m_pPhotoManager getPhotoAtIndex : indexPath.row];
    cell.m_lblTheTitle.text = photoInfo.m_sTitle;
    NSURL *url = [NSURL URLWithString: photoInfo.m_sURLToImageJPG];
    UIImage *placeHolder = [UIImage imageNamed: @"no_jpg"];
    
    photoInfo.m_theImage = placeHolder;
    [cell.m_uiTheImage sd_setImageWithURL: url
                      placeholderImage: placeHolder
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                             {
                                 photoInfo.m_theImage = image;
                             }];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width
{
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat area = size.height * size.width;
    CGFloat height = roundf(area / width);
    return ceilf(height / font.lineHeight) * font.lineHeight + 10;
}

-(CGFloat) getOptimalHeightForRow:(RecentPhotoInfo*)photoInfo
{
    CGFloat fVal = ROW_HEIGHT_MIN;
    if( photoInfo && photoInfo.m_sTitle.length > 0)
        fVal =  [self heightForText:photoInfo.m_sTitle font: OUR_FONT withinWidth: m_fUILabelWidth];
   
    return fmax(fVal, ROW_HEIGHT_MIN);
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return [self getOptimalHeightForRow: [self.m_pPhotoManager getPhotoAtIndex:indexPath.row]];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {

        if( [self.m_pPhotoManager removeObjectAtIndex : indexPath.row])
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation : UITableViewRowAnimationFade];
    }
}

@end
