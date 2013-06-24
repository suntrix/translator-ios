//
//  WDSTranslatorTests.m
//  WDSTranslatorTests
//
//  Created by Sebastian Owodziń on 6/21/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "WDSTranslator.h"

@interface WDSTranslatorTests : XCTestCase
{
    NSDictionary *  __testData;
}

@end

@implementation WDSTranslatorTests

- (void)setUp
{
    [super setUp];
    
    __testData = @{
                   @"pl": @{@"YES": @"TAK", @"NO": @"NIE", @"Yes": @"Tak", @"No": @"Nie", @"Test string": @"Ciąg testowy"},
                   @"fr" : @{@"YES": @"OUI", @"NO": @"NON", @"Yes": @"Oui", @"No": @"Non", @"Test string": @"Chaîne de test"}
                   };
}

- (void)tearDown
{
    __testData = nil;
    
    [super tearDown];
}

- (void)testTranslatorObjectInit
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    XCTAssertTrue([translator isMemberOfClass:[WDSTranslator class]], @"");
}

- (void)testLoadTranslations
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    XCTAssertNoThrow([translator loadTranslations:@[@"pl"]], @"");
    
    NSArray *data = @[@"pl", @"fr"];
    XCTAssertNoThrow([translator loadTranslations:data], @"");
    
    XCTAssertThrows([translator loadTranslations:@[@"de"]], @"");
}

// - (NSString *)translate:(NSString *)text toLanguage:(NSString *)language;
// ------------------------------------------------------------------------------------------
- (void)testTranslateToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = __testData[@"pl"][obj];
        XCTAssertEqualObjects([translator translate:obj toLanguage:@"pl"], plString, @"");
    }];
}

- (void)testTranslateToLanguageNonexistent
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertThrows([translator translate:obj toLanguage:@"de"], @"");
    }];
}

- (void)testDoubleTranslateToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = __testData[@"pl"][obj];
        NSString *translatedString = [translator translate:obj toLanguage:@"pl"];
        XCTAssertEqualObjects([translator translate:translatedString toLanguage:@"pl"], plString, @"");
        XCTAssertEqualObjects([translator translate:translatedString toLanguage:@"fr"], plString, @"");
    }];
}
// ==========================================================================================

// - (NSString *)translate:(NSString *)text;
// ------------------------------------------------------------------------------------------
- (void)testTranslate
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";

    NSArray *keys = [__testData[@"fr"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *frString = __testData[@"fr"][obj];
        XCTAssertTrue([[translator translate:obj] isEqualToString:frString], @"");
    }];
}

- (void)testTranslateWithNonexistentLanguage
{
    XCTFail(@"Need to be implemented!");
}

- (void)testDoubleTranslate
{
    XCTFail(@"Need to be implemented!");
}
// ==========================================================================================

// - (NSArray *)translateMany:(NSArray *)texts toLanguage:(NSString *)language;
// ------------------------------------------------------------------------------------------
- (void)testTranslateManyToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    XCTAssertEqualObjects([translator translateMany:[__testData[@"pl"] allKeys] toLanguage:@"pl"], [__testData[@"pl"] allValues], @"");
}

- (void)testTranslateManyToLanguageNonexistent
{
    XCTFail(@"Not implemented!");
}

- (void)testDoubleTranslateManyToLanguage
{
    XCTFail(@"Not implemented!");
}
// ==========================================================================================

// - (NSArray *)translateMany:(NSArray *)texts;
// ------------------------------------------------------------------------------------------
- (void)testTranslateMany
{
    WDSTranslator *translator = [WDSTranslator sharedObject];
    
    translator.translationsLanguageCode = @"fr";
    
    XCTAssertEqualObjects([translator translateMany:[__testData[@"fr"] allKeys]], [__testData[@"fr"] allValues], @"");
}

- (void)testTranslateManyWithNonexistentLanguage
{
    XCTFail(@"Not implemented!");
}

- (void)testDoubleTranslateMany
{
    XCTFail(@"Not implemented!");
}
// ==========================================================================================

@end
