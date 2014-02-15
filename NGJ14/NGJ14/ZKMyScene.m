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
		
		self.happiness = 0.5;
    }
	
    return self;
}

- (void)setPeopleCount:(NSUInteger)peopleCount {
	while (peopleCount > self.people.count) {
		ZKPerson *person = [[ZKPerson alloc] initWithPosition:CGPointMake(120, self.frame.size.height - 320)];
		[self addChild:person];
		[self.people addObject:person];
		[self movePerson:person];
	}
	
	while (peopleCount < self.people.count) {
		ZKPerson *person = self.people.firstObject;
		[self.people removeObjectAtIndex:0];
		
		[person walkTo:CGPointMake(person.position.x, 0)];
		person.removeOnStop = YES;
	}
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
		} else if (self.happiness > 0 && rand() % (int)(1000 - 1000 * self.happiness + 100) == 0) {
			[person showGoodBubble];
		} else if (self.happiness < 0 && rand() % (int)(1000 - 1000 * (-self.happiness) + 100) == 0) {
			[person showBadBubble];
		}
	}
}

- (CGPoint)randomVisitorPoint {
	return CGPointMake(rand() % 320, self.frame.size.height - 320 + rand() % (13 * 4));
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	self.peopleCount = rand() % 10;
}

@end
