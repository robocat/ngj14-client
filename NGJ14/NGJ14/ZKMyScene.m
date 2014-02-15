//
//  ZKMyScene.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKMyScene.h"
#import "ZKPerson.h"
#import "ZKAnimal.h"

@interface ZKMyScene ()

@property (strong, nonatomic) NSMutableArray *people;
@property (strong, nonatomic) NSMutableArray *animals;

@end

@implementation ZKMyScene

- (id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
		srand(time(NULL));
		
		SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:@"savanna_ground"];
		ground.anchorPoint = CGPointMake(0, 0);
		ground.position = CGPointMake(0, self.frame.size.height - 320);
		[self addChild:ground];
		
		SKSpriteNode *fgImage = [SKSpriteNode spriteNodeWithImageNamed:@"fg"];
		fgImage.anchorPoint = CGPointMake(0, 0);
		fgImage.position = CGPointMake(0, self.frame.size.height - 320);
		[self addChild:fgImage];
		
		fgImage.zPosition = -320 + self.frame.size.height;
		
		self.animals = [NSMutableArray array];
		self.people = [NSMutableArray array];
		
		[self.animals addObject:[[ZKAnimal alloc] initWithPosition:CGPointMake(160, 400) atlas:[SKTextureAtlas atlasNamed:@"Zebra"]]];
		[self.animals addObject:[[ZKAnimal alloc] initWithPosition:CGPointMake(160, 400) atlas:[SKTextureAtlas atlasNamed:@"Zebra"]]];
		[self addChild:self.animals[0]];
		[self addChild:self.animals[1]];
		
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

- (void)moveAnimal:(ZKAnimal *)animal {
	if (![animal isWalking]) {
		[animal walkTo:[self randomAnimalPoint]];
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
	
	for (ZKAnimal *animal in self.animals) {
		animal.zPosition = -animal.position.y + self.frame.size.height;
		
		if (rand() % 100 == 0) {
			[self moveAnimal:animal];
		}
	}
}

- (CGPoint)randomVisitorPoint {
	return CGPointMake(rand() % 320, self.frame.size.height - 320 + rand() % (13 * 4));
}

- (CGPoint)randomAnimalPoint {
	return CGPointMake(rand() % (320 - 100) + 50, self.frame.size.height - (rand() % (320 - 120) + 50));
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	self.peopleCount = rand() % 10;
}

@end
