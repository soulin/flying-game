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
#define GRAVITY_WITHOUT_THRUSTERS 0 // -.2

#define	DAMAGE 1
#define BULLETSPEED 22
#define RELOADTIME 0

#define MAXHEALTH 5

#define MAXHEIGHT  1500/2
@implementation Player

- (id)init {
	if ((self = [super init])) {
		[self setTeam:0];
		[self setHealth:MAXHEALTH];
		[self schedule:@selector(update:) interval:1/60.0f];
	}
	return self;
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
	
	//bounce off ceiling and floor
	if (self.position.y > MAXHEIGHT) {
		Vy = -abs(Vy);
	}
	if (self.position.y < -MAXHEIGHT) {
		Vy = abs(Vy);
	}
	
	//listen to reloading stuff
	reloadingTime -= delta;
	if (reloadingTime <=0) {
		canShoot = TRUE;
	} else {
		canShoot = FALSE;
	}

	if (canShoot && shooting) {
		[self shoot];
	}
	
	[self setPosition:CGPointMake(self.position.x+Vx, self.position.y+Vy)];
	
}

- (void)shoot {
	reloadingTime = RELOADTIME;
	
	Bullet * bullet = [Bullet newBulletWithVelocity:BULLETSPEED andDirection:-self.rotation + 180];
	[bullet setPosition:CGPointMake(self.position.x, self.position.y)];
	[bullet setTeam:0];
	[bullet setDamage:DAMAGE];
	[self.parent addChild: bullet];
}

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

- (void)thrusterPressed {
	shooting = TRUE;
	if(!dead)
		thrustersOn = TRUE;
}

- (void)thrusterReleased {
	thrustersOn = FALSE;
	shooting = FALSE;
}

- (double)addForceWithMagnitude:(double)mag andAngle:(double)angle isX:(BOOL)x {
	//convert angle to radians
	angle = angle * (M_PI/180.0f);
	
	if(x)
		return mag * cos(angle);	
	
	return mag * sin(angle);
}

@end
