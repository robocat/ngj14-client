//
//  ZKGameController.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKGameController.h"

#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface ZKGameController () <GCDAsyncSocketDelegate>

@property (strong) GCDAsyncSocket *socket;

@end

@implementation ZKGameController

- (void)startGame
{
	_socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
	
	NSError *err = nil;
	NSString *ip = @"172.30.214.64";
	NSInteger port = 3456;
	
	if (![_socket connectToHost:ip onPort:port withTimeout:-1 error:&err])
	{
		// If there was an error, it's likely something like "already connected" or "no delegate set"
		NSLog(@"I goofed: %@", err);
	}
	
	
	[self.socket readDataToLength:2048 withTimeout:10 tag:1];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
	NSLog(@"Error: %@", err);
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Cool, I'm connected! That was easy.");
}

- (void)socket:(GCDAsyncSocket *)sender didReadData:(NSData *)data withTag:(long)tag
{
	NSLog(@"data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

@end
