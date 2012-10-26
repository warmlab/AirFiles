//
//  AFServiceViewController.m
//  AirFiles
//
//  Created by test on 10/15/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import "AFServiceViewController.h"

#import "AFServerAddViewController.h"

#import "AFServiceOperate.h"
#import "AFService.h"

#import "AFCommon.h"

@interface AFServiceViewController ()

@end

@implementation AFServiceViewController
{
	AFBluetooth *bluetooth;
	NSMutableArray *services_array;
	
    CBCentralManager *manager;
    NSMutableArray *perpherals;
    NSDictionary *dictionary;
	NSMutableArray *services;
}

@synthesize service_type, title, tableView, managedObjectContext;

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
	self.navigationItem.title = title;
	
	if (service_type == BLUETOOTH) {
	//bluetooth = [AFBluetooth new];
	manager = [[CBCentralManager alloc] initWithDelegate: self queue:nil];
    
    // Scan for devices
    dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    //[manager scanForPeripheralsWithServices:nil options:dictionary];
    [manager scanForPeripheralsWithServices:[NSArray arrayWithObject:[CBUUID UUIDWithString:@"180A"]] options:dictionary];
	} else if (service_type == FTP) {
		//NSManagedObjectContext *context = [self managedObjectContext];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target: self action: @selector(addFtpService:)];
		
		AFServiceOperate *operate = [AFServiceOperate new];
		operate.managedObjectContext = self.managedObjectContext;
		[services addObjectsFromArray: [operate getServicesByProtocol: service_type]];
	}
	
	self.contentSizeForViewInPopover = CGSizeMake(150.0, 140.0);
	
	
}

- (void)viewDidUnload
{
	[manager stopScan];
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

#pragma mark - action
-(IBAction)addFtpService:(id)sender
{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"air_files_ipad" bundle: [NSBundle mainBundle]];
	AFServerAddViewController *popoverContent = [storyboard instantiateViewControllerWithIdentifier:@"sb_add_server"];
	
	//UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController: serverAddController];
	//build our custom popover view
	//UIViewController* popoverContent = [[UIViewController alloc] init];
	//UIView* popoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
	//popoverView.backgroundColor = [UIColor blueColor];
	//popoverContent.view = popoverView;
	
	//resize the popover view shown
	//in the current view to the view's size
	
	//[popoverContent setFrame:CGRectMake(0, 0, 300, 400)];
	//popoverContent.view.frame = CGRectMake(0, 0, 300, 400);
	//CGSizeMake(300, 400);
	popoverContent.contentSizeForViewInPopover = CGSizeMake(768, 200);
	//popoverContent.view.frame = CGSizeMake(300, 400);
	
	//popoverController.delegate = self;
	popoverContent.delegate = self;
	//create a popover controller
	popoverController = [[UIPopoverController alloc]
							  initWithContentViewController:popoverContent];
	
	//present the popover view non-modal with a
	//refrence to the toolbar button which was pressed
	[popoverController presentPopoverFromBarButtonItem:sender
								   permittedArrowDirections:UIPopoverArrowDirectionUp
												   animated:YES];
	
	//[popoverController dismissPopoverAnimated:YES];
	//release the popover content
	//[popoverView release];
	//[popoverContent release];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	// add your code here
}

- (void)reload_data_and_close
{
	[services removeAllObjects];
	AFServiceOperate *operate = [AFServiceOperate new];
	operate.managedObjectContext = self.managedObjectContext;
	[services addObjectsFromArray: [operate getServicesByProtocol: service_type]];
	[tableView reloadData];
	[popoverController dismissPopoverAnimated: YES];
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
	NSLog(@"services count: %d", [services count]);
    return [services count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ServiceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	
    // Configure the cell...
	AFService *s = [services objectAtIndex: indexPath.row];
	cell.textLabel.text = s.name;
	cell.detailTextLabel.text = s.url;
    
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

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    
    NSLog(@"%@",[advertisementData description]);
}


// Process peripherals and pick random one
- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals
{
    // chose peripheral and connect
    [manager connectPeripheral:[perpherals objectAtIndex:0]options:[NSDictionary dictionary]];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSString *messtoshow;
    
    switch (central.state) {
        case CBCentralManagerStateUnknown:
        {
            messtoshow=[NSString stringWithFormat:@"State unknown, update imminent."];
            break;
        }
        case CBCentralManagerStateResetting:
        {
            messtoshow=[NSString stringWithFormat:@"The connection with the system service was momentarily lost, update imminent."];
            break;
        }
        case CBCentralManagerStateUnsupported:
        {
            messtoshow=[NSString stringWithFormat:@"The platform doesn't support Bluetooth Low Energy"];
            break;
        }
        case CBCentralManagerStateUnauthorized:
        {
            messtoshow=[NSString stringWithFormat:@"The app is not authorized to use Bluetooth Low Energy"];
            break;
        }
        case CBCentralManagerStatePoweredOff:
        {
            messtoshow=[NSString stringWithFormat:@"Bluetooth is currently powered off."];
            break;
        }
        case CBCentralManagerStatePoweredOn:
        {
            messtoshow=[NSString stringWithFormat:@"Bluetooth is currently powered on and available to use."];
            [manager scanForPeripheralsWithServices:nil options:nil];
            //[mgr retrieveConnectedPeripherals];
            
            //--- it works, I Do get in this area!
            
            break;
        }
            
    }
    NSLog(@"%@", messtoshow);
}


// Get notified when connection with peripheral is complete and write a value to a characteristic on the peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    //Write value to a characteristic
    int i = 1;
    [peripheral writeValue:[NSData dataWithBytes:&i length:sizeof(i)] forCharacteristic:[[peripheral.services[0] characteristics ] objectAtIndex:0] type:CBCharacteristicWriteWithoutResponse];
}

@end
