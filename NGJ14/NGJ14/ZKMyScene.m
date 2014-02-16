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

@interface ZKMyScene () <ZKAnimalDelegate>

@property (strong, nonatomic) NSMutableArray *people;
@property (strong, nonatomic) NSMutableArray *animals;

@property (strong, nonatomic) SKSpriteNode *fgImage;

@property (assign) BOOL isShowingEvent;

@end

@implementation ZKMyScene

- (id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
		srand((int)time(NULL));
		
		SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:@"savanna_ground"];
		ground.anchorPoint = CGPointMake(0, 0);
		ground.position = CGPointMake(0, self.frame.size.height - 320);
		[self addChild:ground];
		
		self.fgImage = [SKSpriteNode spriteNodeWithImageNamed:@"fg"];
		self.fgImage.anchorPoint = CGPointMake(0, 0);
		self.fgImage.position = CGPointMake(0, self.frame.size.height - 320);
		[self addChild:self.fgImage];
		
		self.fgImage.zPosition = -320 + self.frame.size.height;
		
		self.animals = [NSMutableArray array];
		self.people = [NSMutableArray array];
		
		[self setAnimalType:ZKAnimalTypeZebra count:3];
		
		self.happiness = 0.5;
		
		[self addChild:[self showButtonNode]];
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


- (void)setAnimalType:(ZKAnimalType)animalType count:(NSInteger)count
{
	NSString *animalName = nil;
	switch (animalType) {
		case ZKAnimalTypeZebra:
			animalName = @"Zebra";
			break;
		case ZKAnimalTypeGiraffe:
			animalName = @"Giraffe";
			break;
		case ZKAnimalTypeLion:
			animalName = @"Lion";
			break;
		default:
			animalName = @"Lion";
			break;
	}
	
	for (int i = 0; i < count; i++) {
		ZKAnimal *animal1 = [[ZKAnimal alloc] initWithPosition:CGPointMake(160, 400) atlas:[SKTextureAtlas atlasNamed:animalName]];
		animal1.name = @"animal";
		[self.animals addObject:animal1];
		[self addChild:animal1];
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
	
	if (!self.isShowingEvent) {
		for (ZKAnimal *animal in self.animals) {
			animal.zPosition = -animal.position.y + self.frame.size.height;
			
			if (rand() % 100 == 0) {
				[self moveAnimal:animal];
			}
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
	UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
	
    if ([node.name isEqualToString:@"showButton"]) {
		self.isShowingEvent = !self.isShowingEvent;
		
		if (self.isShowingEvent) {
			[self.viewController makeEvent:self.isShowingEvent];
		} else {
			[self endEvent];
		}
    }
	
	if ([node.name isEqualToString:@"animal"]) {
		ZKAnimal *animal = (ZKAnimal *)node;
		animal.dead = YES;
		
		NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"Spark" ofType:@"sks"];
		SKEmitterNode *bloodEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
		bloodEmitter.zPosition = self.fgImage.zPosition - 100;
		bloodEmitter.particlePosition = [touch locationInNode:self];
		
		[self addChild:bloodEmitter];
		
		[self runAction:[SKAction waitForDuration:0.1] completion:^{
			bloodEmitter.particleBirthRate = 0;
			[self runAction:[SKAction waitForDuration:.5] completion:^{
				[bloodEmitter removeFromParent];
			}];
		}];
    }
}

- (SKSpriteNode *)showButtonNode {
    SKSpriteNode *showNode = [SKSpriteNode spriteNodeWithImageNamed:@"show"];
    showNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-100);
    showNode.name = @"showButton";
    showNode.zPosition = 1.0;
    return showNode;
}

- (void)doEvent {
	self.isShowingEvent = YES;
	
	CGFloat distance = self.frame.size.width / (self.animals.count + 1);
	
	void (^finish)(void) = ^{
		for (ZKAnimal *animal in self.animals) {
			[animal performEvent];
		}
	};
	
	__block int finishes = 0;
	
	int i;
	for (i = 0; i < self.animals.count; i++) {
		ZKAnimal *animal = self.animals[i];
		[animal walkTo:CGPointMake(distance * (i + 1), self.frame.size.height - 150) withCompletion:^{
			finishes++;
			
			if (finishes == self.animals.count) {
				finish();
			}
		}];
	}
}

- (void)endEvent {
	self.isShowingEvent = NO;
	
	for (ZKAnimal *animal in self.animals) {
		[animal stopEvent];
		[animal walkTo:[self randomAnimalPoint]];
	}
}

#pragma mark - ZKAnimalDelegate

- (void)animalWasRemoved:(ZKAnimal *)animal {
	[self.animals removeObject:animal];
}

@end
