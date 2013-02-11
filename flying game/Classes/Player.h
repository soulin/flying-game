//
//  Player.h
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Bullet.h"
#import "Ship.h"

@interface Player : Ship {
	float playerRotation;
	bool thrustersOn,dead;
	double Vx,Vy;
	
	bool canShoot, shooting;
	double reloadingTime;
}

-(void)leftButtonPressed;
-(void)rightButtonPressed;
-(void)directionButtonReleased;

-(void)thrusterPressed;
-(void)thrusterReleased;

-(void)update:(ccTime)delta;

- (double)addForceWithMagnitude:(double)mag andAngle:(double)angle isX:(BOOL)x;

- (void)shoot;
@end
