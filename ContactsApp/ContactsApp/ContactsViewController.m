//
//  ContactsViewController.m
//  ContactsApp
//
//  Created by Hanna Rybakova on 6/9/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactCell.h"

@interface ContactsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation ContactsViewController
static NSString *TableViewCellIdentifier = @"ContactCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    [self addTableConstraints];
}

-(void)setupTable {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   
    self.data = [self.viewModel getData];
}

-(void)addTableConstraints {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1
                                                            constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1
                                                               constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1
                                                                constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1
                                                                 constant:0];
    [self.view addConstraint:top];
    [self.view addConstraint:bottom];
    [self.view addConstraint:leading];
    [self.view addConstraint:trailing];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ContactCell *contactCell = nil;
    
    contactCell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    if (contactCell == nil){
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ContactCell"
                                                      owner:self options:nil];
        contactCell = (ContactCell *)[nibs objectAtIndex:0];
    }
    
    contactCell.contactName.text = self.data[indexPath.row];
    return contactCell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


@end
