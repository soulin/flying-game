//
//  HUDbutton.m
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HUDbutton.h"


@implementation HUDbutton

@synthesize player;
@synthesize direction;

-(void)selected{
	[super selected];
	if (direction == @"left") {
		[player leftButtonPressed];
	} else {
		[player rightButtonPressed];
	}

}

-(void)unselected {
	[super unselected];
	[player directionButtonReleased];
}

@end
