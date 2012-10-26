//
//  AFServerAddViewController.m
//  AirFiles
//
//  Created by test on 10/25/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import "AFServerAddViewController.h"
#import "AFServiceOperate.h"
#import "AFCommon.h"

@interface AFServerAddViewController ()

@end

@implementation AFServerAddViewController

@synthesize delegate, input_name, input_url, managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	//UIEvent *event = [UIEvent alloc]
	//[button sendAction: @selector(do_add_server:) to:delegate forEvent: event];
	//[button addTarget:delegate action:@selector(do_add_server:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)do_add:(id)sender
{
	NSLog(@"%s", __func__);
	//[self removeFromParentViewController];
	//[self dismissModalViewControllerAnimated:YES];
	
	// add server

	AFServiceOperate *operate = [AFServiceOperate new];
	operate.managedObjectContext = self.managedObjectContext;
	if (![operate saveServiceWithName:input_name.text withUrl:input_url.text withProtocol:FTP]) {
		[delegate reload_data_and_close];
	}
}

- (IBAction)do_cancel:(id)sender
{
	NSLog(@"%s", __func__);
	[delegate reload_data_and_close];
}

@end
