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
	} else if (direction == @"right") {
		[player rightButtonPressed];
	} else if (direction == @"thruster") {
		[player thrusterPressed];
	}
	
}

-(void)unselected {
	[super unselected];
	if (direction == @"right" || direction == @"left")
		[player directionButtonReleased];
	else
		[player thrusterReleased];
}

@end
