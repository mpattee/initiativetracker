//
//  InitiativeTrackerController.m
//  InitiativeTracker
//
//  Created by Mike Pattee on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "InitiativeTrackerController.h"
#import "Player.h"
#import "stdlib.h"

@implementation InitiativeTrackerController

- (id) init
{
	if (![super init])
		return nil;
	srandom(time(NULL));
	players = [[NSMutableArray alloc] init];
	return self;

}

- (void)dealloc
{
	[players release];
	[super dealloc];
}

- (void)awakeFromNib
{
	[self initSorting];
}


- (void)initSorting
{
	NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"initiative" ascending:NO selector:@selector(compare:)];
	NSSortDescriptor *descriptor2 = [[NSSortDescriptor alloc] initWithKey:@"initiativeModifier" ascending:NO selector:@selector(compare:)];
	NSArray * sortDescriptors = [[NSArray alloc] initWithObjects:descriptor, descriptor2, nil];
	[tableView setSortDescriptors:sortDescriptors];
	[descriptor release];
	[descriptor2 release];
	[sortDescriptors release];
}

- (IBAction)addInitiative:(id)sender;
{
	Player *player = [[Player alloc] init];
	player.name = [nameField stringValue];
	player.initiativeModifier = [initiativeModifierField integerValue];
	player.initiative = [rollField integerValue];
	if (player.initiative == 0) {
		player.initiative = [self rollInitiative:player.initiativeModifier];
	}
	player.color = [initiativeColor color];
	[players addObject:player];
	[player release];

	NSArray * sortDescriptors = [tableView sortDescriptors];
	[players sortUsingDescriptors:sortDescriptors];	
	[tableView reloadData];
}

- (IBAction)removeInitiative:(id)sender;
{
	NSInteger selectedRow = [tableView selectedRow];
	if (selectedRow == -1)
		return;
	[players removeObjectAtIndex:selectedRow];
	[tableView reloadData];
}

- (IBAction)clearTable:(id)sender;
{
	[players release];
	players = [[NSMutableArray alloc] init];
	[tableView reloadData];
}

#pragma mark Table view datasource methods

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

	if ([identifier isEqualToString:@"color"]) {
		NSTextFieldCell * cell = [aTableColumn dataCell];
		[cell setBackgroundColor:player.color];
		return nil;
		
//		NSColorWell *colorWell = [[[NSColorWell alloc] init] autorelease];
//		[colorWell setColor:player.color];
//		return colorWell;
	}
		
	// What is the value of the attribute named identifier?
	return [player valueForKey:identifier];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	NSString *identifier = [aTableColumn identifier];
	Player *player = [players objectAtIndex:rowIndex];
	
	// Set the value for the attribute named identifier
	[player setValue:anObject forKey:identifier];
	NSArray *sortDescriptors = [tableView sortDescriptors];
	[players sortUsingDescriptors:sortDescriptors];
	[tableView reloadData];
}

- (void)tableView:(NSTableView *)aTableView sortDescriptorsDidChange:(NSArray *)oldDescriptors
{
	NSArray *newDescriptors = [aTableView sortDescriptors];
	[players sortUsingDescriptors:newDescriptors];
	[aTableView reloadData];
}



- (NSInteger)rollInitiative:(int)modifier;
{
	return random() % 20 + modifier + 1;
}
@end
