//
//  Player.m
//  InitiativeTracker
//
//  Created by Mike Pattee on 1/27/09.
//  Copyright 2009 Cordax Software, LLC. All rights reserved.
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
	return [NSString stringWithFormat:@"Name: %@\nInitiative Modifier: %d\nInitiative: %d\nCurrent HP: %d\nMax HP: %d", [self name], [self initiativeModifier], [self initiative], [self currentHp], [self maxHp]];
}

- (void)takeDamage:(NSInteger)damage
{
	currentHp -= damage;
	if (currentHp < (maxHp / 2))
	{
		bloodied = YES;
	}
	else
	{
		bloodied = NO;
	}
}

@synthesize color;
@synthesize name;
@synthesize initiativeModifier;
@synthesize initiative;
@synthesize maxHp;
@synthesize currentHp;
@synthesize bloodied;
@synthesize startOfRoundEffect;
@synthesize endOfRoundEffect;
@synthesize roundCompleted;



@end
