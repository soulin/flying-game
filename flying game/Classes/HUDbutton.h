//
//  HUDbutton.h
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HUDbutton : CCMenuItemImage {
	NSInvocation * releaseMethod;
}

@property(nonatomic,retain)NSInvocation * releaseMethod;

@end
