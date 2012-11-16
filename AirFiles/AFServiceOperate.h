//
//  AFServiceOperate.h
//  AirFiles
//
//  Created by test on 10/26/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFService.h"

@interface AFServiceOperate : NSObject

-(NSArray *) getServicesByProtocol: (NSInteger)protocol;
-(NSInteger) saveServiceWithName: (NSString *)name withUrl: (NSString *) url withProtocol: (int16_t) protocol;
-(NSInteger) removeService: (AFService *)service;

@end
