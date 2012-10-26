//
//  AFServerAddViewController.h
//  AirFiles
//
//  Created by test on 10/25/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AFServerAddViewControllerDelegate <NSObject>

-(void)reload_data_and_close;

@end

@interface AFServerAddViewController : UIViewController<UIPopoverControllerDelegate>

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) IBOutlet UITextField *input_name, *input_url;
@property (nonatomic, retain) IBOutlet UINavigationBar *title_bar;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
