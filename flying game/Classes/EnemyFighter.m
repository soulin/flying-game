//
//  EnemyFighter.m
//  flying game
//
//  Created by Matthew Caswell on 1/24/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "EnemyFighter.h"

#define GRAVITY -.5
#define SPEED 14.5
#define MINSPEED  1
#define TURNSPEED 3

#define RATIO .05

@implementation EnemyFighter
@synthesize target;

- (void)update:(ccTime)delta{
	//aim at thine enemy
	double angleToTargetInRadians = -atan2((self.position.y-target.position.y),(self.position.x-target.position.x));   // arctan(opposite(y)/adjecent(x)) = THETAAAA THE ALL MIIGHTY
	
	double angleToTargetInDegrees = angleToTargetInRadians * (180.0f/M_PI) - 180;
	
	double selfRotation = self.rotation;
	
	double rotationToHappen = self.rotation;
	
	double difference = angleToTargetInDegrees - selfRotation;
	
	if(difference >= 180 && selfRotation <180)
		rotationToHappen += 360;
	else if(difference <= -180)
		rotationToHappen -= 360;
	else {
		if (difference != 0) {
			difference = angleToTargetInDegrees - selfRotation;
		}
		if (abs(difference) < TURNSPEED) {
			rotationToHappen += difference;
		} else {
			rotationToHappen += TURNSPEED*[self signOfInteger:difference];
		}

	}
	
	//make sure it slows down when it gets too close
	double distance = sqrt((self.position.x-target.position.x)*(self.position.x-target.position.x) + (self.position.y-target.position.y)*(self.position.y-target.position.y));
	
	speed = MAX(distance*RATIO, MINSPEED);
	speed = MIN(speed, SPEED);
	
	//make the thing move and rotate and erything
	[self setRotation:rotationToHappen];
	
	Vx = [self addForceWithMagnitude:speed andAngle:-self.rotation isX:TRUE];
	Vy = [self addForceWithMagnitude:speed andAngle:-self.rotation isX:FALSE];
	
	Vy += GRAVITY;
	
	[self setPosition:CGPointMake(self.position.x+Vx, self.position.y+Vy)];
	
}

- (int)signOfInteger:(int)integer {
    if (integer != 0) {
        integer = (integer < 0) ? -1 : +1;
    }
    return integer;
}

- (double)addForceWithMagnitude:(double)mag andAngle:(double)angle isX:(BOOL)x {
	//convert angle to radians
	angle = angle * (M_PI/180.0f);
	
	if(x)
		return mag * cos(angle);	
	
	return mag * sin(angle);
}
@end
