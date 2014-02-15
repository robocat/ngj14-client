//
//  ZKAppDelegate.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKAppDelegate.h"
#import "ZKConnection.h"

@interface ZKAppDelegate () <ZKConnectionDelegate>

@property (strong, nonatomic) ZKConnection *connection;

@end

@implementation ZKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.connection = [[ZKConnection alloc] initWithHost:@"172.30.214.64" port:3456];
	
    return YES;
}

#pragma mark - Connection delegate

- (void)conneciton:(ZKConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Did fail with error");
}

- (void)conneciton:(ZKConnection *)connection didGetData:(NSDictionary *)data {
	NSLog(@"Did get data: %@", data);
}

@end
