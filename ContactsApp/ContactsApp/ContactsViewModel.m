//
//  ContactsViewModel.m
//  ContactsApp
//
//  Created by Hanna Rybakova on 6/9/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "ContactsViewModel.h"
#import <Contacts/Contacts.h>
#import "Person.h"
#import <UIKit/UIKit.h>

@interface ContactsViewModel()
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation ContactsViewModel

-(NSInteger)getSectionsCount {
    return self.data.count;
}

-(NSInteger)getContactsInSection:(NSInteger)section {
    return ((NSArray *)self.data[section][1]).count;
}

-(void)deleteContact:(NSInteger)section row:(NSUInteger)row {
    [self.data[section][1] removeObjectAtIndex:row];
}

-(NSString *)getContactNameBySection:(NSInteger)section row:(NSUInteger)row {
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", ((Person *)self.data[section][1][row]).lastName, ((Person *)self.data[section][1][row]).name];
    return fullName;
}


-(Person *)getContactBySection:(NSInteger)section row:(NSUInteger)row {
    return ((Person *)self.data[section][1][row]);
}

-(NSString *)getSectionNameBySection:(NSInteger)section {
    return self.data[section][0];
}

-(void)getData{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES) {
            //keys with fetching properties
            NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
            NSString *containerId = store.defaultContainerIdentifier;
            NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
            NSError *error;
            NSArray *cnContacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
            if (error) {
                NSLog(@"error fetching contacts %@", error);
            } else {
                for (CNContact *contact in cnContacts) {
                    // copy data to my custom Contacts class.
                    Person *newPerson = [[Person alloc] init];
                    newPerson.phones = [[NSMutableArray alloc] init];
                    newPerson.name = contact.givenName;
                    newPerson.lastName = contact.familyName;
                    UIImage *image = [UIImage imageWithData:contact.imageData];
                    newPerson.image = image;
                    for (CNLabeledValue *label in contact.phoneNumbers) {
                        NSString *phone = [label.value stringValue];
                        if ([phone length] > 0) {
                            [newPerson.phones addObject:phone];
                        }
                    }
                    [array addObject:newPerson];
                }
                
                NSMutableArray *arrIndexSection =[@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"А",@"Б",@"В",@"Г",@"Д",@"Е",@"Ё",@"Ж",@"З",@"И",@"К",@"Л",@"М",@"Н",@"О",@"П",@"Р",@"С",@"Т",@"У",@"Ф",@"Х",@"Ц",@"Ш",@"Щ",@"Ъ",@"Ы",@"Ь",@"Э",@"Ю",@"Я"] mutableCopy];
                
                NSMutableArray *resultArray = [[NSMutableArray alloc] init];
                for(int i=0; i<arrIndexSection.count; i++) {
                    NSString *first = arrIndexSection[i];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.lastName BEGINSWITH[cd] %@", first];
                    NSMutableArray *tempArray = [[array filteredArrayUsingPredicate:predicate] mutableCopy];
                    if (tempArray.count > 0) {
                        [resultArray addObject:
                         [@[arrIndexSection[i], tempArray] mutableCopy]
                         ];
                    }
                }
                //for not alphabetic
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (self.lastName MATCHES[c] '^[A-Za-zА-Яа-я].*')"];
                NSMutableArray *tempArray = [[array filteredArrayUsingPredicate:predicate] mutableCopy];
                if (tempArray.count > 0) {
                    [resultArray addObject:@[@"#", tempArray]];
                }
                self.data = resultArray;
                [[NSNotificationCenter defaultCenter]
                                  postNotificationName:@"ContactRequestGranted"
                                  object:nil];
            }
        } else {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"ContactRequestFailed"
             object:nil];
            NSLog(@"contacts request failed %@", error);
        }
   }];
}

@end
