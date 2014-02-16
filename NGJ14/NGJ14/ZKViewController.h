//
//  ZKViewController.h
//  NGJ14
//

//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

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
	ZKMessageTypeAnimalDiedFromSickness,    // 12
	ZKMessageTypeHappiness,         // 13
	ZKMessageTypeNewAnimal,         // 14
} ZKMessageType;


@interface ZKViewController : UIViewController

- (void)makeEvent:(BOOL)start;
- (void)makeKill:(NSInteger)animalId;

@end
