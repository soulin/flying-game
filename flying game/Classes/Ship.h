//
//  ship.h
//  flying game
//
//  Created by Matthew Caswell on 2/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Ship : CCSprite {
	int team;
	double health;
}

@property(readwrite)int team;
@property(readwrite)double health;

- (void)hitWithDamage:(double)damage;
- (void)die;
@end
