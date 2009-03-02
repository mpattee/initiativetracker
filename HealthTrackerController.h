//
//  HealthTrackerController.h
//  InitiativeTracker
//
//  Created by Mike Pattee on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class InitiativeTrackerController;

@interface HealthTrackerController : NSObject {
	IBOutlet NSTableView *table;
	IBOutlet NSTableView *initiativeTable;
	IBOutlet NSTextField *hp;
	IBOutlet NSTextField *count;
	IBOutlet NSTextField *damage;
	IBOutlet NSPanel *dealDamagePanel;
	IBOutlet InitiativeTrackerController *initiativeController;
	NSMutableArray *players;
}

- (IBAction)addPlayer:(id)sender;
- (IBAction)dealDamageOpen:(id)sender;
- (IBAction)dealDamage:(id)sender;

@property (nonatomic, retain) NSTableView *table;
@property (nonatomic, retain) NSTableView *initiativeTable;
@property (nonatomic, retain) NSTextField *hp;
@property (nonatomic, retain) NSTextField *count;
@property (nonatomic, retain) InitiativeTrackerController *initiativeController;

@end
