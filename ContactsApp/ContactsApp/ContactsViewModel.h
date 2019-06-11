//
//  ContactsViewModel.h
//  ContactsApp
//
//  Created by Hanna Rybakova on 6/9/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface ContactsViewModel : NSObject
-(void)getData;
-(NSString *)getContactNameBySection:(NSInteger)section row:(NSUInteger)row;
-(NSString *)getSectionNameBySection:(NSInteger)section;
-(NSInteger)getContactsInSection:(NSInteger)section;
-(NSInteger)getSectionsCount;
-(Person *)getContactBySection:(NSInteger)section row:(NSUInteger)row;
-(void)deleteContact:(NSInteger)section row:(NSUInteger)row;
@end
