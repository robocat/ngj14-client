//
//  ZKConnection.h
//  NGJ14
//
//  Created by Ulrik Damm on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZKConnection;

@protocol ZKConnectionDelegate <NSObject>

- (void)conneciton:(ZKConnection *)connection didGetData:(NSDictionary *)data;

- (void)conneciton:(ZKConnection *)connection didFailWithError:(NSError *)error;

@end

@interface ZKConnection : NSObject

@property (weak, nonatomic) id<ZKConnectionDelegate> delegate;

- (id)initWithHost:(NSString *)host port:(uint16_t)port;

- (void)sendData:(NSDictionary *)data;

@end
