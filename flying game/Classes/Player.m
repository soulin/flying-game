//
//  Player.m
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

#define PLAYER_ROTATION_SPEED 15

@implementation Player

-(void)leftButtonPressed{
	playerRotation = -PLAYER_ROTATION_SPEED;
}

-(void)rightButtonPressed{
	playerRotation = PLAYER_ROTATION_SPEED;
}

-(void)directionButtonReleased{
	playerRotation = 0;
}

-(void)update:(NSTimeInterval)delta {
	
}

@end
