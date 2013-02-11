//
//  Bullet.h
//  flying game
//
//  Created by Matthew Caswell on 2/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Ship.h"

@interface Bullet : CCSprite {
	double Vx, Vy;
	int team;
	double damage;
	bool boom;
}
@property(readwrite)double Vx;
@property(readwrite)double Vy;
@property(readwrite)double damage;
@property(readwrite)int team;
+ (Bullet*)newBulletWithVelocity:(double)velocity andDirection:(double)direction;

- (void)update;
@end
