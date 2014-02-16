//
//  ZKAnimal.h
//  NGJ14
//
//  Created by Ulrik Damm on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKEntity.h"

@interface ZKAnimal : ZKEntity

@property (assign) NSInteger health;


- (id)initWithPosition:(CGPoint)position atlas:(SKTextureAtlas *)atlas;

- (void)performEvent;
- (void)stopEvent;

@end
