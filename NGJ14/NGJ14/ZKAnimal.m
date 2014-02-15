//
//  ZKAnimal.m
//  NGJ14
//
//  Created by Ulrik Damm on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKAnimal.h"

@interface ZKAnimal ()

@property (strong, nonatomic) SKTexture *texture1;
@property (strong, nonatomic) SKTexture *texture2;
@property (strong, nonatomic) SKTexture *texture3;

@end

@implementation ZKAnimal

- (id)initWithPosition:(CGPoint)position atlas:(SKTextureAtlas *)atlas {
	if ((self = [super initWithPosition:position])) {
		self.texture1 = [atlas textureNamed:@"1"];
		self.texture2 = [atlas textureNamed:@"2"];
		self.texture3 = [atlas textureNamed:@"3"];
		
		self.texture = self.texture1;
		self.size = self.texture.size;
		
		self.anchorPoint = CGPointMake(0.5, 0);
	}
	
	return self;
}

- (SKAction *)actionForDirection:(ZKWalkingDirection)direction {
	if (direction == ZKWalkingLeft) {
		[self setXScale:1];
	} else if (direction == ZKWalkingRight) {
		[self setXScale:-1];
	}
	
	return [SKAction repeatActionForever:[SKAction animateWithTextures:@[ self.texture1, self.texture2 ] timePerFrame:0.3 resize:NO restore:NO]];
}

- (SKTexture *)standingTextureForDirection:(ZKWalkingDirection)direction {
	return nil;
}


- (SKAction *)doEvent
{
	NSArray *eventFrames = @[ _texture1, _texture3 ];
	
	CGFloat time = 0.2;
	
	return [SKAction repeatActionForever:[SKAction animateWithTextures:eventFrames timePerFrame:time resize:NO restore:YES]];
}
@end
