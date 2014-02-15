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

@property (strong, nonatomic) NSMutableArray *people;
@property (strong, nonatomic) ZKPerson *person;

@end

@implementation ZKMyScene

- (id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
		SKSpriteNode *fgImage = [SKSpriteNode spriteNodeWithImageNamed:@"fg"];
		fgImage.anchorPoint = CGPointMake(0, 0);
        fgImage.position = CGPointMake(0, 0);
		[self addChild:fgImage];
		
		self.person = [[ZKPerson alloc] initWithPosition:CGPointMake(120, 120)];
		[self addChild:self.person];
    }
	
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	[self.person walkTo:[touch locationInNode:self]];
}

- (void)update:(CFTimeInterval)currentTime {
	
}

@end
