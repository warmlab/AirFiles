//
//  AFServiceViewController.h
//  AirFiles
//
//  Created by test on 10/15/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFProtocol : NSObject

@property (atomic) NSInteger protocol;
@property (nonatomic, retain) NSString *name, *desc;

@end

@interface AFProtocolViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
