//
//  ClassmatesTableViewController.m
//  iOS-Course
//
//  Created by Lukas Carvajal on 6/25/15.
//  Copyright (c) 2015 Lukas Carvajal. All rights reserved.
//

#import "ClassmatesTableViewController.h"
#import "User.h"
#import <Parse/Parse.h>

@interface ClassmatesTableViewController ()

@end

@implementation ClassmatesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // fix navigation header
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // initialize arrays
    if (!_classmates)
        _classmates = [[NSArray alloc] init];
    if(!_users)
        _users = [[NSMutableArray alloc] init];
    
    [self getClassmates];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getClassmates {
    
    // perform query for classmates info
    PFQuery *query = [PFUser query];
    self.classmates = [query findObjects];
    
    for (int i = 0; i < self.classmates.count; i++) {
        
        // individual user info
        User* user = [[User alloc] init];
        user.name = [[self.classmates objectAtIndex:i] objectForKey:@"Name"];
        user.email = [[self.classmates objectAtIndex:i] email];
        user.hobbies = [[self.classmates objectAtIndex:i] objectForKey:@"hobbies"];
        user.about = [[self.classmates objectAtIndex:i] objectForKey:@"about"];
        
        [self.users addObject:user ];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.users.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // set names for classmates list
    User* classmate = [self.users objectAtIndex:indexPath.row];
    cell.textLabel.text = classmate.name;
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

@end