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
	
    float sx = source.origin.x;
    float sy = source.origin.y;
    float sWidth = source.size.width;
    float sHeight = source.size.height;
	
    for (int i = 0; i < numberOfSprites; i++) {
        CGRect cutter = CGRectMake(sx, sy/texture.size.width, sWidth/texture.size.width, sHeight/texture.size.height);
        SKTexture *temp = [SKTexture textureWithRect:cutter inTexture:texture];
        [animatingFrames addObject:temp];
        sx += sWidth/texture.size.width;
    }
	
    self = [ZKSprite spriteNodeWithTexture:animatingFrames[0]];
	
    _frames = [NSArray arrayWithArray:animatingFrames];
		
    return self;
}

@end
