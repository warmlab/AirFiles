//
//  AFProtocol.h
//  AirFiles
//
//  Created by test on 10/19/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AFProtocol : NSManagedObject

@property (nonatomic) int16_t pk;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;

@end
