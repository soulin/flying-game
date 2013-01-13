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

#define PLAYER_MAX_SPEED  30
#define PLAYER_ACCELERATION 15
#define PLAYER_DRAG -5

#define GRAVITY -5

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
	
	if (thrustersOn) {
		Vx += PLAYER_ACCELERATION*cosf(self.rotation);
		Vy += PLAYER_ACCELERATION*sinf(self.rotation);
		if (Vx*Vx + Vy*Vy > 30) {
			Vx = 30*cosf(self.rotation);
			Vy = 30*sinf(self.rotation);
		}
		[self setPosition:CGPointMake(self.position.x+Vx, self.position.y+Vy)];
	} else {
		Vy += GRAVITY;
		
		Vx += PLAYER_DRAG*cosf(self.rotation);
		Vy += PLAYER_DRAG*cosf(self.rotation);
	}

}

- (void)thrusterPressed {
	if(!dead)
	thrustersOn = TRUE;
}

- (void)thrusterReleased {
	thrustersOn = FALSE;
}

@end
