//
//  ContactsViewModel.m
//  ContactsApp
//
//  Created by Hanna Rybakova on 6/9/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "ContactsViewModel.h"

@implementation ContactsViewModel
-(NSMutableArray *)getData {
    return [@[ @"Jonh Dou", @"Ray Wenderlich", @"Jean Bean" ] mutableCopy];
}
@end
