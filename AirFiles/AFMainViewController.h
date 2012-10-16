//
//  AFMainViewController.h
//  AirFiles
//
//  Created by test on 10/15/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFMainViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
