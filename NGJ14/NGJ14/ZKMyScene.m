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
@property (strong) SKSpriteNode *prKnob;

@property (assign) BOOL isShowingEvent;

@property (strong, nonatomic) SKSpriteNode *confetti;

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
		
		SKSpriteNode *tree = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"tree"]];
		tree.anchorPoint = CGPointMake(0.5, 0);
		tree.position = CGPointMake(50, self.frame.size.height - 125);
		[self addChild:tree];
		
		// PR
		SKSpriteNode *prImage = [SKSpriteNode spriteNodeWithImageNamed:@"prbar"];
//		prImage.anchorPoint = CGPointMake(0, 0);
		prImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-46);
		prImage.name = @"prBar";
		prImage.zPosition = 1.0;
		[self addChild:prImage];
		
		_prKnob = [SKSpriteNode spriteNodeWithImageNamed:@"prKnob"];
		_prKnob.anchorPoint = CGPointMake(0, 0);
		_prKnob.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-56);
		_prKnob.name = @"prKnob";
		_prKnob.zPosition = 1.0;
		[self addChild:_prKnob];
		
		_prPoints = 150;
		
		
		self.animals = [NSMutableArray array];
		self.people = [NSMutableArray array];
		
//		[self setAnimalType:ZKAnimalTypeZebra count:3];
		
		self.happiness = 0.1;
		
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



- (void)newAnimalType:(ZKAnimalType)animalType count:(NSInteger)count animalIds:(NSArray *)animalIds {
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
	
	ZKAnimal *animal1 = [[ZKAnimal alloc] initWithPosition:[self randomAnimalPoint] atlas:[SKTextureAtlas atlasNamed:animalName]];
	animal1.name = @"animal";
	animal1.animalId = [animalIds[count] integerValue];
	[self.animals addObject:animal1];
	[self addChild:animal1];
	
	if (_isShowingEvent) {
		[animal1 performEvent];
	}
}


- (void)setAnimalType:(ZKAnimalType)animalType count:(NSInteger)count animalIds:(NSArray *)animalIds
{
	for (int i = 0; i < count; i++) {
		[self newAnimalType:animalType count:i animalIds:animalIds];
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
	
	if (_prPoints <= 300) {
		_prKnob.position = CGPointMake(_prPoints, CGRectGetMidY(self.frame)-56);
	}
}

- (CGPoint)randomVisitorPoint {
	return CGPointMake(rand() % 320, self.frame.size.height - 320 + rand() % (13 * 4));
}

- (CGPoint)randomAnimalPoint {
	CGPoint point = CGPointMake(rand() % (320 - 100) + 50, self.frame.size.height - (rand() % (320 - 120) + 50));
	
	if (point.x < 100 && point.y > self.frame.size.height - 100) point = [self randomAnimalPoint];
	return point;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    NSArray *nodes = [self nodesAtPoint:location];
	
	for (SKNode *node in nodes) {
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
			[self killAnimal:animal atLocation:location];
		}
	}
}


- (void)killAnimal:(ZKAnimal *)animal atLocation:(CGPoint)location {
	if (animal.health > 0) {
		animal.health -= 25;
	} else {
		animal.dead = YES;
		[_viewController makeKill:animal.animalId];
	}
	
	NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"Spark" ofType:@"sks"];
	SKEmitterNode *bloodEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
	bloodEmitter.zPosition = self.fgImage.zPosition - 100;
	bloodEmitter.particlePosition = location;
	
	[self addChild:bloodEmitter];
	
	[self runAction:[SKAction waitForDuration:0.1] completion:^{
		bloodEmitter.particleBirthRate = 0;
		[self runAction:[SKAction waitForDuration:.5] completion:^{
			[bloodEmitter removeFromParent];
		}];
	}];

}

- (SKSpriteNode *)showButtonNode {
    SKSpriteNode *showNode = [SKSpriteNode spriteNodeWithImageNamed:@"show"];
    showNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-150);
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
		
		self.confetti = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"confetti1"]];
		[self.confetti runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[ [SKTexture textureWithImageNamed:@"confetti1"], [SKTexture textureWithImageNamed:@"confetti2"] ] timePerFrame:0.5]]];
		self.confetti.anchorPoint = CGPointMake(0, 0);
		self.confetti.position = CGPointMake(0, self.frame.size.height - 320);
		[self addChild:self.confetti];
		self.confetti.zPosition = 10000;
	};
	
	__block int finishes = 0;
	
	int i;
	for (i = 0; i < self.animals.count; i++) {
		NSUInteger count = self.animals.count;
		
		for (ZKAnimal *animal in self.animals) {
			if (animal.dead) count--;
		}
		
		ZKAnimal *animal = self.animals[i];
		[animal walkTo:CGPointMake(distance * (i + 1), self.frame.size.height - 150) withCompletion:^{
			finishes++;
			
			if (finishes == count) {
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
	
	[self.confetti removeFromParent];
	self.confetti = nil;
}

- (void)animalSick:(NSInteger)animalId
{
	for (ZKAnimal *animal in _animals) {
		if (animalId == animal.animalId) {
			animal.sick = YES;
		}
	}
}

- (void)animalDead:(NSInteger)animalId
{
	for (ZKAnimal *animal in _animals) {
		if (animalId == animal.animalId) {
			animal.dead = YES;
		}
	}
}


#pragma mark - ZKAnimalDelegate

- (void)animalWasRemoved:(ZKAnimal *)animal {
	[self.animals removeObject:animal];
}

@end
