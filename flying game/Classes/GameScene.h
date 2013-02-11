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
#import "EnemyFighter.h"
#import "Bullet.h"

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
	
	NSMutableArray * enemies;
	NSMutableArray * bullets;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

- (void)addPlayer;
- (void)buildHUD;
- (void)setupBackground;
- (void)tileBackground;
- (void)gameLoop:(ccTime)delta;
- (void)scroll;
- (void)addEnemyFighterWithPosition:(CGPoint)pos;
@end
