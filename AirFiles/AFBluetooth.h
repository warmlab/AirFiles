//
//  AFBluetooth.h
//  CBDemo
//
//  Created by Sergio on 25/01/12.
//  Copyright (c) 2012 Sergio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface AFBluetooth : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>
{
    CBCentralManager *manager;
    NSMutableArray *perpherals;
}

@property (nonatomic, retain) NSMutableArray *perpherals;
@end
