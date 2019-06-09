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
//    NSLayoutConstraint *distance = [NSLayoutConstraint constraintWithItem:self.contactName
//                                                                attribute:NSLayoutAttributeTrailing
//                                                                relatedBy:NSLayoutRelationGreaterThanOrEqual
//                                                                   toItem:self.infoButton
//                                                                attribute:NSLayoutAttributeLeading
//                                                               multiplier:1
//                                                                 constant:10];
//    [self.contentView addConstraint:distance];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    //
}

@end
