//
//  ZKPerson.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKPerson.h"

#define MOVE_ACTION @"MOVE_ACTION"

@interface ZKPerson ()

@property (strong, nonatomic) SKAction *leftAction;
@property (strong, nonatomic) SKAction *rightAction;
@property (strong, nonatomic) SKAction *upAction;
@property (strong, nonatomic) SKAction *downAction;

@property (strong, nonatomic) SKTexture *leftStanding;
@property (strong, nonatomic) SKTexture *rightStanding;
@property (strong, nonatomic) SKTexture *upStanding;
@property (strong, nonatomic) SKTexture *downStanding;

@property (assign, nonatomic) ZKWalkingDirection direction;

@property (assign, nonatomic, getter = isWalking) BOOL walking;
@property (strong, nonatomic) NSValue *nextTarget;

@end

@implementation ZKPerson

- (id)initWithPosition:(CGPoint)position {
	if ((self = [super init])) {
		SKTextureAtlas *manAtlas = [SKTextureAtlas atlasNamed:rand() % 2 == 0? @"ManImages": @"RedMan"];
		
		SKTexture *left1 = [manAtlas textureNamed:@"left_1"];
		SKTexture *left2 = [manAtlas textureNamed:@"left_2"];
		SKTexture *left3 = [manAtlas textureNamed:@"left_3"];
		
		SKTexture *right1 = [manAtlas textureNamed:@"right_1"];
		SKTexture *right2 = [manAtlas textureNamed:@"right_2"];
		SKTexture *right3 = [manAtlas textureNamed:@"right_3"];
		
		SKTexture *up1 = [manAtlas textureNamed:@"back_1"];
		SKTexture *up2 = [manAtlas textureNamed:@"back_2"];
		SKTexture *up3 = [manAtlas textureNamed:@"back_3"];
		
		SKTexture *down1 = [manAtlas textureNamed:@"front_1"];
		SKTexture *down2 = [manAtlas textureNamed:@"front_2"];
		SKTexture *down3 = [manAtlas textureNamed:@"front_3"];
		
		NSArray *walkLeftFrames = @[ left1, left2, left1, left3 ];
		NSArray *walkRightFrames = @[ right1, right2, right1, right3 ];
		NSArray *walkUpFrames = @[ up1, up2, up1, up3 ];
		NSArray *walkDownFrames = @[ down1, down2, down1, down3 ];
		
		self.texture = up1;
		self.size = left1.size;
		
		self.leftStanding = left1;
		self.rightStanding = right1;
		self.upStanding = up1;
		self.downStanding = down1;
		
		CGFloat time = 0.2;
		self.leftAction = [SKAction repeatActionForever:[SKAction animateWithTextures:walkLeftFrames timePerFrame:time resize:NO restore:YES]];
		self.rightAction = [SKAction repeatActionForever:[SKAction animateWithTextures:walkRightFrames timePerFrame:time resize:NO restore:YES]];
		self.upAction = [SKAction repeatActionForever:[SKAction animateWithTextures:walkUpFrames timePerFrame:time resize:NO restore:YES]];
		self.downAction = [SKAction repeatActionForever:[SKAction animateWithTextures:walkDownFrames timePerFrame:time resize:NO restore:YES]];
		
		self.anchorPoint = CGPointMake(0.5, 0);
	}
	
	return self;
}

- (SKAction *)actionForDirection:(ZKWalkingDirection)direction {
	switch (direction) {
		case ZKWalkingLeft: return self.leftAction; break;
		case ZKWalkingRight: return self.rightAction; break;
		case ZKWalkingUp: return self.upAction; break;
		case ZKWalkingDown: return self.downAction; break;
	}
}

- (SKTexture *)standingTextureForDirection:(ZKWalkingDirection)direction {
	switch (direction) {
		case ZKWalkingLeft: return self.leftStanding; break;
		case ZKWalkingRight: return self.rightStanding; break;
		case ZKWalkingUp: return self.upStanding; break;
		case ZKWalkingDown: return self.downStanding; break;
	}
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
		self.texture = self.upStanding;
		
		self.walking = NO;
		if (self.nextTarget) {
			[self walkTo:[self.nextTarget CGPointValue]];
			self.nextTarget = nil;
		}
	}];
	
	[self startWalking];
}

@end
