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
	ZKMessageTypeResult,            // 2
	ZKMessageTypeGameStart,         // 3
	ZKMessageTypeAnimalKillRequest, // 4
	ZKMessageTypeAnimalKillReply,   // 5
	ZKMessageTypeMakeEventRequest,  // 6
	ZKMessageTypeMakeEventReply,    // 7
	ZKMessageTypeAnimalDead,        // 8
	ZKMessageTypeAnimalSick,        // 9
	ZKMessageTypeSpectator,         // 10
	ZKMessageTypePRPoints,          // 11
} ZKMessageType;


#import "ZKConnection.h"

@interface ZKViewController () <ZKConnectionDelegate>

@property (strong) ZKConnection *connection;

@property (assign) NSInteger animalCount;
@property (assign) ZKAnimalType animalType;
@property (strong) NSString *gameName;
@property (assign) ZKMessageType messageType;
@property (assign) NSInteger participants;


@property (strong) ZKMenuScene *menuScene;
@property (strong) ZKMyScene *gameScene;

@end


@implementation ZKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self startMenu];
//	[self startGame];
	[self connectServer];
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
	
    _menuScene = [ZKMenuScene sceneWithSize:skView.bounds.size];
    _menuScene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:_menuScene];
	
	
}


- (void)startGame
{
	SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    _gameScene = [ZKMyScene sceneWithSize:skView.bounds.size];
    _gameScene.scaleMode = SKSceneScaleModeAspectFill;
	_gameScene.viewController = self;
	
	SKTransition *doors = [SKTransition doorsOpenHorizontalWithDuration:1];
    [skView presentScene:_gameScene transition:doors];
}


// Requests

- (void)startNewGame
{
	[_connection sendData:@{ @"msgtype": [NSString stringWithFormat:@"%d", ZKMessageTypeConnect], @"gamename": @"ZooKiller" }];
}

- (void)makeEvent:(BOOL)start
{
	[_connection sendData:@{ @"msgtype": [NSString stringWithFormat:@"%d", ZKMessageTypeMakeEventRequest], @"start": @(start) }];
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
			_menuScene.peopleCount = _participants++;
			_menuScene.peopleCount = _participants++;
			_menuScene.peopleCount = _participants;
			break;
		}
		case ZKMessageTypeGameStart:
		{
			_animalCount = [[data objectForKey:@"animalcount"] integerValue];
			_animalType = [[data objectForKey:@"animaltype"] integerValue];
			
			[self performSelector:@selector(startGame) withObject:nil afterDelay:5];
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
			break;
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
//			animatId = [[data objectForKey:@"id"] integerValue];
			break;
		}
		case ZKMessageTypeSpectator:
		{
			NSInteger spectatorTotal = [[data objectForKey:@"totalcount"] integerValue];
			_gameScene.peopleCount = spectatorTotal;
			break;
		}
		case ZKMessageTypePRPoints:
		{
//			prPoints = [[data objectForKey:@"totalcount"] integerValue];
			break;
		}
		default:
			break;
	}
}

- (BOOL)prefersStatusBarHidden {
	return YES;
}

@end
