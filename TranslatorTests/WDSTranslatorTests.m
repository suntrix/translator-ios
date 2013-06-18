//
//  WDSTranslatorTests.m
//  WDSTranslatorTests
//
//  Created by Sebastian Owodziń on 6/18/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslatorTests.h"

#import "WDSTranslator.h"

@implementation WDSTranslatorTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testTranslatorInitialization
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    STAssertTrue( [translator isMemberOfClass:[WDSTranslator class]], nil);
}

- (void)testLoadingTranslationsFile
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *testData1 = [NSArray arrayWithObject:@"pl"];
    STAssertNoThrow([translator loadTranslations:testData1], nil);
    
    NSArray *testData2 = [NSArray arrayWithObjects:@"pl", @"fr", nil];
    STAssertNoThrow([translator loadTranslations:testData2], nil);
    
    NSArray *testData3 = [NSArray arrayWithObject:@"de"];
    STAssertThrows([translator loadTranslations:testData3], nil);
}

- (void)testTranslatingStringUsingLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *inputData = [NSArray arrayWithObjects:@"YES", @"NO", @"Yes", @"No", @"Test string", nil];
    NSArray *plData = [NSArray arrayWithObjects:@"TAK", @"NIE", @"Tak", @"Nie", @"Ciąg testowy", nil];
    
    [inputData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        STAssertTrue([[translator translate:obj toLanguage:@"pl"] isEqualToString:[plData objectAtIndex:idx]], nil);
        STAssertThrows([translator translate:obj toLanguage:@"de"], nil);
    }];
}

- (void)testTranslatingString
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";
    
    NSArray *inputData = [NSArray arrayWithObjects:@"YES", @"NO", @"Yes", @"No", @"Test string", nil];
    NSArray *frData = [NSArray arrayWithObjects:@"OUI", @"NON", @"Oui", @"Non", @"Chaîne de test", nil];
    
    [inputData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        STAssertTrue([[translator translate:obj] isEqualToString:[frData objectAtIndex:idx]], nil);
        STAssertThrows([translator translate:obj toLanguage:@"de"], nil);
    }];
}

- (void)testTranslatingManyStringsUsingLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *inputData = [NSArray arrayWithObjects:@"YES", @"NO", @"Yes", @"No", @"Test string", nil];
    NSArray *plData = [NSArray arrayWithObjects:@"TAK", @"NIE", @"Tak", @"Nie", @"Ciąg testowy", nil];
    
    STAssertTrue([[translator translateMany:inputData toLanguage:@"pl"] isEqualToArray:plData], nil);
}

- (void)testTranslatingManyStrings
{
    WDSTranslator *translator = [WDSTranslator sharedObject];
    
    translator.translationsLanguageCode = @"fr";
    
    NSArray *inputData = [NSArray arrayWithObjects:@"YES", @"NO", @"Yes", @"No", @"Test string", nil];
    NSArray *frData = [NSArray arrayWithObjects:@"OUI", @"NON", @"Oui", @"Non", @"Chaîne de test", nil];
    
    STAssertTrue([[translator translateMany:inputData] isEqualToArray:frData], nil);
}

@end
