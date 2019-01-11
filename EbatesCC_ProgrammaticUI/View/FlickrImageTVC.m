//
//  FlickrImageTVC.m
//  EbatesCC_StoryBoard
//
//  Created by Mike Mullin on 1/9/19.
//  Copyright © 2019 EbatesInterview. All rights reserved.
//

#import "FlickrImageTVC.h"
#import "UIConstants.h"
#import "../ebates.pch"

@implementation FlickrImageTVC
@synthesize m_uiTheImage, m_lblTheTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // configure control(s)
        self.m_uiTheImage = [[UIImageView alloc] initWithFrame: CGRectMake( 10, 10, 35,35)];
        //self.m_uiTheImage.contentMode = UIViewContentModeScaleAspectFit;
        self.m_lblTheTitle = [[UILabel alloc] initWithFrame:CGRectMake(10 + 45, 10, self.bounds.size.width * .85, 35)];
        self.m_lblTheTitle.textColor = [UIColor whiteColor];
        self.m_lblTheTitle.font = OUR_FONT;
        self.m_lblTheTitle.numberOfLines = 0;
        self.m_lblTheTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.backgroundColor = [UIColor blackColor];
        
        [self.contentView addSubview: self.m_uiTheImage];
        [self. contentView addSubview: self.m_lblTheTitle];
        
        
        
        //self.m_uiTheImage.translatesAutoresizingMaskIntoConstraints = false;
        self.m_lblTheTitle.translatesAutoresizingMaskIntoConstraints = false;
        
        //label constraints
        NSLayoutConstraint *label_bottom = [NSLayoutConstraint constraintWithItem:self.m_lblTheTitle
            attribute: NSLayoutAttributeBottomMargin
            relatedBy: NSLayoutRelationEqual
               toItem: self.contentView
            attribute: NSLayoutAttributeBottom
           multiplier: 1
             constant: -12];
        
        
        
        NSLayoutConstraint *label_trailing = [NSLayoutConstraint constraintWithItem:self.m_lblTheTitle
                                                                        attribute: NSLayoutAttributeTrailing
                                                                        relatedBy: NSLayoutRelationEqual
                                                                           toItem: self.contentView
                                                                        attribute: NSLayoutAttributeTrailingMargin
                                                                       multiplier: 1
                                                                         constant: 15];
        
        NSLayoutConstraint *label_leading = [NSLayoutConstraint constraintWithItem:self.m_lblTheTitle
                                                                          attribute: NSLayoutAttributeLeading
                                                                          relatedBy: NSLayoutRelationEqual
                                                                             toItem: self.m_uiTheImage
                                                                          attribute: NSLayoutAttributeTrailing
                                                                         multiplier: 1
                                                                           constant: 8];
        
        NSLayoutConstraint *label_top = [NSLayoutConstraint constraintWithItem:self.m_lblTheTitle
                                                                         attribute: NSLayoutAttributeTop
                                                                         relatedBy: NSLayoutRelationEqual
                                                                            toItem: self.contentView
                                                                         attribute: NSLayoutAttributeTopMargin
                                                                        multiplier: 1
                                                                          constant: -16];
        
        /*
        //image constraints
        NSLayoutConstraint *image_top  = [NSLayoutConstraint constraintWithItem:self.m_uiTheImage
                                                                     attribute: NSLayoutAttributeTop
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeTop
                                                                    multiplier: 1
                                                                      constant: 4];
        
        NSLayoutConstraint *image_leading  = [NSLayoutConstraint constraintWithItem:self.m_uiTheImage
                                                                      attribute: NSLayoutAttributeLeading
                                                                      relatedBy: NSLayoutRelationEqual
                                                                         toItem: self.contentView
                                                                      attribute: NSLayoutAttributeLeadingMargin
                                                                     multiplier: 1
                                                                       constant: 0];

        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.m_uiTheImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:35];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.m_uiTheImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:35];
*/
        
        [self.contentView addConstraints: @[label_bottom, label_trailing,label_leading,label_top]];
        //[self.m_uiTheImage addConstraints: @[height,width]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
