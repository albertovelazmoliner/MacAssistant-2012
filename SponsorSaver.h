//
//  SponsorSaver.h
//  FM10SX
//
//  Created by Amy Kettlewell on 10/01/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Sponsor.h"

@interface SponsorSaver : NSObject {

}

+ (void)saveSponsor:(Sponsor *)object toData:(NSMutableData *)data;

@end