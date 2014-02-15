//
//  ZKPerson.h
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


typedef enum {
	ZKReactionGood,
	ZKReactionBad,
} ZKReaction;

typedef enum {
	ZKWalkingLeft,
	ZKWalkingRight,
	ZKWalkingUp,
	ZKWalkingDown,
} ZKWalkingDirection;

@interface ZKPerson : SKSpriteNode

@property (assign) ZKReaction reaction;
@property (assign) CGPoint position;
@property (assign) ZKWalkingDirection direction;

+ (ZKPerson *)person;

- (void)startWalking;
- (void)stopWalking;

@end
