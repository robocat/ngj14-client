//
//  ZKSprite.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKSprite.h"

@implementation ZKSprite

- (id) initWithSpriteSheetNamed:(NSString *)spriteSheet
					 sourceRect:(CGRect)source
			 andNumberOfSprites:(int)numberOfSprites {
	
    NSMutableArray *animatingFrames = [NSMutableArray array];
	
    SKTexture  *texture = [SKTexture textureWithImageNamed:spriteSheet];
	
    texture.filteringMode = SKTextureFilteringNearest;
	
    float x = source.origin.x;
    float y = source.origin.y;
    float w = source.size.width;
    float h = source.size.height;
	
    for (int i = 0; i < numberOfSprites; i++) {
        CGRect cutter = CGRectMake(x, y/texture.size.width, w/texture.size.width, h/texture.size.height);
        SKTexture *temp = [SKTexture textureWithRect:cutter inTexture:texture];
        [animatingFrames addObject:temp];
        x += w/texture.size.width;
//		y += h/texture.size.height;
    }
	
    self = [ZKSprite spriteNodeWithTexture:animatingFrames[0]];
	
    _frames = [NSArray arrayWithArray:animatingFrames];
	
    return self;
}

@end
