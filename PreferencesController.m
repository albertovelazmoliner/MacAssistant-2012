//
//  PreferencesControllerWindowController.m
//  MacAssistant
//
//  Created by Athanasios Siopoudis on 26/07/2012.
//
//

#import "PreferencesController.h"

@implementation PreferencesController

- (id)init
{
    self = [super initWithWindow:window];
    if (self) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loadLangDB"] == nil) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadLangDB"];
        }
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"parseGraphics"] == nil) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"parseGraphics"];
        }
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"langDBPath"] == nil) {
            [[NSUserDefaults standardUserDefaults] setValue:@"/Users" forKey:@"langDBPath"];
        }
        
        if (YES) { //[[NSUserDefaults standardUserDefaults] objectForKey:@"graphicsLocation"] == nil) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), @"/Documents/Sports Interactive/Football Manager 2012/graphics"] forKey:@"graphicsLocation"];
        }
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"selectedCurrency"] == nil) {
            [[NSUserDefaults standardUserDefaults] setValue:@"British Pound Sterling" forKey:@"selectedCurrency"];
        }
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self init];
}

@end
