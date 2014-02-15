//
//  ZKConnection.m
//  NGJ14
//
//  Created by Ulrik Damm on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKConnection.h"

@interface ZKConnection () <NSStreamDelegate>

@property (strong, nonatomic) NSInputStream *inputStream;
@property (strong, nonatomic) NSOutputStream *outputStream;

@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation ZKConnection

- (id)initWithHost:(NSString *)host port:(uint16_t)port {
	if ((self = [super init])) {
		CFReadStreamRef readStream;
		CFWriteStreamRef writeStream;
		CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)(host), port, &readStream, &writeStream);
		self.inputStream = (__bridge NSInputStream *)(readStream);
		self.outputStream = (__bridge NSOutputStream *)(writeStream);
		
		[self.inputStream setDelegate:self];
		[self.outputStream setDelegate:self];
		
		[self.inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
		[self.outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
		
		[self.inputStream open];
		[self.outputStream open];
		
		self.datas = [NSMutableArray array];
	}
	
	return self;
}

- (void)sendData:(NSDictionary *)data {
	if ([self.outputStream hasSpaceAvailable]) {
		[self sendNow:data];
	} else {
		[self.datas addObject:data];
	}
}

- (void)sendNow:(NSDictionary *)dict {
	NSData *obj = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
	[self.outputStream write:obj.bytes maxLength:obj.length];
}

#pragma mark - Steam delegate

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
	switch (eventCode) {
		case NSStreamEventNone: break;
		case NSStreamEventOpenCompleted: NSLog(@"RKSimulatorCommunicator: Connection opened"); break;
		case NSStreamEventHasBytesAvailable: {
			if (aStream == self.inputStream) {
				uint8_t buffer[1024];
				
				NSMutableData *data = [NSMutableData data];
				
				while ([self.inputStream hasBytesAvailable]) {
					int len = [self.inputStream read:buffer maxLength:sizeof(buffer)];
					if (len > 0) {
						[data appendBytes:buffer length:len];
					}
				}
				
				NSError *error;
				id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
				
				if (error) {
					NSLog(@"Invalid data: %@", error);
				}
				
				if (self.delegate && [self.delegate respondsToSelector:@selector(conneciton:didGetData:)]) {
					[self.delegate conneciton:self didGetData:obj];
				}
			}
			break;
		}
		case NSStreamEventHasSpaceAvailable: {
			for (NSDictionary *obj in self.datas) {
				if (self.outputStream.hasSpaceAvailable) {
					[self sendNow:obj];
				}
			}
			
			break;
		}
		case NSStreamEventErrorOccurred: {
			if (self.delegate && [self.delegate respondsToSelector:@selector(connection:didFailWithError:)]) {
				[self.delegate conneciton:self didFailWithError:[NSError errorWithDomain:@"cat.robo" code:0 userInfo:nil]];
			}
			break;
		}
		case NSStreamEventEndEncountered: break;
	}
}

@end
