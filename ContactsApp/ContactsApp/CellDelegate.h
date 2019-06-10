//
//  CellDelegate.h
//  ContactsApp
//
//  Created by Hanna Rybakova on 6/10/19.
//  Copyright © 2019 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CellDelegate <NSObject>
- (void)didClickOnCellAtIndex:(NSInteger)cellIndexRow section:(NSInteger)cellIndexSection;
@end
