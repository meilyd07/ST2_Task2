//
//  DetailViewController.m
//  ContactsApp
//
//  Created by Hanna Rybakova on 6/10/19.
//  Copyright © 2019 None. All rights reserved.
//

#import "DetailViewController.h"
#import "PhoneCell.h"

@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DetailViewController
static NSString *TableViewPhoneCellIdentifier = @"PhoneCell";

- (void)viewWillAppear:(BOOL)animated {
    [self setTitle:@"Контакты"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
}

-(void)setupTable {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.alwaysBounceVertical = NO;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhoneCell *contactCell = nil;
    
    contactCell = [tableView dequeueReusableCellWithIdentifier:TableViewPhoneCellIdentifier];
    if (contactCell == nil){
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"PhoneCell"
                                                      owner:self options:nil];
        contactCell = (PhoneCell *)[nibs objectAtIndex:0];
    }
    
    contactCell.phoneNumber.text = self.person.phones[indexPath.row];
    return contactCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                  tableView.bounds.size.width, 280)];
    headerView.layer.borderWidth = 0.5;
    headerView.layer.borderColor = [[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.0f] CGColor];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *contactName = [[UILabel alloc]
                       initWithFrame:CGRectMake(0, 0,
                                                40, 60)];
    contactName.textColor = [UIColor blackColor];
    contactName.font = [UIFont systemFontOfSize:23.0 weight:UIFontWeightMedium];
    contactName.text = [NSString stringWithFormat:@"%@ %@", self.person.lastName, self.person.name];
    [headerView addSubview:contactName];
    
    contactName.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImageView *avatarImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,150,150)];
    avatarImageView.layer.cornerRadius = 75;
    avatarImageView.clipsToBounds = YES;
    
    if (self.person.image == nil) {
        avatarImageView.image = [UIImage imageNamed:@"noPhoto"];
    } else {
        avatarImageView.image = self.person.image;
    }
    [headerView addSubview:avatarImageView];
    
    avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeTop multiplier:1 constant:25];
    
    NSLayoutConstraint *centerImageX = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *centerContactsX = [NSLayoutConstraint constraintWithItem:contactName attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *distance = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contactName attribute:NSLayoutAttributeTop multiplier:1 constant:-25];
    [headerView addConstraint:centerImageX];
    [headerView addConstraint:top];
    [headerView addConstraint:centerContactsX];
    [headerView addConstraint:distance];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute  multiplier:1 constant:150];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute  multiplier:1 constant:150];
    [headerView addConstraint:width];
    [headerView addConstraint:height];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 280;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.person.phones.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
@end
