//
//  ZKEntity.h
//  NGJ14
//
//  Created by Ulrik Damm on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum {
	ZKWalkingRight,
	ZKWalkingUp,
	ZKWalkingLeft,
	ZKWalkingDown,
} ZKWalkingDirection;

@interface ZKEntity : SKSpriteNode

@property (readonly, nonatomic, getter = isWalking) BOOL walking;
@property (assign, nonatomic) BOOL removeOnStop;

- (id)initWithPosition:(CGPoint)position;

- (void)walkTo:(CGPoint)target;
- (void)walkTo:(CGPoint)target withCompletion:(void (^)(void))completion;

- (SKAction *)actionForDirection:(ZKWalkingDirection)direction;
- (SKTexture *)standingTextureForDirection:(ZKWalkingDirection)direction;

- (void)stopWalking;

@end
