//
//  WDSTranslatorUILabelTests.m
//  Translator
//
//  Created by Sebastian Owodziń on 6/22/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <UIKit/UIKit.h>
#import "WDSTranslator+UILabel.h"

@interface WDSTranslatorUILabelTests : XCTestCase
{
    NSDictionary *  __testData;
}

@end

@implementation WDSTranslatorUILabelTests

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

// - (void)translateLabel:(UILabel *)label toLanguage:(NSString *)language;
// ------------------------------------------------------------------------------------------
- (void)testTranslateLabelToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = obj;
        
        [translator translateLabel:label toLanguage:@"pl"];
        NSString *plString = __testData[@"pl"][obj];
        
        XCTAssertEqualObjects(label.text, plString, @"");
    }];
}

- (void)testTranslateLabelToLanguageNonexistent
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = obj;
        
        XCTAssertThrows([translator translateLabel:label toLanguage:@"de"], @"");
    }];
}

- (void)testDoubleTranslateLabelToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = obj;
        
        [translator translateLabel:label toLanguage:@"pl"];
        [translator translateLabel:label toLanguage:@"fr"];
        NSString *plString = __testData[@"pl"][obj];
        
        XCTAssertEqualObjects(label.text, plString, @"");
    }];
}
// ==========================================================================================

// - (void)translateLabel:(UILabel *)label;
// ------------------------------------------------------------------------------------------
- (void)testTranslateLabel
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";
    
    NSArray *keys = [__testData[@"fr"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = obj;
        
        [translator translateLabel:label];
        NSString *frString = __testData[@"fr"][obj];
        
        XCTAssertEqualObjects(label.text, frString, @"");
    }];
}

- (void)testTranslateLabelWithNonexistentLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"de";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.text = @"TEST123";
    
    XCTAssertThrows([translator translateLabel:label], @"");
}

- (void)testDoubleTranslateLabel
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";
    
    NSArray *keys = [__testData[@"fr"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = obj;
        
        [translator translateLabel:label];
        translator.translationsLanguageCode = @"pl";
        [translator translateLabel:label];
        translator.translationsLanguageCode = @"fr";
        
        NSString *frString = __testData[@"fr"][obj];
        
        XCTAssertEqualObjects(label.text, frString, @"");
    }];
}
// ==========================================================================================

// - (void)translateLabels:(NSArray *)labels toLanguage:(NSString *)language;
// ------------------------------------------------------------------------------------------
- (void)testTranslateLabelsToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *labels = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = obj;
        
        [labels insertObject:label atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateLabels:labels toLanguage:@"pl"];
    [labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UILabel *)obj).text, plString, @"");
    }];
}

- (void)testTranslateLabelsToLanguageNonexistent
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *labels = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = obj;
        
        [labels insertObject:label atIndex:idx];
    }];
    
    XCTAssertThrows([translator translateLabels:labels toLanguage:@"de"], @"");
}

- (void)testDoubleTranslateLabelsToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *labels = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = obj;
        
        [labels insertObject:label atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateLabels:labels toLanguage:@"pl"];
    [translator translateLabels:labels toLanguage:@"fr"];
    [labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UILabel *)obj).text, plString, @"");
    }];
}
// ==========================================================================================

// - (void)translateLabels:(NSArray *)labels;
// ------------------------------------------------------------------------------------------
- (void)testTranslateLabels
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"pl";
    
    NSMutableArray *labels = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = obj;
        
        [labels insertObject:label atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateLabels:labels];
    [labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UILabel *)obj).text, plString, @"");
    }];
}

- (void)testTranslateLabelsWithNonexistentLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"de";
    
    NSMutableArray *labels = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = obj;
        
        [labels insertObject:label atIndex:idx];
    }];
    
    XCTAssertThrows([translator translateLabels:labels], @"");
}

- (void)testDoubleTranslateLabels
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *labels = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = obj;
        
        [labels insertObject:label atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateLabels:labels toLanguage:@"pl"];
    [translator translateLabels:labels toLanguage:@"fr"];
    [labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UILabel *)obj).text, plString, @"");
    }];
}
// ==========================================================================================

@end
