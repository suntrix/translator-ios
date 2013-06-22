//
//  TranslatorTests.m
//  TranslatorTests
//
//  Created by Sebastian Owodziń on 6/21/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "WDSTranslator.h"

@interface TranslatorTests : XCTestCase
{
    NSDictionary *  __testDataGood;
    NSDictionary *  __testDataBad;
}

@end

@implementation TranslatorTests

- (void)setUp
{
    [super setUp];
    
    __testDataGood = @{
                       @"pl": @{@"YES": @"TAK", @"NO": @"NIE", @"Yes": @"Tak", @"No": @"Nie", @"Test string": @"Ciąg testowy"},
                       @"fr" : @{@"YES": @"OUI", @"NO": @"NON", @"Yes": @"Oui", @"No": @"Non", @"Test string": @"Chaîne de test"}
                       };
    
    //TODO : add __testDataBad & corresponding test cases
}

- (void)tearDown
{
    __testDataGood = nil;
    
    [super tearDown];
}

- (void)testTranslatorInitialization
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    XCTAssertTrue([translator isMemberOfClass:[WDSTranslator class]], @"");
}

- (void)testLoadingTranslationsFile
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    XCTAssertNoThrow([translator loadTranslations:@[@"pl"]], @"");
    
    NSArray *data = @[@"pl", @"fr"];
    XCTAssertNoThrow([translator loadTranslations:data], @"");
    
    XCTAssertThrows([translator loadTranslations:@[@"de"]], @"");
}

- (void)testTranslatingStringUsingLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testDataGood[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = __testDataGood[@"pl"][obj];
        XCTAssertEqualObjects([translator translate:obj toLanguage:@"pl"], plString, @"");
        XCTAssertThrows([translator translate:obj toLanguage:@"de"], @"");
    }];
}

- (void)testTranslatingString
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";

    NSArray *keys = [__testDataGood[@"fr"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *frString = __testDataGood[@"fr"][obj];
        XCTAssertTrue([[translator translate:obj] isEqualToString:frString], @"");
        XCTAssertThrows([translator translate:obj toLanguage:@"de"], @"");
    }];
}

- (void)testTranslatingManyStringsUsingLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    XCTAssertEqualObjects([translator translateMany:[__testDataGood[@"pl"] allKeys] toLanguage:@"pl"], [__testDataGood[@"pl"] allValues], @"");
}

- (void)testTranslatingManyStrings
{
    WDSTranslator *translator = [WDSTranslator sharedObject];
    
    translator.translationsLanguageCode = @"fr";
    
    XCTAssertEqualObjects([translator translateMany:[__testDataGood[@"fr"] allKeys]], [__testDataGood[@"fr"] allValues], @"");
}

@end
