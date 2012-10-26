//
//  AFService.h
//  AirFiles
//
//  Created by test on 10/26/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AFService : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic) int16_t pk;
@property (nonatomic) int16_t protocol;

@end
