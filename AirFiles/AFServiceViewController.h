//
//  AFServiceViewController.h
//  AirFiles
//
//  Created by test on 10/15/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFBluetooth.h"
#import "AFServerAddViewController.h"

@interface AFServiceViewController : UITableViewController<CBCentralManagerDelegate, CBPeripheralDelegate, AFServerAddViewControllerDelegate>
{
	//NSInteger service_type;
	//NSString *title;
	UIPopoverController *popoverController;
}

@property (atomic) NSInteger service_type;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
