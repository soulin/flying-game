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

#define PLAYER_MAX_SPEED  15
#define PLAYER_ACCELERATION .5
#define PLAYER_DRAG  .99

#define GRAVITY_WITH_THRUSTERS -.03
#define GRAVITY_WITHOUT_THRUSTERS -.2
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
	
	//add engine pushy stuff
	if (thrustersOn) {
		Vx += [self addForceWithMagnitude:-PLAYER_ACCELERATION andAngle:-self.rotation isX:TRUE];
		Vy += [self addForceWithMagnitude:-PLAYER_ACCELERATION andAngle:-self.rotation isX:FALSE];
		Vy += GRAVITY_WITH_THRUSTERS;
	} else {
		Vy += GRAVITY_WITHOUT_THRUSTERS;
	}

	//drag + gravity = LAME
	Vx = Vx * PLAYER_DRAG;
	Vy = Vy * PLAYER_DRAG;
	
	
	//CONFORM to the max speed(adversity)
	if (Vx > PLAYER_MAX_SPEED) {
		Vx = PLAYER_MAX_SPEED;
	} else if (Vx < -PLAYER_MAX_SPEED) {
		Vx = -PLAYER_MAX_SPEED;
	}
	if (Vy > PLAYER_MAX_SPEED) {
		Vy = PLAYER_MAX_SPEED;
	} else if (Vy < -PLAYER_MAX_SPEED) {
		Vy = -PLAYER_MAX_SPEED;
	}
	
	[self setPosition:CGPointMake(self.position.x+Vx, self.position.y+Vy)];

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
