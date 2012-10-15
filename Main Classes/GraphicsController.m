//
//  GraphicsController.m
//  MacAssistant
//
//  Created by Athanasios Siopoudis on 15/10/2012.
//
//

#import "GraphicsController.h"
#import "Controller.h"
#import "SupportFunctions.h"

@implementation GraphicsController

@synthesize homeKits, awayKits, thirdKits, smallClubLogos, clubLogos, hugeClubLogos,
smallCompetitionLogos, competitionLogos, hugeCompetitionLogos, smallNationLogos,
nationLogos, hugeNationLogos, nationFlags, smallContinentLogos, continentLogos,
hugeContinentLogos, personPhotos, smallPersonPhotos, continentBGLogos, competitionBGLogos,
nationBGLogos, clubBGLogos;

- (id)init
{
	[super init];
	
	graphicsFMFInfos = [[NSMutableDictionary alloc] init];
	
	homeKits = [[NSMutableDictionary alloc] init];
	awayKits = [[NSMutableDictionary alloc] init];
	thirdKits = [[NSMutableDictionary alloc] init];
	smallClubLogos = [[NSMutableDictionary alloc] init];
	clubLogos = [[NSMutableDictionary alloc] init];
	hugeClubLogos = [[NSMutableDictionary alloc] init];
	smallCompetitionLogos = [[NSMutableDictionary alloc] init];
	competitionLogos = [[NSMutableDictionary alloc] init];
	hugeCompetitionLogos = [[NSMutableDictionary alloc] init];
	smallNationLogos = [[NSMutableDictionary alloc] init];
	nationLogos = [[NSMutableDictionary alloc] init];
	hugeNationLogos = [[NSMutableDictionary alloc] init];
	nationFlags = [[NSMutableDictionary alloc] init];
	smallContinentLogos = [[NSMutableDictionary alloc] init];
	continentLogos = [[NSMutableDictionary alloc] init];
	hugeContinentLogos = [[NSMutableDictionary alloc] init];
	personPhotos = [[NSMutableDictionary alloc] init];
	smallPersonPhotos = [[NSMutableDictionary alloc] init];
	continentBGLogos = [[NSMutableDictionary alloc] init];
	competitionBGLogos = [[NSMutableDictionary alloc] init];
	nationBGLogos = [[NSMutableDictionary alloc] init];
	clubBGLogos = [[NSMutableDictionary alloc] init];
	
	return self;
}

- (void)dealloc
{
	[graphicsFMFInfos release];
	
	[homeKits release];
	[awayKits release];
	[thirdKits release];
	[homeKits release];
	[awayKits release];
	[thirdKits release];
	[smallClubLogos release];
	[clubLogos release];
	[hugeClubLogos release];
	[clubBGLogos release];
	[smallCompetitionLogos release];
	[competitionLogos release];
	[hugeCompetitionLogos release];
	[competitionBGLogos release];
	[smallNationLogos release];
	[nationLogos release];
	[hugeNationLogos release];
	[nationBGLogos release];
	[nationFlags release];
	[smallContinentLogos release];
	[continentLogos release];
	[hugeContinentLogos release];
	[continentBGLogos release];
	[personPhotos release];
	[smallPersonPhotos release];
	
	[super dealloc];
}

- (void)parseGraphics
{
	// parse any graphics.fmf files there are in the FM directory first
	[self parseCoreGraphics];
	
	// parse graphics in the graphics folder
	[self parseCustomGraphics];
	
	NSLog(@"Graphics Parsed");
}

- (void)parseCoreGraphics
{
	NSString *graphicsFMFPath = [NSString stringWithFormat:@"%@/data/graphics.fmf",[[[NSUserDefaults standardUserDefaults] stringForKey:@"langDBPath"] stringByExpandingTildeInPath]];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:graphicsFMFPath]) {
		int fp = open([graphicsFMFPath cStringUsingEncoding:[NSString defaultCStringEncoding]], O_RDONLY);
		unsigned int fmf1Length;
		
		// get fmf1 length
		lseek(fp,9,SEEK_SET);
		read(fp,&fmf1Length,4);
		close(fp);
	}
}

- (void)parseCustomGraphics
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *basePath = [[[NSUserDefaults standardUserDefaults] objectForKey:@"graphicsLocation"] stringByExpandingTildeInPath];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:basePath]) {
		NSArray *objects = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:basePath error:NULL];
		
		for (NSString *item in objects)
		{
			if ([[[item lastPathComponent] lowercaseString] isEqualToString:@"config.xml"]) {
				fileBase = [[NSString stringWithFormat:@"%@/%@",basePath,item] stringByDeletingLastPathComponent];
				NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",basePath,item]]];
				[parser setDelegate:self];
				[parser parse];
				[parser release];
			}
		}
	}
	
	[pool drain];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributes
{
	if ([[elementName lowercaseString] isEqualToString:@"record"] &&
		[attributes objectForKey:@"from"]!=nil &&
		[attributes objectForKey:@"to"]!=nil) {
		NSMutableArray *pathComponents = [[NSMutableArray alloc] initWithArray:[[attributes objectForKey:@"to"] pathComponents]];
		
		if ([pathComponents count] < 5) { return; }
		
		int UID = [[pathComponents objectAtIndex:3] intValue];
		NSString *filePath = [[NSString alloc] initWithFormat:@"%@/%@.png",fileBase,[attributes objectForKey:@"from"]];
		NSString *subType = [[NSString alloc] initWithString:[[pathComponents objectAtIndex:2] lowercaseString]];
		
		[pathComponents removeObjectsInRange:NSMakeRange(0, 4)];
		NSString *type = [[NSString alloc] initWithString:[[NSString pathWithComponents:pathComponents] lowercaseString]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
			/*
             if ([type isEqualToString:@"kits/home"]) {
             [homeKits setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             else if ([type isEqualToString:@"kits/away"]) {
             [awayKits setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             else if ([type isEqualToString:@"kits/third"]) {
             [thirdKits setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             
			 else if ([type isEqualToString:@"logo/huge"] &&
             [subType isEqualToString:@"club"]) {
             [hugeClubLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             */
			if ([type isEqualToString:@"logo"] &&
                [subType isEqualToString:@"club"]) {
				[clubLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
			}
			/*
			 else if ([type isEqualToString:@"icon"] &&
             [subType isEqualToString:@"club"]) {
             [smallClubLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             */
			else if ([type isEqualToString:@"logo/background/left"] &&
					 [subType isEqualToString:@"club"]) {
				[clubBGLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
			}
			/*
			 else if ([type isEqualToString:@"logo/huge"] &&
             [subType isEqualToString:@"comp"]) {
             [hugeCompetitionLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             */
			else if ([type isEqualToString:@"logo"] &&
					 [subType isEqualToString:@"comp"]) {
				[competitionLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
			}
			/*
			 else if ([type isEqualToString:@"icon"] &&
             [subType isEqualToString:@"comp"]) {
             [smallCompetitionLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             */
			else if ([type isEqualToString:@"logo/background/left"] &&
					 [subType isEqualToString:@"comp"]) {
				[competitionBGLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
			}
			/*
			 else if ([type isEqualToString:@"logo/huge"] &&
             [subType isEqualToString:@"nation"]) {
             [hugeNationLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             */
			else if ([type isEqualToString:@"logo"] &&
					 [subType isEqualToString:@"nation"]) {
				[nationLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
			}
			/*
			 else if ([type isEqualToString:@"icon"] &&
             [subType isEqualToString:@"nation"]) {
             [smallNationLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             */
			else if ([type isEqualToString:@"logo/background/left"] &&
					 [subType isEqualToString:@"nation"]) {
				[nationBGLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
			}
			else if ([type isEqualToString:@"flag"] &&
					 [subType isEqualToString:@"nation"]) {
				[nationFlags setObject:filePath forKey:[NSNumber numberWithInt:UID]];
			}
			/*
			 else if ([type isEqualToString:@"logo/huge"] &&
             [subType isEqualToString:@"continent"]) {
             [hugeContinentLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             */
			else if ([type isEqualToString:@"logo"] &&
					 [subType isEqualToString:@"continent"]) {
				[continentLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
			}
			else if ([type isEqualToString:@"logo/background/left"] &&
					 [subType isEqualToString:@"continent"]) {
				[continentBGLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
			}
			/*
			 else if ([type isEqualToString:@"icon"] &&
             [subType isEqualToString:@"continent"]) {
             [smallContinentLogos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             */
			else if ([type isEqualToString:@"portrait"] &&
					 [subType isEqualToString:@"person"]) {
				[personPhotos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
			}
            /*	
             else if ([type isEqualToString:@"icon"] &&
             [subType isEqualToString:@"person"]) {
             [smallPersonPhotos setObject:filePath forKey:[NSNumber numberWithInt:UID]];
             }
             */	
			[type release];
			[subType release];
			[filePath release];
			[pathComponents release];
		}
	}
}

@end
