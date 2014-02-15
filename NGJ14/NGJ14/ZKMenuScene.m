//
//  ZKMenuScene.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKMenuScene.h"


@interface ZKMenuScene ()

@property (strong) SKEmitterNode *spark;
@property (assign) NSInteger sparkTime;

@end

@implementation ZKMenuScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
		SKSpriteNode *fgImage = [SKSpriteNode spriteNodeWithImageNamed:@"fg"];
		fgImage.anchorPoint = CGPointMake(0, 0);
        fgImage.position = CGPointMake(0, 0);
		[self addChild:fgImage];
		
		
		NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"Spark" ofType:@"sks"];
		_spark = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
    }
	
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
//	[self.person walkTo:];
	
	
	if ([_spark parent] == nil) {
		_sparkTime = 10;
		[self addChild:_spark];
		_spark.particleBirthRate = 20;
		_spark.particleLifetime = 1;
		_spark.particlePosition = [touch locationInNode:self];
	}
}

- (void)update:(CFTimeInterval)currentTime {
	if (_sparkTime > 0) {
		_sparkTime--;
	}
	else {
		_spark.particleLifetime = 0;
		[_spark removeFromParent];
	}
}

@end
