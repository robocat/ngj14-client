//
//  ZKMyScene.m
//  NGJ14
//
//  Created by Willi Wu on 15/02/14.
//  Copyright (c) 2014 Willi Wu. All rights reserved.
//

#import "ZKMyScene.h"

#import "ZKSprite.h"
#import "ZKPerson.h"
#import "ZKGameController.h"


@interface ZKMyScene ()

@property (strong) ZKGameController *gameController;
@property (strong) ZKPerson *man1;

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
		_man1 = [[ZKPerson alloc] initPerson];
		_man1.position = CGPointMake(CGRectGetMidX(self.frame),
									 CGRectGetMidY(self.frame));
        [self addChild:_man1];
//		[self walkingGuy];
		
		
        
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
    
    [_man1 runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:_man1.walkLeftFrames
                                                                    timePerFrame:0.5f
                                                                          resize:NO
                                                                         restore:YES]] withKey:@"walkLeft"];
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
