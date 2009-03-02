//
//  HealthTrackerController.m
//  InitiativeTracker
//
//  Created by Mike Pattee on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HealthTrackerController.h"
#import "InitiativeTrackerController.h"
#import "Player.h"

@implementation HealthTrackerController

@synthesize count;
@synthesize hp;
@synthesize table;
@synthesize initiativeTable;
@synthesize initiativeController;

- (void) dealloc
{
	[count release];
	[hp release];
	[table release];
	[initiativeTable release];
	[players release];
	[dealDamagePanel release];
	[super dealloc];
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		players = [[NSMutableArray alloc] init];
	}
	return self;
}

- (IBAction)addPlayer:(id)sender
{
	NSInteger numberToAdd = [count integerValue];
	NSInteger numberOfHp = [hp integerValue];
	if (!numberToAdd)
	{
		numberToAdd = 1;
	}
	for (int i = 0; i < numberToAdd; i++) {
		
	Player * tempPlayer = (Player *)[[initiativeController players] objectAtIndex:[initiativeTable selectedRow]];
	Player * player = [[Player alloc] init];
	player.name = tempPlayer.name;
	player.currentHp = player.maxHp = numberOfHp;
	player.bloodied = NO;
	[players addObject:player];
	[player release];
	}
	[table reloadData];
	
}
- (IBAction)dealDamage:(id)sender
{
	Player *player = [players objectAtIndex:[table selectedRow]];
	[player takeDamage:[damage integerValue]];
	[dealDamagePanel close];
}

- (IBAction)dealDamageOpen:(id)sender
{
	[dealDamagePanel makeKeyAndOrderFront:sender];
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [players count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	// What is the identifier for the column?
	NSString *identifier = [aTableColumn identifier];
	// What Player
	Player *player = [players objectAtIndex:rowIndex];
	
	// What is the value of the attribute named identifier?
	return [player valueForKey:identifier];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	NSString *identifier = [aTableColumn identifier];
	Player *player = [players objectAtIndex:rowIndex];
	
	// Set the value for the attribute named identifier
	[player setValue:anObject forKey:identifier];
	NSArray *sortDescriptors = [table sortDescriptors];
	[players sortUsingDescriptors:sortDescriptors];
	[table reloadData];
}




@end
