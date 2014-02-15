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

@end

@implementation ZKMyScene

- (id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
		srand(time(NULL));
		
		SKSpriteNode *fgImage = [SKSpriteNode spriteNodeWithImageNamed:@"fg"];
		fgImage.anchorPoint = CGPointMake(0, 0);
		fgImage.position = CGPointMake(0, self.frame.size.height - 320);
		[self addChild:fgImage];
		
		self.people = [NSMutableArray array];
		
		int i;
		for (i = 0; i < 10; i++) {
			ZKPerson *person = [[ZKPerson alloc] initWithPosition:CGPointMake(120, self.frame.size.height - 320)];
			[self addChild:person];
			[self.people addObject:person];
		}
		
		for (ZKPerson *person in self.people) {
			[self movePerson:person];
		}
    }
	
    return self;
}

- (void)movePerson:(ZKPerson *)person {
	if (![person isWalking]) {
		[person walkTo:[self randomVisitorPoint]];
	}
}

- (void)update:(CFTimeInterval)currentTime {
	for (ZKPerson *person in self.people) {
		person.zPosition = -person.position.y + self.frame.size.height;
		
		if (rand() % 200 == 0) {
			[self movePerson:person];
		}
	}
}

- (CGPoint)randomVisitorPoint {
	return CGPointMake(rand() % 320, self.frame.size.height - 320 + rand() % (15 * 4));
}

@end
