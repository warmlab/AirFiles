//
//  AFBluetooth.m
//  CBDemo
//
//  Created by Sergio on 25/01/12.
//  Copyright (c) 2012 Sergio. All rights reserved.
//

#import "AFBluetooth.h"

@interface AFBluetooth (Private)

@end

@implementation AFBluetooth
{
    NSDictionary *dictionary;
}

@synthesize perpherals;

- (AFBluetooth*) init
{
    manager = [[CBCentralManager alloc] initWithDelegate: self queue:nil];
    
    // Scan for devices
    dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    //[manager scanForPeripheralsWithServices:nil options:dictionary];
    // [manager scanForPeripheralsWithServices:[NSArray arrayWithObjects:[CBUUID UUIDWithString:@"180A"],[CBUUID UUIDWithString:@"180D"],nil] options:dictionary];

    
    return self;
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    
    NSLog(@"%@",[advertisementData description]);
}


// Process peripherals and pick random one
- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals
{
    // chose peripheral and connect
    [manager connectPeripheral:[perpherals objectAtIndex:0]options:[NSDictionary dictionary]];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSString *messtoshow;
    
    switch (central.state) {
        case CBCentralManagerStateUnknown:
        {
            messtoshow=[NSString stringWithFormat:@"State unknown, update imminent."];
            break;
        }
        case CBCentralManagerStateResetting:
        {
            messtoshow=[NSString stringWithFormat:@"The connection with the system service was momentarily lost, update imminent."];
            break;
        }
        case CBCentralManagerStateUnsupported:
        {
            messtoshow=[NSString stringWithFormat:@"The platform doesn't support Bluetooth Low Energy"];
            break;
        }
        case CBCentralManagerStateUnauthorized:
        {
            messtoshow=[NSString stringWithFormat:@"The app is not authorized to use Bluetooth Low Energy"];
            break;
        }
        case CBCentralManagerStatePoweredOff:
        {
            messtoshow=[NSString stringWithFormat:@"Bluetooth is currently powered off."];
            break;
        }
        case CBCentralManagerStatePoweredOn:
        {
            messtoshow=[NSString stringWithFormat:@"Bluetooth is currently powered on and available to use."];
            [manager scanForPeripheralsWithServices:[NSArray arrayWithObjects:[CBUUID UUIDWithString:@"180A"],[CBUUID UUIDWithString:@"180D"],[CBUUID UUIDWithString:@"180B"],[CBUUID UUIDWithString:@"180C"],[CBUUID UUIDWithString:@"2A1E"],
                                                     [CBUUID UUIDWithString:@"2A1C"],
                                                     [CBUUID UUIDWithString:@"2A21"],nil] options:dictionary];
            [manager retrieveConnectedPeripherals];
            
            //--- it works, I Do get in this area!
            
            break;
        }
            
    }
    NSLog(@"%@", messtoshow);
}


// Get notified when connection with peripheral is complete and write a value to a characteristic on the peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    //Write value to a characteristic
    int i = 1;
    [peripheral writeValue:[NSData dataWithBytes:&i length:sizeof(i)] forCharacteristic:[[peripheral.services[0] characteristics ] objectAtIndex:0] type:CBCharacteristicWriteWithoutResponse];
}

@end
