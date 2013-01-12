//
//  Player.m
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

- (id)init{
	if((self=[super init])){
		self = [CCSprite spriteWithFile:@"playerPlane.png"];
		}
	return self;
}

-(void)leftButtonPressed{
}

@end
