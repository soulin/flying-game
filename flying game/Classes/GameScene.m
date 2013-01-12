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
		
		Player * thePlayer = [[Player alloc]init];
		
		[thePlayer leftButtonPressed];
		[self addChild:thePlayer];
		CGSize windowSize = [[CCDirector sharedDirector] winSize];
		[thePlayer setPosition:CGPointMake(windowSize.width/2, windowSize.height/2)];
		
//		CCMenuItemImage *left = [CCMenuItemImage itemFromNormalImage:@"left.png" selectedImage:@"leftOn.png" target:player selector:@selector(leftButton)];
//		CCMenuItemImage *right = [CCMenuItemImage itemFromNormalImage:@"right.png" selectedImage:@"rightOn.png" target:player selector:@selector(rightButton)];
//		
//		[self addChild:left];
//		[self addChild:right];
//		
//		[left setPosition:CGPointMake(30, 40)];
//		[right setPosition:CGPointMake(60, 40)];
	}
	return self;
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
