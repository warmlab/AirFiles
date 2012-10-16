//
//  AFServiceViewController.m
//  AirFiles
//
//  Created by test on 10/15/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import "AFServiceViewController.h"

@interface AFServiceViewController ()

@end

@implementation AFServiceViewController
{
	AFBluetooth *bluetooth;
	NSMutableArray *services_array;
	
    CBCentralManager *manager;
    NSMutableArray *perpherals;
    NSDictionary *dictionary;
}

@synthesize service_type, title;

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
	
	//bluetooth = [AFBluetooth new];
	manager = [[CBCentralManager alloc] initWithDelegate: self queue:nil];
    
    // Scan for devices
    dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    //[manager scanForPeripheralsWithServices:nil options:dictionary];
    [manager scanForPeripheralsWithServices:[NSArray arrayWithObject:[CBUUID UUIDWithString:@"180A"]] options:dictionary];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	NSLog(@"%d", [bluetooth.perpherals count]);
    return [bluetooth.perpherals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ServiceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
    // Configure the cell...
	cell.textLabel.text = @"da";
    
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
