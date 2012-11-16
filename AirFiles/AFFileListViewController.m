//
//  AFFileListViewController.m
//  AirFiles
//
//  Created by test on 11/13/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import "AFFileListViewController.h"

#include <sys/dirent.h>

@interface AFFileListViewController ()

@end

@implementation AFFileListViewController

@synthesize listEntries, ftp, title;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationItem.title = title;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemRefresh target: self action: @selector(refreshFileList:)];
	
	listEntries = ftp.listEntries;
	ftp.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didFinishListing
{
	listEntries = ftp.listEntries;
	NSLog(@"listEntries count: %d in %s", __func__);
	[self.tableView reloadData];
}

-(IBAction)refreshFileList:(id)sender
{
	listEntries = ftp.listEntries;
	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return listEntries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FileCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
    
    // Configure the cell...
	NSDictionary *dict = [listEntries objectAtIndex: indexPath.row];
	/*for (NSString *key in [dict allKeys]) {
		//cell.detailTextLabel.text = [dict valueForKey: key];
		NSLog(@"%@ -- %@", key, [dict valueForKey: key]);
	}*/

	cell.textLabel.text = [dict valueForKey: (id)kCFFTPResourceName];
	
	NSString *dateStr, *sizeStr;
    char                modeCStr[12];
	
	int type = [[dict valueForKey:(id)kCFFTPResourceType] integerValue];
	if (type == DT_DIR) {
		// folder icon
		sizeStr = @"-";
	} else if (type == DT_REG) {
		// file icon
		unsigned long long size = [[dict valueForKey: (id)kCFFTPResourceSize] unsignedLongLongValue];
		sizeStr = [NSString stringWithFormat: @"%llu", size];
	}
	
	NSInteger modeNum = [[dict objectForKey:(id) kCFFTPResourceMode] intValue];
	strmode(modeNum + DTTOIF(type), modeCStr);
	
	NSDate* date = [dict objectForKey:(id) kCFFTPResourceModDate];
	NSDateFormatter *DateFormatter = [[NSDateFormatter alloc] init];
	
	DateFormatter.dateStyle = NSDateFormatterShortStyle;
	DateFormatter.timeStyle = NSDateFormatterShortStyle;
	dateStr = [DateFormatter stringFromDate:date];
	
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%s %@ %@", modeCStr, sizeStr, dateStr];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
