//
//  AFServiceViewController.m
//  AirFiles
//
//  Created by test on 10/15/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import "AFProtocolViewController.h"
#import "AFServiceViewController.h"

#import "AFCommon.h"

extern NSManagedObjectContext *moc;

@interface AFProtocol()

@end

@implementation AFProtocol

@synthesize protocol, name, desc;

-(AFProtocol *) initWith: (NSInteger) p withName: (NSString*) n withDesc: (NSString*)d
{
	self = [super init];
	self.protocol = p;
	self.name = n;
	self.desc = d;
	
	return self;
}

+(NSArray *) getAllProtocols
{
	AFProtocol *p = [[AFProtocol alloc] initWith: FTP withName: @"FTP" withDesc: @"File Transfer Protocol"];
	return [NSArray arrayWithObjects: p, nil];
}

@end

@interface AFProtocolViewController ()

@end

@implementation AFProtocolViewController
{
	NSArray *protocols_array;
}

@synthesize managedObjectContext;

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
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
	// self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Services" style:UIBarButtonItemStylePlain target: self action: @selector(showServerTypes:)];
	
	//protocols_array = [[NSArray alloc] initWithObjects:@"Windows File Share", @"FTP", nil];
	//protocols_array = [[NSArray alloc] initWithObjects:@"Bluetooth", @"FTP", nil];
	//NSManagedObjectContext *context = [self managedObjectContext];
	
	protocols_array = [[NSMutableArray alloc] initWithArray: [AFProtocol getAllProtocols]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
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
    return protocols_array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProtocolCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	
    // Configure the cell...
	AFProtocol *p = [protocols_array objectAtIndex: indexPath.row];
	cell.textLabel.text = p.name;
	cell.detailTextLabel.text = p.desc;
	cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
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
     DetailViewController *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"air_files_ipad" bundle: [NSBundle mainBundle]];
	AFServiceViewController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"sb_services"];
	detailViewController.managedObjectContext = self.managedObjectContext;
	AFProtocol *p = [protocols_array objectAtIndex:indexPath.row];
	detailViewController.service_type =  p.protocol;
	detailViewController.title = [[protocols_array objectAtIndex: indexPath.row] name];
	[self.navigationController pushViewController: detailViewController animated: YES];
}

@end
