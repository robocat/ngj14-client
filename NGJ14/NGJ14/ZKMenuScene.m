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
		
    }
	
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	UITouch *touch = [touches anyObject];
}

- (void)update:(CFTimeInterval)currentTime {

}


- (void)setPeopleCount:(NSUInteger)peopleCount {
	while (peopleCount > self.people.count) {
		ZKPerson *person = [[ZKPerson alloc] initWithPosition:CGPointMake(160, -50)];
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
				[person walkTo:CGPointMake(120, 100)];
				break;
			case 2:
				[person walkTo:CGPointMake(150, 100)];
				break;
			case 3:
				[person walkTo:CGPointMake(180, 100)];
				break;
			default:
				break;
		}
	}
}

@end
