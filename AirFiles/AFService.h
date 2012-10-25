//
//  AFService.h
//  AirFiles
//
//  Created by test on 10/19/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AFProtocol;

@interface AFService : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic) int16_t pk;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) AFProtocol *protocol;

@end
