//
//  Controller.h
//  MacAssistant
//
//  Created by Thanos Siopoudis on 8/22/10.
//  Copyright 2010 Thanos. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Sidebar.h"
#import "MacAssistantAppDelegate.h"
#import "MAView.h"
#import "PreferencesController.h"
#import "GraphicsController.h"

@class Database;
@class ContentController;
@class FMDate;

@interface Controller : NSWindowController<NSAnimationDelegate> {
	NSString                            *gamePath;
	BOOL                                idle, dataLoaded, compressed;
	unsigned short                      gameDBVersion;
	Database                            *database;
	FMDate                              *currentDate, *startDate;
	NSThread                            *gameDBThread;
	NSThread                            *parseGraphicsThread;
	int                                 databaseChanges, timesSaved, startBuildVersion, saveStartOffset, currentBuildVersion, gameID;
	NSMutableDictionary                 *infoStrings;
    GraphicsController                  *graphics;
    
    IBOutlet ContentController          *content;
	IBOutlet NSProgressIndicator        *loader;
	IBOutlet Sidebar                    *sidebar;
	IBOutlet NSWindow                   *mainWin;
    IBOutlet MacAssistantAppDelegate    *appDlg;
    IBOutlet NSTextField                *statusText;
    IBOutlet MAView                     *loaderContainer;
    IBOutlet NSToolbarItem              *loadGameToolbarItem;
    IBOutlet NSToolbarItem              *reloadGameToolbarItem;
    IBOutlet PreferencesController      *prefWindow;
}

- (IBAction) showPreferences:(id)sender;
- (IBAction) loadGame: (id) sender;
- (IBAction) reloadGame: (id)sender;
- (void) resetdb;
- (void) initGame: (NSString *)path;
- (void) populateOutlineContents:(id)inObject;
- (void) setBadgeNumber: (NSInteger)total atIndex: (NSString *)index;
- (void) revealLoaderContainer;
- (void) hideLoaderContainer;
- (void) setStatusViewTextFieldText: (NSString *)text;
- (void) doneLoadingSaveGame;

@property(nonatomic, retain) IBOutlet NSProgressIndicator *loader;
@property(nonatomic, retain) IBOutlet PreferencesController *prefWindow;

@property(copy, readwrite) NSString *gamePath;
@property(copy, readwrite) FMDate *currentDate;

@property(assign, readwrite) Database *database;
@property(assign, readwrite) GraphicsController *graphics;
@property(assign, readwrite) IBOutlet ContentController *content;
@property(assign, readwrite) BOOL idle, dataLoaded;
@property(assign, readwrite) unsigned short gameDBVersion;

@end
