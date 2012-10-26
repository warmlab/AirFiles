//
//  AFServiceOperate.m
//  AirFiles
//
//  Created by test on 10/26/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import "AFServiceOperate.h"
#import "AFService.h"

@implementation AFServiceOperate

@synthesize managedObjectContext;

-(NSArray *) getServicesByProtocol: (NSInteger)protocol
{
    NSFetchRequest *request = [NSFetchRequest new];
	NSEntityDescription *entity = [NSEntityDescription entityForName: @"Service" inManagedObjectContext: managedObjectContext];
	[request setEntity: entity];
	
	NSError *error;
	return [[managedObjectContext executeFetchRequest: request error: &error] copy];
}

-(NSInteger) saveServiceWithName: (NSString *)name withUrl: (NSString *) url withProtocol: (int16_t) protocol
{
    AFService *s = (AFService *)[NSEntityDescription insertNewObjectForEntityForName:@"Service" inManagedObjectContext: managedObjectContext];
    
	s.name = name;
	s.url = url;
    s.protocol = protocol;
    s.pk = 1;
	
	NSError *error;
	
	if (![managedObjectContext save: &error]) {
		NSLog(@"Save protocol error");
        return 1;
	} else {
		NSLog(@"Save protocol okay");
        return 0;
	}
}
@end
