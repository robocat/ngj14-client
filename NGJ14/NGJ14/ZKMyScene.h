//
//  ZKMyScene.h
//  NGJ14
//

//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ZKViewController.h"

@interface ZKMyScene : SKScene

/*!
 * How happy people are. 0 = neutral, 1 = very happy, -1 = very unhappy
 */
@property (assign, nonatomic) CGFloat happiness;

/*!
 * How many people are visiting the cage. Changing will make them walk in/out.
 */
@property (assign, nonatomic) NSUInteger peopleCount;

@property (assign) NSInteger prPoints;

//@property (assign) ZKAnimalType animalType;

@property (weak) ZKViewController *viewController;

@property (assign) BOOL isShowingEvent;


- (void)newAnimalType:(ZKAnimalType)animalType count:(NSInteger)count animalIds:(NSArray *)animalIds;

- (void)setAnimalType:(ZKAnimalType)animalType count:(NSInteger)count animalIds:(NSArray *)animalIds;

- (void)doEvent;

- (void)animalSick:(NSInteger)animalId;
- (void)animalDead:(NSInteger)animalId;

@end
