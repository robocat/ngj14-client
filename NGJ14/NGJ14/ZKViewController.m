//
//  ZKViewController.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKViewController.h"
#import "ZKMyScene.h"
#import "ZKMenuScene.h"


typedef enum {
	ZKAnimalTypeZebra = 0,
	ZKAnimalTypeGiraffe,
	ZKAnimalTypeLion
} ZKAnimalType;


typedef enum {
	ZKMessageTypeConnect = 1,
	ZKMessageTypeResult,
	ZKMessageTypeGameStart,
	ZKMessageTypeAnimalKillRequest,
	ZKMessageTypeAnimalKillReply,
	ZKMessageTypeMakeEventRequest,
	ZKMessageTypeMakeEventReply,
	ZKMessageTypeAnimalDead,
	ZKMessageTypeAnimalSick,
	ZKMessageTypeSpectator,
	ZKMessageTypePRPoints,
} ZKMessageType;


#import "ZKConnection.h"

@interface ZKViewController () <ZKConnectionDelegate>

@property (strong) ZKConnection *connection;

@property (assign) NSInteger animalCount;
@property (assign) ZKAnimalType animalType;
@property (strong) NSString *gameName;
@property (assign) ZKMessageType messageType;
@property (assign) NSInteger participants;


@property (strong) SKScene *menuScene;
@property (strong) SKScene *gameScene;

@end


@implementation ZKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
//	[self startMenu];
	[self startGame];
//	[self connectServer];
}

- (void)connectServer
{
	NSString *ip = @"172.30.214.64";
	NSInteger port = 3456;
	
	_connection = [[ZKConnection alloc] initWithHost:ip port:port];
	_connection.delegate = self;
	
	[self startNewGame];
}

- (void)startMenu
{
	SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
	
    SKScene *scene = [ZKMenuScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
}


- (void)startGame
{
	SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    SKScene *scene = [ZKMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
	
	SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
    [skView presentScene:scene transition:doors];
}


- (void)startNewGame
{
	[_connection sendData:@{ @"msgtype": [NSString stringWithFormat:@"%d", ZKMessageTypeConnect], @"gamename": @"ZooKiller" }];
}



#pragma mark - Connection delegate

- (void)conneciton:(ZKConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Did fail with error");
}

- (void)conneciton:(ZKConnection *)connection didGetData:(NSDictionary *)data {
	NSLog(@"Did get data: %@", data);
	
	NSInteger msgType = [[data objectForKey:@"msgtype"] integerValue];
	
	switch (msgType) {
		case ZKMessageTypeConnect:
			break;
		case ZKMessageTypeResult:
		{
			_participants = [[data objectForKey:@"participants"] integerValue];
			[self startGame];
			break;
		}
		case ZKMessageTypeGameStart:
		{
//			[self startGame];
			break;
		}
		case ZKMessageTypeAnimalKillRequest:
		{
			
			break;
		}
		case ZKMessageTypeAnimalKillReply:
		{
			
			break;
		}
		case ZKMessageTypeMakeEventRequest:
		{
			
			break;
		}
		case ZKMessageTypeMakeEventReply:
		{
			
			break;
		}
		case ZKMessageTypeAnimalDead:
		{
			
			break;
		}
		case ZKMessageTypeAnimalSick:
		{
			
			break;
		}
		case ZKMessageTypeSpectator:
		{
			
			break;
		}
		case ZKMessageTypePRPoints:
		{
			
			break;
		}
		default:
			break;
	}
	
}

@end
