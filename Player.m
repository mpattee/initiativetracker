//
//  Player.m
//  InitiativeTracker
//
//  Created by Mike Pattee on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

- (id)init
{
	if (![super init])
		return nil;
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@, %d, %d", [self name], [self initiativeModifier], [self initiative]];
}

@synthesize color;
@synthesize name;
@synthesize initiativeModifier;
@synthesize initiative;
@synthesize startOfRoundEffect;
@synthesize endOfRoundEffect;
@synthesize roundCompleted;



@end
