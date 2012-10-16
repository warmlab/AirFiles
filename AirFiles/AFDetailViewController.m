//
//  AFDetailViewController.m
//  AirFiles
//
//  Created by test on 10/15/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import "AFDetailViewController.h"
#import "AFServiceViewController.h"

@interface AFDetailViewController ()
@end

@implementation AFDetailViewController
{
	UIPopoverController *menuPopoverController;
}

@synthesize toolbar;

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
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	self.toolbar = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

#pragma mark - UISplitViewControllerDelegate

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
	barButtonItem.title = @"Customer";
	NSMutableArray *items = [[self.toolbar items] mutableCopy];
	[items insertObject: barButtonItem atIndex:0];
	[self.toolbar setItems:items animated:YES];
	
	menuPopoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
	NSMutableArray *items = [[self.toolbar items] mutableCopy];
	[items removeObject: barButtonItem];
	[self.toolbar setItems: items animated: YES];

	menuPopoverController = nil;
}

@end
