//
//  InitiativeTrackerController.h
//  InitiativeTracker
//
//  Created by Mike Pattee on 1/27/09.
//  Copyright 2009 Cordax Software, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Player;

@interface InitiativeTrackerController : NSObject {
	IBOutlet NSTextField *nameField;
	IBOutlet NSTextField *initiativeModifierField;
	IBOutlet NSTextField *rollField;
	IBOutlet NSTableView *tableView;
	IBOutlet NSColorWell *initiativeColor;
	IBOutlet NSTextField *roundLabel;
	IBOutlet NSButton *nextRoundButton;
	NSMutableArray *players;
	NSInteger combatRound;
}

- (IBAction)addInitiative:(id)sender;
- (IBAction)removeInitiative:(id)sender;
- (IBAction)newCombat:(id)sender;
- (IBAction)nextRound:(id)sender;
- (IBAction)nextPlayer:(id)sender;
- (int)rollInitiative:(int)modifier;
- (void)initSorting;

@property NSInteger combatRound;
@end
