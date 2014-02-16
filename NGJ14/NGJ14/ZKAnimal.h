//
//  ZKAnimal.h
//  NGJ14
//
//  Created by Ulrik Damm on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKEntity.h"

@class ZKAnimal;

@protocol ZKAnimalDelegate <NSObject>

- (void)animalWasRemoved:(ZKAnimal *)animal;

@end

@interface ZKAnimal : ZKEntity

@property (assign, nonatomic) id<ZKAnimalDelegate> delegate;
@property (assign, nonatomic) BOOL sick;
@property (assign, nonatomic) BOOL dead;
@property (assign) NSInteger health;
@property (assign) NSInteger animalId;

- (id)initWithPosition:(CGPoint)position atlas:(SKTextureAtlas *)atlas;

- (void)performEvent;
- (void)stopEvent;

@end
