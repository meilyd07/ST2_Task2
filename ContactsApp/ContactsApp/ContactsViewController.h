//
//  ContactsViewController.h
//  ContactsApp
//
//  Created by Hanna Rybakova on 6/9/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsViewModel.h"

@interface ContactsViewController : UIViewController
@property (strong, nonatomic) ContactsViewModel *viewModel;
@end
