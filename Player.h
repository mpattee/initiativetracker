//
//  Player.h
//  InitiativeTracker
//
//  Created by Mike Pattee on 1/27/09.
//  Copyright 2009 Cordax Software, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Player : NSObject {
	NSString *name;
	NSInteger initiativeModifier;
	NSInteger initiative;
	BOOL startOfRoundEffect;
	BOOL endOfRoundEffect;
	BOOL roundCompleted;
	NSColor *color;
}

@property (retain) NSString *name;
@property NSInteger initiativeModifier;
@property NSInteger initiative;
@property (retain) NSColor *color;
@property BOOL startOfRoundEffect;
@property BOOL endOfRoundEffect;
@property BOOL roundCompleted;

@end
