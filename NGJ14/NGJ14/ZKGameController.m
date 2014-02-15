//
//  ZKGameController.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKGameController.h"

#import "ZKConnection.h"



@interface ZKGameController () <ZKConnectionDelegate>

@property (strong) ZKConnection *connection;

@end

@implementation ZKGameController

- (void)startGame
{
	NSString *ip = @"172.30.214.64";
	NSInteger port = 3456;
	
	_connection = [[ZKConnection alloc] initWithHost:ip port:port];
	
	[_connection sendData:@{ @"msg": @"start"}];
}


#pragma mark - Connection delegate

- (void)conneciton:(ZKConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Did fail with error");
}

- (void)conneciton:(ZKConnection *)connection didGetData:(NSDictionary *)data {
	NSLog(@"Did get data: %@", data);
}

@end
