//
//  ZKMyScene.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKMyScene.h"

#import "ZKSprite.h"
#import "ZKGameController.h"


@interface ZKMyScene ()

@property (strong) ZKGameController *gameController;
@property (strong) ZKSprite *guy;

@end



@implementation ZKMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor blackColor];
		
		// Background
		SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
        bgImage.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
		[self addChild:bgImage];
		
		// Foreground
		SKSpriteNode *fgImage = [SKSpriteNode spriteNodeWithImageNamed:@"fg"];
        fgImage.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
		[self addChild:fgImage];
		
		
		// guy
		_guy = [[ZKSprite alloc] initWithSpriteSheetNamed:@"person"
														sourceRect:CGRectMake(0, 0, 28, 76)
												andNumberOfSprites:12];
		_guy.position = CGPointMake(CGRectGetMidX(self.frame),
								   CGRectGetMidY(self.frame));
		[self addChild:_guy];
		[self walkingGuy];
		
        
//        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//
//        myLabel.text = @"Hello, World!";
//        myLabel.fontSize = 30;
//        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//        
//        [self addChild:myLabel];
		
		_gameController = [ZKGameController new];
		[_gameController startGame];
    }
	
    return self;
}


-(void)walkingGuy
{
    //This is our general runAction method to make our bear walk.
    //By using a withKey if this gets called while already running it will remove the first action before
    //starting this again.
    
    [_guy runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:_guy.frames
                                                                    timePerFrame:0.5f
                                                                          resize:NO
                                                                         restore:YES]] withKey:@"walkingInPlaceBear"];
    return;
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    /* Called when a touch begins */
//    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
//}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
