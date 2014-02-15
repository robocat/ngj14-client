//
//  ZKPerson.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKPerson.h"

@implementation ZKPerson

- (id)initPerson {
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
	
	_walkLeftFrames = @[left1, left2, left1, left3];
	_walkRightFrames = @[right1, right2, right1, right3];
	_walkUpFrames = @[up1, up2, up1, up3];
	_walkDownFrames = @[down1, down2, down1, down3];
	
	self = [ZKPerson spriteNodeWithTexture:_walkLeftFrames[0]];
	
	return self;
}


@end
