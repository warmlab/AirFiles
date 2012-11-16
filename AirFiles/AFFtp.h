//
//  AFftp.h
//  AirFiles
//
//  Created by test on 10/19/12.
//  Copyright (c) 2012 Websense. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AFFtpDelegate <NSObject>

-(void) didFinishListing;

@end

@interface AFFtp : NSObject <NSStreamDelegate>

@property (atomic, readonly) BOOL isReceiveFinished;
@property (nonatomic, strong, readwrite) NSURL *url;
@property (nonatomic, strong, readonly) NSMutableArray *  listEntries;

@property (nonatomic, strong, readwrite) id<AFFtpDelegate> delegate;
//@property (nonatomic, readwrite) SEL selector;

- (AFFtp *)init;
- (AFFtp *)initWithUrl: (NSString *)u;
- (NSInteger) openFtpClient;

@end
