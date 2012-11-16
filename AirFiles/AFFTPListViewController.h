//
//  AFFTPListViewController.h
//  AirFiles
//
//  Created by test on 11/16/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFFTPListViewController : UITableViewController

@property (nonatomic, strong, readwrite) NSString * url_str;
@property (nonatomic, copy,   readwrite) NSString *        title;

@end
