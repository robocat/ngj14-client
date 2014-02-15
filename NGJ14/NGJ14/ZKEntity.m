//
//  ZKEntity.m
//  NGJ14
//
//  Created by Ulrik Damm on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKEntity.h"

#define MOVE_ACTION @"MOVE_ACTION"

@interface ZKEntity ()

@property (assign, nonatomic) ZKWalkingDirection direction;
@property (strong, nonatomic) NSValue *nextTarget;
@property (assign, nonatomic, getter = isWalking) BOOL walking;

@end

@implementation ZKEntity

- (id)initWithPosition:(CGPoint)position {
	if ((self = [super init])) {
		self.position = position;
	}
	
	return self;
}

- (SKAction *)actionForDirection:(ZKWalkingDirection)direction {
	return nil;
}

- (SKTexture *)standingTextureForDirection:(ZKWalkingDirection)direction {
	return nil;
}

- (void)startWalking {
	if ([self actionForKey:MOVE_ACTION]) {
		return;
	}
	
	[self runAction:[self actionForDirection:self.direction] withKey:MOVE_ACTION];
}

- (void)stopWalking {
	[self removeActionForKey:MOVE_ACTION];
}

- (void)walkTo:(CGPoint)target {
	if (self.walking) {
		self.nextTarget = [NSValue valueWithCGPoint:target];
		return;
	}
	
	self.walking = YES;
	
	CGFloat angle = atan2f(target.y - self.position.y, target.x - self.position.x);
	angle = angle * (4.0 / (2 * M_PI));
	if (angle < 0) angle += 4;
	angle = round(angle);
	if (angle >= 4) angle -= 4;
	self.direction = angle;
	
	CGFloat dist = sqrt(pow(target.y - self.position.y, 2) + pow(target.x - self.position.x, 2));
	
	[self runAction:[SKAction moveTo:target duration:dist / 50] completion:^{
		[self stopWalking];
		
		self.walking = NO;
		if (self.nextTarget) {
			[self walkTo:[self.nextTarget CGPointValue]];
			self.nextTarget = nil;
		} else if (self.removeOnStop) {
			[self removeFromParent];
		}
	}];
	
	[self startWalking];
}

@end
