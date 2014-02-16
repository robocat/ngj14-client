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
#import "ZKConnection.h"


@interface ZKViewController () <ZKConnectionDelegate>

@property (strong) AVAudioPlayer *musicPlayer;

@property (strong) ZKConnection *connection;

@property (assign) NSInteger animalCount;
@property (assign) ZKAnimalType animalType;
@property (strong) NSMutableArray *animalIds;
@property (strong) NSString *gameName;
@property (assign) ZKMessageType messageType;
@property (assign) NSInteger participants;
@property (assign) NSInteger spectatorTotal;
@property (assign) CGFloat happiness;


@property (strong) ZKMenuScene *menuScene;
@property (strong) ZKMyScene *gameScene;

@end


@implementation ZKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self startMenu];
	[self connectServer];
//	[self startGame];
	

//	NSError *error;
//	NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"theme" withExtension:@"m4a"];
//	_musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
//	_musicPlayer.numberOfLoops = -1;
//	[_musicPlayer prepareToPlay];
//	[_musicPlayer play];
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
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
	
    _menuScene = [ZKMenuScene sceneWithSize:skView.bounds.size];
    _menuScene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:_menuScene];
	
	_menuScene.peopleCount = 1;
}


- (void)startGame
{
	SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    _gameScene = [ZKMyScene sceneWithSize:skView.bounds.size];
    _gameScene.scaleMode = SKSceneScaleModeAspectFill;
	_gameScene.viewController = self;
	_gameScene.peopleCount = _spectatorTotal;
	_gameScene.happiness = _happiness;
	
	[_gameScene setAnimalType:_animalType count:_animalCount animalIds:_animalIds];
	
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

- (void)makeKill:(NSInteger)animalId
{
	[_connection sendData:@{ @"msgtype": [NSString stringWithFormat:@"%d", ZKMessageTypeAnimalKillRequest], @"animalid": @(animalId) }];
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
		case ZKMessageTypeResult: {
			_participants = [[data objectForKey:@"participants"] integerValue];
			_menuScene.peopleCount = _participants;
			break;
		}
		case ZKMessageTypeGameStart: {
			_animalCount = [[data objectForKey:@"animalcount"] integerValue];
			_animalType = (ZKAnimalType)[[data objectForKey:@"animaltype"] integerValue];
			_animalIds = [[data objectForKey:@"animalids"] mutableCopy];
			_spectatorTotal = [[data objectForKey:@"spectators"] integerValue];
			_happiness = [[data objectForKey:@"happiness"] floatValue];
			
			[self performSelector:@selector(startGame) withObject:nil afterDelay:3];
			
			break;
		}
		case ZKMessageTypeAnimalKillRequest:
			break;
		case ZKMessageTypeAnimalKillReply: {
			break;
		}
		case ZKMessageTypeMakeEventRequest:
			break;
		case ZKMessageTypeMakeEventReply: {
			[_gameScene doEvent];
			break;
		}
		case ZKMessageTypeAnimalDead: {

			break;
		}
		case ZKMessageTypeAnimalSick: {
			NSInteger animalId = [[data objectForKey:@"animalid"] integerValue];
			[_gameScene animalSick:animalId];
			break;
		}
		case ZKMessageTypeSpectator: {
			NSInteger spectatorTotal = [[data objectForKey:@"totalcount"] integerValue];
			_gameScene.peopleCount = spectatorTotal;
			break;
		}
		case ZKMessageTypePRPoints: {
			NSInteger prPoints = [[data objectForKey:@"totalcount"] integerValue];
			_gameScene.prPoints = prPoints;
			break;
		}
		case ZKMessageTypeAnimalDiedFromSickness: {
			NSInteger animalId = [[data objectForKey:@"animalid"] integerValue];
			[_gameScene animalDead:animalId];
			break;
		}
		case ZKMessageTypeHappiness: {
			CGFloat happiness = [[data objectForKey:@"happiness"] floatValue];
			_gameScene.happiness = happiness;
			break;
		}
		case ZKMessageTypeNewAnimal: {
			ZKAnimalType aType = (ZKAnimalType)[[data objectForKey:@"animaltype"] integerValue];
			NSArray *aIds = [[data objectForKey:@"animalid"] mutableCopy];
			[_gameScene newAnimalType:aType count:0 animalIds:aIds];
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
