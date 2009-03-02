//
//  InitiativeTrackerController.m
//  InitiativeTracker
//
//  Created by Mike Pattee on 1/27/09.
//  Copyright 2009 Cordax Software, LLC. All rights reserved.
//

#import "InitiativeTrackerController.h"
#import "Player.h"
#import "stdlib.h"

@implementation InitiativeTrackerController

@synthesize combatRound;
@synthesize players;

- (id) init
{
	if (![super init])
		return nil;
	srandom(time(NULL));
	players = [[NSMutableArray alloc] init];
	combatRound = 0;
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
	[roundLabel setStringValue:[NSString stringWithFormat:@"Round: %d", [self combatRound]]];
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

- (IBAction)newCombat:(id)sender;
{
	[players release];
	players = [[NSMutableArray alloc] init];
	self.combatRound = 0;
	[roundLabel setStringValue:[NSString stringWithFormat:@"Round: %d", [self combatRound]]];
	[nextRoundButton setEnabled:YES];
	[nextRoundButton setTitle:@"Start Combat"];
//	NSLog(@"hmmm:%@asdf", [addInitiativeButton keyEquivalent]);
//	[dealDamageButton setKeyEquivalent:nil];
//	[addInitiativeButton setKeyEquivalent:@"\r"];
	[tableView reloadData];
}

- (IBAction)nextRound:(id)sender
{	
	[nextRoundButton setEnabled:NO];
	self.combatRound++;
	if (combatRound == 1) {
//		[addInitiativeButton setKeyEquivalent:nil];
//		[dealDamageButton setKeyEquivalent:@"\r"];
		[nextRoundButton setTitle:@"Next Round"];
	}
	[roundLabel setStringValue:[NSString stringWithFormat:@"Round: %d", [self combatRound]]];
	NSEnumerator *playerEnumerator = [players objectEnumerator];
	Player *player;
	while (player = [playerEnumerator nextObject]) {
		player.roundCompleted = NO;
	}
	[tableView reloadData];
	[tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
	player = [players objectAtIndex:0];
	if (player.startOfRoundEffect) {
		NSAlert * sorAlert = [NSAlert alertWithMessageText:[NSString stringWithFormat:@"%@ has a start of round action to complete", player.name] defaultButton:@"Keep Warning" alternateButton:@"Clear Warning" otherButton:nil informativeTextWithFormat:@"Would you like to keep the warning?"];
		NSInteger ret = [sorAlert runModal];
		if (ret == NSAlertAlternateReturn) {
			player.startOfRoundEffect = NO;
		}
	}
}

- (BOOL)isRoundCompleted:(NSArray *)somePlayers
{
	for (Player * player in somePlayers) {
		if (!player.roundCompleted) {
			return NO;
		}
	}
	return YES;
}

- (IBAction)nextPlayer:(id)sender
{
	NSInteger currentIndex = 0;
	for (Player * player in players) {
		[tableView selectRow:currentIndex byExtendingSelection:NO];
		if (player.roundCompleted)
		{
			currentIndex++;
		}
	}
	Player * player = [players objectAtIndex:currentIndex];
	if (player.endOfRoundEffect) {
		NSAlert * eorAlert = [NSAlert alertWithMessageText:[NSString stringWithFormat:@"%@ has an end of round action to complete", player.name] defaultButton:@"Keep Warning" alternateButton:@"Clear Warning" otherButton:nil informativeTextWithFormat:@"Would you like to keep the warning?"];
		NSInteger ret = [eorAlert runModal];
		if (ret == NSAlertAlternateReturn) {
			player.endOfRoundEffect = NO;
		}
	}
	player.roundCompleted = YES;
	[tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:currentIndex + 1] byExtendingSelection:NO];
	[tableView reloadData];
	player = [players objectAtIndex:[tableView selectedRow]];
	if (player.startOfRoundEffect) {
		NSAlert * sorAlert = [NSAlert alertWithMessageText:[NSString stringWithFormat:@"%@ has a start of round action to complete", player.name] defaultButton:@"Keep Warning" alternateButton:@"Clear Warning" otherButton:nil informativeTextWithFormat:@"Would you like to keep the warning?"];
		NSInteger ret = [sorAlert runModal];
		if (ret == NSAlertAlternateReturn) {
			player.startOfRoundEffect = NO;
		}
	}
	if ([self isRoundCompleted:players]) {
		[nextRoundButton setEnabled:YES];
	}
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


/*
- (NSIndexSet *)tableView:(NSTableView *)aTableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes
{
	if ([aTableView clickedRow] == -1) {
		//fixes bug where this delegate is called twice and the second time the clickedRow, clickedColumn are set to -1 even though its the same NSTableView
		return [aTableView selectedRowIndexes];		
	}
	Player * player = [players objectAtIndex:[aTableView clickedRow]];
	
	if ([aTableView clickedColumn] == 4) {
		if (player.startOfRoundEffect) {
			player.startOfRoundEffect = NO;
		} else {
			player.startOfRoundEffect = YES;			
		}
	}
	
	if ([aTableView clickedColumn] == 5) {
		if (player.endOfRoundEffect) {
			player.endOfRoundEffect = NO;
		} else {
			player.endOfRoundEffect = YES;			
		}
	}
	return [aTableView selectedRowIndexes];
}
*/

- (NSInteger)rollInitiative:(int)modifier;
{
	return random() % 20 + modifier + 1;
}
@end
