//
//  ZKSprite.h
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ZKSprite : SKSpriteNode

@property (strong) NSArray *frames;


- (id)initWithSpriteSheetNamed:(NSString *)spriteSheet
					sourceRect:(CGRect)source
			andNumberOfSprites:(int)numberOfSprites;

@end
