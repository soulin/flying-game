//
//  Player.h
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCSprite {
	float playerRotation;
	bool thrustersOn,dead;
	double Vx,Vy;
}

-(void)leftButtonPressed;
-(void)rightButtonPressed;
-(void)directionButtonReleased;

-(void)thrusterPressed;
-(void)thrusterReleased;

-(void)update:(ccTime)delta;

@end
