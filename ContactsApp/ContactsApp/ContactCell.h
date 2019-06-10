//
//  ContactCell.h
//  ContactsApp
//
//  Created by Hanna Rybakova on 6/9/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDelegate.h"

@interface ContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@property (weak, nonatomic) id<CellDelegate>delegate;
@property (assign, nonatomic) NSInteger cellIndexRow;
@property (assign, nonatomic) NSInteger cellIndexSection;
@end
