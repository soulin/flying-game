//
//  EnemyFighter.h
//  flying game
//
//  Created by Matthew Caswell on 1/24/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EnemyFighter : CCSprite {
	double Vx, Vy;
	double speed;
	CCNode * target;
}
@property(nonatomic, retain)CCNode * target;

- (double)addForceWithMagnitude:(double)mag andAngle:(double)angle isX:(BOOL)x;
-(void)update:(ccTime)delta;
- (int)signOfInteger:(int)integer;
@end
