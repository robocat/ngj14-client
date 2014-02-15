//
//  ZKMyScene.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKMyScene.h"
#import "ZKPerson.h"

@interface ZKMyScene ()

@end

@implementation ZKMyScene

- (id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
		SKSpriteNode *fgImage = [SKSpriteNode spriteNodeWithImageNamed:@"fg"];
        fgImage.position = CGPointMake(0, 0);
		[self addChild:fgImage];
    }
	
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	self.man1.direction = ZKWalkingLeft;
//	[self.man1 startWalking];
}

- (void)update:(CFTimeInterval)currentTime {
	
}

@end
