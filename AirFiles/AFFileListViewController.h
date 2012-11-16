//
//  AFFileListViewController.h
//  AirFiles
//
//  Created by test on 11/13/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "AFFtp.h"

@interface AFFileListViewController : UITableViewController <AFFtpDelegate>

@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) AFFtp * ftp;
@property (nonatomic, strong, readwrite) NSMutableArray *  listEntries;

@end
