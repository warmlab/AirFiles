//
//  AFServiceViewController.h
//  AirFiles
//
//  Created by test on 10/15/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFBluetooth.h"

@interface AFServiceViewController : UITableViewController<CBCentralManagerDelegate, CBPeripheralDelegate>
{
	//NSInteger service_type;
	//NSString *title;
}

@property (atomic) NSInteger service_type;
@property (nonatomic, retain) NSString *title;

@end
