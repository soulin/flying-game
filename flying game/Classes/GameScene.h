//
//  HelloWorldLayer.h
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Player.h"
#import "HUDbutton.h"

// HelloWorld Layer
@interface GameScene : CCLayer
{
	CCLayer * HUDLayer;
	CCLayer * gameLayer;
	
	int currentBackground;
	CCSprite * background;
	CCSprite * background2;
	
	Player * player;
	HUDbutton * left;
	HUDbutton * right;
	HUDbutton * thruster;
	
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

- (void)tileBackground;
- (void)gameLoop:(ccTime)delta;
- (void)scroll;
@end
