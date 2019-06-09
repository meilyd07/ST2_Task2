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
@property (strong, nonatomic) NSMutableSet *collapsedSet;
@end

@implementation ContactsViewController
static NSString *TableViewCellIdentifier = @"ContactCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    [self addTableConstraints];
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    [self setTitle:@"Контакты"];
    UIFont *font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],
       NSFontAttributeName:font}];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupTable {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    self.data = [self.viewModel getData];
    self.collapsedSet = [[NSMutableSet alloc] init];
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
    
    contactCell.contactName.text = self.data[indexPath.section][1][indexPath.row];
    return contactCell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    BOOL collapsed = [self.collapsedSet containsObject:[NSNumber numberWithInteger:section]];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                  tableView.bounds.size.width, 60)];
    headerView.layer.borderWidth = 1;
    headerView.layer.borderColor = [[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.0f] CGColor];
    headerView.tag = section;
    headerView.backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:249.0f/255.0f blue:249.0f/255.0f alpha:1.0f];
    
    UILabel *letter = [[UILabel alloc]
                       initWithFrame:CGRectMake(0, 0,
                                                40, 60)];
    UIColor *expandedBlackColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    UIColor *collapsedColor = [UIColor colorWithRed:217.0f/255.0f green:145.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    UIColor *expandedGrayColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    letter.textColor = collapsed ? collapsedColor : expandedBlackColor;
    letter.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightBold];;
    letter.text = [NSString stringWithFormat:@"%@", self.data[section][0]];
    [headerView addSubview:letter];
    
    UILabel *contacts = [[UILabel alloc]
                         initWithFrame:CGRectMake(0, 0,
                                                  60, 60)];
    contacts.textColor = collapsed ? collapsedColor : expandedGrayColor;
    contacts.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightLight];;
    NSInteger contactsCount = ((NSArray *)self.data[section][1]).count;
    contacts.text = [NSString stringWithFormat:@"контактов: %ld", contactsCount];
    [headerView addSubview:contacts];
    
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,20,20)];
    dot.image= collapsed ? [UIImage imageNamed:@"arrow_up.png"] : [UIImage imageNamed:@"arrow_down.png"];
    [headerView addSubview:dot];

    //add constraints
    letter.translatesAutoresizingMaskIntoConstraints = NO;
    contacts.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:letter attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeLeading multiplier:1 constant:25];
    
    NSLayoutConstraint *centerLetterY = [NSLayoutConstraint constraintWithItem:letter attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
                                                                     toItem:headerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *centerContactsY = [NSLayoutConstraint constraintWithItem:contacts attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
                                                                        toItem:headerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *distance = [NSLayoutConstraint constraintWithItem:letter attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:contacts attribute:NSLayoutAttributeLeading multiplier:1 constant:-10];
    [headerView addConstraint:leading];
    [headerView addConstraint:centerLetterY];
    [headerView addConstraint:centerContactsY];
    [headerView addConstraint:distance];
    
    dot.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:dot attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-20];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:dot attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute  multiplier:1 constant:20];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:dot attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute  multiplier:1 constant:20];
    
    NSLayoutConstraint *centerDotY = [NSLayoutConstraint constraintWithItem:dot attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
        toItem:headerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [headerView addConstraint:trailing];
    [headerView addConstraint:width];
    [headerView addConstraint:height];
    [headerView addConstraint:centerDotY];
    
    [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
    return headerView;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    NSInteger section = recognizer.view.tag;
    if ([self.collapsedSet containsObject:[NSNumber numberWithInteger:section]]) {
        [self.collapsedSet removeObject:[NSNumber numberWithInteger:section]];
    } else {
      [self.collapsedSet addObject:[NSNumber numberWithInteger:section]];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.data[section];
    NSArray *arrayNames = array[1];
    return [self.collapsedSet containsObject:[NSNumber numberWithInteger:section]] ? 0 : arrayNames.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}


@end
