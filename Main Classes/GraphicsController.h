//
//  GraphicsController.h
//  MacAssistant
//
//  Created by Athanasios Siopoudis on 15/10/2012.
//  Based on LittleBlue50's source code for fmsx11
//

#import <Foundation/Foundation.h>

@interface GraphicsController : NSObject <NSXMLParserDelegate> {
    NSMutableDictionary *graphicsFMFInfos;
	
	NSMutableDictionary *homeKits, *awayKits, *thirdKits;
	NSMutableDictionary *smallClubLogos, *clubLogos, *hugeClubLogos, *clubBGLogos;
	NSMutableDictionary *competitionBGLogos, *smallCompetitionLogos, *competitionLogos, *hugeCompetitionLogos;
	NSMutableDictionary *nationBGLogos, *smallNationLogos, *nationLogos, *hugeNationLogos, *nationFlags;
	NSMutableDictionary *continentBGLogos, *smallContinentLogos, *continentLogos, *hugeContinentLogos;
	NSMutableDictionary *personPhotos, *smallPersonPhotos;
    
	NSString *fileBase;
}

@property (copy,readwrite) NSMutableDictionary *homeKits, *awayKits, *thirdKits, *smallClubLogos,
*clubLogos, *hugeClubLogos, *smallCompetitionLogos, *competitionLogos, *hugeCompetitionLogos,
*smallNationLogos, *nationLogos, *hugeNationLogos, *nationFlags, *smallContinentLogos,
*continentLogos, *hugeContinentLogos, *personPhotos, *smallPersonPhotos, *continentBGLogos,
*competitionBGLogos, *nationBGLogos, *clubBGLogos;


- (void)parseGraphics;
- (void)parseCoreGraphics;
- (void)parseCustomGraphics;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;

@end
