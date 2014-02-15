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

@end

@implementation ZKPerson

+ (ZKPerson *)person {
	SKTextureAtlas *manAtlas = [SKTextureAtlas atlasNamed:@"ManImages"];
	
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
	
	ZKPerson *person = [[ZKPerson alloc] init];
	
	NSArray *walkLeftFrames = @[ left1, left2, left1, left3 ];
	NSArray *walkRightFrames = @[ right1, right2, right1, right3 ];
	NSArray *walkUpFrames = @[ up1, up2, up1, up3 ];
	NSArray *walkDownFrames = @[ down1, down2, down1, down3 ];
	
	person.texture = left1;
	person.size = left1.size;
	
	person.leftAction = [SKAction repeatActionForever:[SKAction animateWithTextures:walkLeftFrames timePerFrame:0.5 resize:NO restore:YES]];
	person.rightAction = [SKAction repeatActionForever:[SKAction animateWithTextures:walkRightFrames timePerFrame:0.5 resize:NO restore:YES]];
	person.upAction = [SKAction repeatActionForever:[SKAction animateWithTextures:walkUpFrames timePerFrame:0.5 resize:NO restore:YES]];
	person.downAction = [SKAction repeatActionForever:[SKAction animateWithTextures:walkDownFrames timePerFrame:0.5 resize:NO restore:YES]];
	
	return person;
}

- (SKAction *)actionForDirection:(ZKWalkingDirection)direction {
	switch (direction) {
		case ZKWalkingLeft: return self.leftAction; break;
		case ZKWalkingRight: return self.rightAction; break;
		case ZKWalkingUp: return self.upAction; break;
		case ZKWalkingDown: return self.downAction; break;
	}
}

- (void)startWalking {
	if ([self actionForKey:MOVE_ACTION]) {
		[self removeActionForKey:MOVE_ACTION];
	}
	
	[self runAction:[self actionForDirection:self.direction] withKey:MOVE_ACTION];
}

- (void)stopWalking {
	[self removeActionForKey:MOVE_ACTION];
}

@end
