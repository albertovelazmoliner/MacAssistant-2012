//
//  ContractClauseLoader.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/20.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ContractClause.h"

@interface ContractClauseLoader : NSObject {

}

+ (ContractClause *)readFromData:(NSData *)data atOffset:(unsigned int *)byteOffset;

@end
