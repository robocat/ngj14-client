//
//  ZKAnimal.m
//  NGJ14
//
//  Created by Ulrik Damm on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKAnimal.h"

#define EVENT_ACTION @"EVENT_ACTION"

@interface ZKAnimal ()

@property (strong, nonatomic) SKTexture *texture1;
@property (strong, nonatomic) SKTexture *texture2;
@property (strong, nonatomic) SKTexture *texture3;
@property (strong, nonatomic) SKTexture *texture4;
@property (strong, nonatomic) SKTexture *texture5;
@property (strong, nonatomic) SKTexture *texture6;
@property (strong, nonatomic) SKTexture *texture7;

@end

@implementation ZKAnimal

- (id)initWithPosition:(CGPoint)position atlas:(SKTextureAtlas *)atlas {
	if ((self = [super initWithPosition:position])) {
		self.texture1 = [atlas textureNamed:@"1"];
		self.texture2 = [atlas textureNamed:@"2"];
		self.texture3 = [atlas textureNamed:@"3"];
		self.texture4 = [atlas textureNamed:@"4"];
		self.texture5 = [atlas textureNamed:@"5"];
		self.texture6 = [atlas textureNamed:@"6"];
		self.texture7 = [atlas textureNamed:@"7"];
		
		self.texture = self.texture1;
		self.size = self.texture.size;
		
		self.anchorPoint = CGPointMake(0.5, 0);
	}
	
	return self;
}

- (void)stopWalking {
	[super stopWalking];
	
	self.texture = (self.sick? self.texture4: self.texture1);
}

- (SKAction *)actionForDirection:(ZKWalkingDirection)direction {
	if (self.dead) return nil;
	
	if (direction == ZKWalkingLeft) {
		[self setXScale:1];
	} else if (direction == ZKWalkingRight) {
		[self setXScale:-1];
	}
	
	NSArray *textures = self.sick? @[ self.texture4, self.texture5 ]: @[ self.texture1, self.texture2 ];
	
	return [SKAction repeatActionForever:[SKAction animateWithTextures:textures timePerFrame:0.3 resize:NO restore:NO]];
}

- (SKTexture *)standingTextureForDirection:(ZKWalkingDirection)direction {
	return nil;
}

- (void)performEvent {
	if (self.dead) return;
	
	CGFloat time = 0.4;
	SKAction *action = [SKAction repeatActionForever:[SKAction animateWithTextures:@[ self.texture1, self.texture3 ] timePerFrame:time resize:YES restore:YES]];
	
	[self runAction:action withKey:EVENT_ACTION];
}

- (void)stopEvent {
	[self removeActionForKey:EVENT_ACTION];
}

- (void)walkTo:(CGPoint)target withCompletion:(void (^)(void))completion {
	if (self.dead) return;
	
	[super walkTo:target withCompletion:completion];
}

- (void)setSick:(BOOL)sick {
	_sick = sick;
	
	self.texture = self.texture4;
}

- (void)setDead:(BOOL)dead {
	_dead = dead;
	
	[self removeAllActions];
	
	if (dead) {
		if (self.sick) {
			self.texture = self.texture7;
		} else {
			self.texture = self.texture6;
		}
	}
	
	self.size = self.texture.size;
	
	[self runAction:[SKAction waitForDuration:10] completion:^{
		[self removeFromParent];
	}];
}

@end
