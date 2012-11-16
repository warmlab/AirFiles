//
//  AFServiceOperate.m
//  AirFiles
//
//  Created by test on 10/26/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import "AFServiceOperate.h"
#import "AFService.h"

#import "AFDataManager.h"

@implementation AFServiceOperate

-(AFServiceOperate *) init
{
    self = [super init];
    return self;
}

-(NSArray *) getServicesByProtocol: (NSInteger)protocol
{
    NSFetchRequest *request = [NSFetchRequest new];
	NSEntityDescription *entity = [NSEntityDescription entityForName: @"Service" inManagedObjectContext: [AFDataManager sharedInstance].mainObjectContext];
	[request setEntity: entity];
	
	NSError *error;
	NSArray *array = [[[AFDataManager sharedInstance].mainObjectContext executeFetchRequest: request error: &error] copy];
    
    NSLog(@"array size: %d", array.count);
    
    return array;
}

-(NSInteger) saveServiceWithName: (NSString *)name withUrl: (NSString *) url withProtocol: (int16_t) protocol
{
    AFService *s = (AFService *)[NSEntityDescription insertNewObjectForEntityForName:@"Service" inManagedObjectContext: [AFDataManager sharedInstance].mainObjectContext];
    
	s.name = name;
	s.url = url;
    s.protocol = protocol;
    s.pk = 1;
	
	[[AFDataManager sharedInstance] save];
    
    return 0;
}

-(NSInteger) removeService: (AFService *)service
{
    //AFService *s = (AFService *)[NSEntityDescription insertNewObjectForEntityForName:@"Service" inManagedObjectContext: [AFDataManager sharedInstance].mainObjectContext];
    NSManagedObject *eventToDelete = [[AFDataManager sharedInstance].mainObjectContext objectWithID: service.objectID];
    [[AFDataManager sharedInstance].mainObjectContext deleteObject: eventToDelete];
    
    [[AFDataManager sharedInstance] save];
    
	return 0;
}

@end
