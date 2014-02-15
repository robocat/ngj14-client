//
//  ZKViewController.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKViewController.h"
#import "ZKMyScene.h"

#import "ZKConnection.h"

@interface ZKViewController () <ZKConnectionDelegate>

@property (strong) ZKConnection *connection;

@end


@implementation ZKViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    SKScene *scene = [ZKMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:scene];
	
	[self startGame];
}


- (void)startGame
{
	NSString *ip = @"172.30.214.64";
	NSInteger port = 3456;
	
	_connection = [[ZKConnection alloc] initWithHost:ip port:port];
	
	[self startNewGame];
	
}


- (void)startNewGame
{
	[_connection sendData:@{ @"msgtype": @"1", @"gamename": @"test1" }];
}



#pragma mark - Connection delegate

- (void)conneciton:(ZKConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Did fail with error");
}

- (void)conneciton:(ZKConnection *)connection didGetData:(NSDictionary *)data {
	NSLog(@"Did get data: %@", data);
}

@end
