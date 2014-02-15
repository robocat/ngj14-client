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
	ZKWalkingRight,
	ZKWalkingUp,
	ZKWalkingLeft,
	ZKWalkingDown,
} ZKWalkingDirection;

@interface ZKPerson : SKSpriteNode

@property (readonly, nonatomic, getter = isWalking) BOOL walking;

- (id)initWithPosition:(CGPoint)position;

- (void)walkTo:(CGPoint)target;

@end
