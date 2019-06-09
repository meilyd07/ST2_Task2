//
//  ContactCell.m
//  ContactsApp
//
//  Created by Hanna Rybakova on 6/9/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:254.0f/255.0f green:246.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
    [self setSelectedBackgroundView:bgColorView];
    self.contactName.lineBreakMode = NSLineBreakByTruncatingMiddle;
    self.contactName.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.contactName
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1
                                                                constant:25];
    [self.contentView addConstraint:leading];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.contactName
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0];
    [self.contentView addConstraint:centerY];
    
    self.infoButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.infoButton
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1
                                                                 constant:-20];
    [self.contentView addConstraint:trailing];
    NSLayoutConstraint *centerButtonY = [NSLayoutConstraint constraintWithItem:self.infoButton
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1
                                                                      constant:0];
    [self.contentView addConstraint:centerButtonY];
}

@end
