//
//  InitiativeTrackerController.h
//  InitiativeTracker
//
//  Created by Mike Pattee on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Player;

@interface InitiativeTrackerController : NSObject {
	IBOutlet NSTextField *nameField;
	IBOutlet NSTextField *initiativeModifierField;
	IBOutlet NSTextField *rollField;
	IBOutlet NSTableView *tableView;
	IBOutlet NSColorWell *initiativeColor;
	NSMutableArray *players;
}

- (IBAction)addInitiative:(id)sender;
- (IBAction)removeInitiative:(id)sender;
- (IBAction)clearTable:(id)sender;
- (int)rollInitiative:(int)modifier;
- (void)initSorting;
@end
