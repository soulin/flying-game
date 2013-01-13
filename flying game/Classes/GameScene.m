//
//  HelloWorldLayer.m
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

// Import the interfaces
#import "GameScene.h"


// HelloWorld implementation
@implementation GameScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		CCSprite * background = [CCSprite spriteWithFile:@"background.png"];
		[self addChild:background z:-1];
		
		player = [Player spriteWithFile:@"playerPlane.png"];
		[self addChild:player z:0];
		CGSize windowSize = [[CCDirector sharedDirector] winSize];
		[player setPosition:CGPointMake(windowSize.width/2, windowSize.height/2)];
		
		left = [HUDbutton itemFromNormalImage:@"leftOn.png" selectedImage:@"left.png" target:player selector:@selector(leftButtonPressed)];
		right = [HUDbutton itemFromNormalImage:@"rightOn.png" selectedImage:@"right.png" target:player selector:@selector(rightButtonPressed)];
		thruster = [HUDbutton itemFromNormalImage:@"Thrust.png" selectedImage:@"Thrust.png" target:player selector:@selector(thrusterPressed)];
		
		[left setPlayer:player];
		[right setPlayer:player];
		[thruster setPlayer:player];
		[left setDirection:@"left"];
		[right setDirection:@"right"];
		[thruster setDirection:@"thruster"];
		[left setPosition:CGPointMake(30, 40)];
		[right setPosition:CGPointMake(94, 40)];
		[thruster setPosition:CGPointMake(415, 40)];
		
		menu = [CCMenu menuWithItems:left,right,thruster,nil];
		[menu setIsTouchUp:YES];
		[menu setPosition:CGPointMake(25, 0)];
		[self addChild:menu z:1];
		
		[self schedule:@selector(gameLoop:) interval:1/60.0f];
	}
	return self;
}

- (void)gameLoop:(ccTime)delta{
	[player update:delta];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
