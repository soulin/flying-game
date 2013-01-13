//
//  HUDbutton.h
//  flying game
//
//  Created by Matthew Caswell on 1/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"

@interface HUDbutton : CCMenuItemImage {
	Player * player;
	NSString * direction;
}

@property(nonatomic,retain)Player * player;
@property(nonatomic,retain)NSString * direction;

@end
