//
//  ZKMenuScene.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKMenuScene.h"
#import "ZKPerson.h"


@interface ZKMenuScene ()

@property (strong) SKEmitterNode *spark;
@property (assign) NSInteger sparkTime;

@property (strong, nonatomic) NSMutableArray *people;

@end

@implementation ZKMenuScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
		SKSpriteNode *fgImage = [SKSpriteNode spriteNodeWithImageNamed:@"grid"];
        fgImage.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
		[self addChild:fgImage];
		
		
		self.people = [NSMutableArray array];
		
		
		NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"Spark" ofType:@"sks"];
		_spark = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
    }
	
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	
	
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


- (void)setPeopleCount:(NSUInteger)peopleCount {
	while (peopleCount > self.people.count) {
		ZKPerson *person = [[ZKPerson alloc] initWithPosition:CGPointMake(120, 50)];
		[self addChild:person];
		[self.people addObject:person];
		[self movePerson:person];
	}
	
//	while (peopleCount < self.people.count) {
//		ZKPerson *person = self.people.firstObject;
//		[self.people removeObjectAtIndex:0];
//		
//		[person walkTo:CGPointMake(person.position.x, 0)];
//		person.removeOnStop = YES;
//	}
}

- (void)movePerson:(ZKPerson *)person {
	if (![person isWalking]) {
		switch ([_people count]) {
			case 0:
				break;
			case 1:
				[person walkTo:CGPointMake(120, 50)];
				break;
			case 2:
				[person walkTo:CGPointMake(150, 50)];
				break;
			case 3:
				[person walkTo:CGPointMake(180, 50)];
				break;
			default:
				break;
		}
	}
}

@end
