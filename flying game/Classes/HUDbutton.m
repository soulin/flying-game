//
//  HUDbutton.m
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HUDbutton.h"


@implementation HUDbutton

@synthesize releaseMethod;

-(void)unselected {
	[super unselected];
	[releaseMethod invoke];
}

@end
