//
//  Bullet.m
//  flying game
//
//  Created by Matthew Caswell on 2/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"


@implementation Bullet

@synthesize Vx;
@synthesize Vy;
@synthesize team;
@synthesize damage;


+ (Bullet*)newBulletWithVelocity:(double)velocity andDirection:(double)direction {
	Bullet * bullet = [Bullet spriteWithFile:@"BulletRed.png"];
	
	direction = direction * M_PI/180;
	
	[bullet setVx:velocity*cos(direction)];
	[bullet setVy:velocity*sin(direction)];
	
	[bullet schedule:@selector(update) interval:1/60.0f];
	
	
	return bullet;
}

- (id)init {
	if ((self = [super init])){
		boom = FALSE;
	}
	return self;
}

- (void)update {
	[self setPosition:CGPointMake(self.position.x + Vx, self.position.y + Vy)];
	
	for(CCNode * node in [[self parent] children]) {
		if (node.tag == 5) {
			if ([(Ship*)node team] != self.team) {
				if (CGRectIntersectsRect([node boundingBox], [self boundingBox])) {
					if (boom == FALSE){
						boom = TRUE;
						[(Ship*)node hitWithDamage:damage];
						[self removeFromParentAndCleanup:TRUE];
					}
				}
			}
		}
	}
}

@end
