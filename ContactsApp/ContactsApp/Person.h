//
//  Person.h
//  ContactsApp
//
//  Created by Hanna Rybakova on 6/10/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSMutableArray *phones;
@property (strong, nonatomic) UIImage *image;
@end
