//
//  ZKPerson.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKPerson.h"

@interface ZKPerson ()

@property (strong, nonatomic) SKAction *leftAction;
@property (strong, nonatomic) SKAction *rightAction;
@property (strong, nonatomic) SKAction *upAction;
@property (strong, nonatomic) SKAction *downAction;

@property (strong, nonatomic) SKTexture *leftStanding;
@property (strong, nonatomic) SKTexture *rightStanding;
@property (strong, nonatomic) SKTexture *upStanding;
@property (strong, nonatomic) SKTexture *downStanding;

@end

@implementation ZKPerson

- (id)initWithPosition:(CGPoint)position {
	if ((self = [super init])) {
		NSArray *people = @[ @"ManImages", @"RedMan", @"girl" ];
		
		SKTextureAtlas *manAtlas = [SKTextureAtlas atlasNamed:people[rand() % people.count]];
		
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
		
		[self setPosition:position];
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

- (void)showGoodBubble {
	int number = rand() % 4 + 1;
	SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"GoodBubbles"];
	[self showbubble:number fromSet:atlas];
}

- (void)showBadBubble {
	int number = rand() % 4 + 1;
	SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"BadBubbles"];
	[self showbubble:number fromSet:atlas];
}

- (void)showbubble:(NSInteger)bid fromSet:(SKTextureAtlas *)atlas {
	SKTexture *texture = [atlas textureNamed:[NSString stringWithFormat:@"%i", bid]];
	SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture];
	node.anchorPoint = CGPointMake(.35, 0);
	node.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height + 5);
	node.size = CGSizeMake(texture.size.width / 2, texture.size.height / 2);
	[self addChild:node];
	
	[self runAction:[SKAction waitForDuration:2] completion:^{
		[node removeFromParent];
	}];
}

@end
