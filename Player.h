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
	NSInteger maxHp;
	NSInteger currentHp;
	BOOL bloodied;
	BOOL startOfRoundEffect;
	BOOL endOfRoundEffect;
	BOOL roundCompleted;
	NSColor *color;
	BOOL didFinish;
}

- (void)takeDamage:(NSInteger)damage;

@property (retain) NSString *name;
@property NSInteger initiativeModifier;
@property NSInteger initiative;
@property NSInteger maxHp;
@property NSInteger currentHp;
@property (retain) NSColor *color;
@property BOOL bloodied;
@property BOOL startOfRoundEffect;
@property BOOL endOfRoundEffect;
@property BOOL roundCompleted;

@end
