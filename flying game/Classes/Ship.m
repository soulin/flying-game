//
//  ship.m
//  flying game
//
//  Created by Matthew Caswell on 2/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Ship.h"


@implementation Ship
@synthesize team;
@synthesize health;

- (id)init {
	if((self = [super init])){
		[self setTag:5];
	}
	return self;
}

- (void)hitWithDamage:(double)damage {
	health -= damage;
	
	NSLog(@"%d", health);
	
	if (health<=0) {
		[self die];
	}
}

- (void)die {
	[self removeFromParentAndCleanup:TRUE];
}

@end
