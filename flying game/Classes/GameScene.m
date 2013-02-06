//
//  HelloWorldLayer.m
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

// Import the interfaces
#import "GameScene.h"

#define SCROLL_BUFFER_X 30
#define SCROLL_BUFFER_Y 30


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
		
		//setup gamelayer (where all the planes and bullets and backgrounds go cuz it scrolls)
		gameLayer = [[CCLayer alloc] init];
		[self addChild:gameLayer z:0];
		
		//Initialize the array that will hold all the enemies
		enemies = [[NSMutableArray alloc] init];
		
		//add the background
		[self setupBackground];
		
		//add the player
		[self addPlayer];
		
		//make the HUD
		[self buildHUD];
		
		//#####################TESTING#####################
		EnemyFighter * baaaddDude = [EnemyFighter spriteWithFile:@"ship0001.png"];
		[baaaddDude setPosition:CGPointMake(200, 300)];
		[baaaddDude setTarget:player];
		[enemies addObject:baaaddDude];
		[gameLayer addChild:baaaddDude];
		
		//start the gameloop
		[self schedule:@selector(gameLoop:) interval:1/60.0f];
	}
	return self;
}

- (void)setupBackground {
	background = [CCSprite spriteWithFile:@"background.png"];
	background2 = [CCSprite spriteWithFile:@"background.png"];
	
	[gameLayer addChild:background z:-2];
	[gameLayer addChild:background2 z:-1];
	
	[background setPosition:CGPointMake([[CCDirector sharedDirector] winSize].width/2, 0)];
	[background2 setPosition:CGPointMake(background.position.x + background.contentSize.width-1, background.position.y+2)];
}

- (void)addPlayer {
	player = [Player spriteWithFile:@"playerPlane.png"];
	[gameLayer addChild:player];
	CGSize windowSize = [[CCDirector sharedDirector] winSize];
	[player setPosition:CGPointMake(windowSize.width/2, windowSize.height/2)];
}

- (void)buildHUD {
	HUDLayer = [[CCLayer alloc] init];
	
	left = [HUDbutton itemFromNormalImage:@"leftOn.png" selectedImage:@"left.png" target:player selector:@selector(leftButtonPressed)];
	right = [HUDbutton itemFromNormalImage:@"rightOn.png" selectedImage:@"right.png" target:player selector:@selector(rightButtonPressed)];
	thruster = [HUDbutton itemFromNormalImage:@"ThrustOn.png" selectedImage:@"Thrust.png" target:player selector:@selector(thrusterPressed)];
	
	[left setPlayer:player];
	[right setPlayer:player];
	[thruster setPlayer:player];
	[left setDirection:@"left"];
	[right setDirection:@"right"];
	[thruster setDirection:@"thruster"];
	[left setPosition:CGPointMake(30, 40)];
	[right setPosition:CGPointMake(94, 40)];
	[thruster setPosition:CGPointMake(415, 40)];
	
	CCMenu * directionalButtons = [CCMenu menuWithItems:left,right,thruster,nil];
	[directionalButtons setIsTouchUp:YES];
	[directionalButtons setPosition:CGPointMake(25, 0)];
	[HUDLayer addChild:directionalButtons z:1];
	
	[self addChild:HUDLayer z:1];
}

- (void)gameLoop:(ccTime)delta{
	[player update:delta];
	
	for(EnemyFighter * enemyFighter in enemies){
		[enemyFighter update:delta];
	}
	
	[self scroll];
	[self tileBackground];
}

-(void)tileBackground {
	// If background 1 is off of screen
	if (player.position.x - background.position.x < 0 - background.contentSize.width/2 || player.position.x - background.position.x > background.contentSize.width/2) {
		//replace background 2 with background 1
		[background setPosition:CGPointMake(background2.position.x,background2.position.y)];
		}
	// If player is on left side of background
	if (player.position.x < background.position.x - 32) {
		//move background 2 to the left side of background 1
		[background2 setPosition:CGPointMake(background.position.x - background.contentSize.width + 1, background.position.y)];
	}  else	if (player.position.x > background.position.x + 32) { //if player is on right side of background 1
		//move background 2 to the right side of background one
		[background2 setPosition:CGPointMake(background.position.x + background.contentSize.width - 1, background.position.y)];
	}

}

- (void)scroll {
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CGPoint playerPositionReletiveToScreen = CGPointMake(player.position.x + gameLayer.position.x, player.position.y + gameLayer.position.y);   
	
	if (playerPositionReletiveToScreen.y < screenSize.height/2 - SCROLL_BUFFER_Y) {
		[gameLayer setPosition:CGPointMake(gameLayer.position.x, gameLayer.position.y + ((screenSize.height/2 - SCROLL_BUFFER_Y) - playerPositionReletiveToScreen.y))];
	} else if (playerPositionReletiveToScreen.y > screenSize.height/2 + SCROLL_BUFFER_Y) {
		[gameLayer setPosition:CGPointMake(gameLayer.position.x, gameLayer.position.y + ((screenSize.height/2 + SCROLL_BUFFER_Y) - playerPositionReletiveToScreen.y))];
	}
	
	if (playerPositionReletiveToScreen.x < screenSize.width/2 - SCROLL_BUFFER_X) {
		[gameLayer setPosition:CGPointMake(gameLayer.position.x + ((screenSize.width/2 - SCROLL_BUFFER_X) - playerPositionReletiveToScreen.x), gameLayer.position.y)];
	} else if (playerPositionReletiveToScreen.x > screenSize.width/2 + SCROLL_BUFFER_X) {
		[gameLayer setPosition:CGPointMake(gameLayer.position.x + ((screenSize.width/2 + SCROLL_BUFFER_X) - playerPositionReletiveToScreen.x), gameLayer.position.y)];
	}
}

- (void)addEnemyFighterWithPosition:(CGPoint)pos {
	EnemyFighter * enemy = [CCSprite spriteWithFile:@"Ship0001.png"];
	[gameLayer addChild:enemy];
	[enemy setPosition:pos];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[gameLayer release];
	[HUDLayer release];
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
