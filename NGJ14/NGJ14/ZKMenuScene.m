//
//  ZKMenuScene.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKMenuScene.h"

@implementation ZKMenuScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
		SKSpriteNode *fgImage = [SKSpriteNode spriteNodeWithImageNamed:@"fg"];
		fgImage.anchorPoint = CGPointMake(0, 0);
        fgImage.position = CGPointMake(0, 0);
		[self addChild:fgImage];
		
    }
	
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
//	[self.person walkTo:[touch locationInNode:self]];
}

- (void)update:(CFTimeInterval)currentTime {
	
}

@end
