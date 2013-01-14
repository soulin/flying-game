//
//  Player.m
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

#define PLAYER_ROTATION_SPEED 120
#define FALLING_PLAYER_ROTATION_SPEED 270

#define PLAYER_MAX_SPEED  5
#define PLAYER_ACCELERATION .5
#define PLAYER_DRAG  .995

#define GRAVITY 0

@implementation Player

- (void)leftButtonPressed{
	if(thrustersOn)
		playerRotation = -PLAYER_ROTATION_SPEED;
	else 
		playerRotation = -FALLING_PLAYER_ROTATION_SPEED;
}

- (void)rightButtonPressed{
	if(thrustersOn)
		playerRotation = PLAYER_ROTATION_SPEED;
	else 
		playerRotation = FALLING_PLAYER_ROTATION_SPEED;
}

- (void)directionButtonReleased{
	playerRotation = 0;
}

- (void)update:(ccTime)delta {
	[self setRotation:self.rotation+playerRotation*delta];
//	[self setRotation:self.rotation+FALLING_PLAYER_ROTATION_SPEED*delta];
	
	if (thrustersOn) {
		Vx += [self addForceWithMagnitude:-PLAYER_ACCELERATION andAngle:-self.rotation isX:TRUE];
		Vy += [self addForceWithMagnitude:-PLAYER_ACCELERATION andAngle:-self.rotation isX:FALSE];
		
				
	}
	Vx = Vx * PLAYER_DRAG;
	Vy = Vy * PLAYER_DRAG;
	Vy += GRAVITY;
	[self setPosition:CGPointMake(self.position.x+(int)Vx, self.position.y+(int)Vy)];

}

- (double)addForceWithMagnitude:(double)mag andAngle:(double)angle isX:(BOOL)x {
	//convert angle to radians
	angle = angle * (M_PI/180.0f);
	
	if(x)
	return mag * cos(angle);	
	
	return mag * sin(angle);
}

- (void)thrusterPressed {
	if(!dead)
	thrustersOn = TRUE;
}

- (void)thrusterReleased {
	thrustersOn = FALSE;
}

@end
