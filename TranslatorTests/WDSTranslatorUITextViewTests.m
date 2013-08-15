//
//  WDSTranslatorUITextViewTests.m
//  Translator
//
//  Created by Jacek Wierzbicki-Woś on 15/08/2013.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <UIKit/UIKit.h>

#import "WDSTranslator+UITextView.h"

@interface WDSTranslatorUITextViewTests : XCTestCase
{
    NSDictionary * __testData;
}
@end

@implementation WDSTranslatorUITextViewTests

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

// - (void)translateTextView:(UILabel *)label toLanguage:(NSString *)language;
// ------------------------------------------------------------------------------------------
- (void)testTranslateTextViewToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        
        textView.text = obj;
        [translator translateTextView:textView toLanguage:@"pl"];
        NSString *plString = __testData[@"pl"][obj];
        
        XCTAssertEqualObjects(textView.text, plString, @"");
    }];
}

- (void)testTranslateTextViewToLanguageNonexistent
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textView.text = obj;
        
        XCTAssertThrows([translator translateTextView:textView toLanguage:@"de"], @"");
    }];
}

- (void)testDoubleTranslateTextViewToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textView.text = obj;
        
        [translator translateTextView:textView toLanguage:@"pl"];
        [translator translateTextView:textView toLanguage:@"fr"];
        NSString *plString = __testData[@"pl"][obj];
        
        XCTAssertEqualObjects(textView.text, plString, @"");
    }];
}
// ==========================================================================================

// - (void)translateTextView:(UILabel *)label;
// ------------------------------------------------------------------------------------------
- (void)testTranslateTextView
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";
    
    NSArray *keys = [__testData[@"fr"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textView.text = obj;
        
        [translator translateTextView:textView];
        NSString *frString = __testData[@"fr"][obj];
        
        XCTAssertEqualObjects(textView.text, frString, @"");
    }];
}

- (void)testTranslateTextViewWithNonexistentLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"de";
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    textView.text = @"TEST123";
    
    XCTAssertThrows([translator translateTextView:textView], @"");
}

- (void)testDoubleTranslateTextView
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";
    
    NSArray *keys = [__testData[@"fr"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textView.text = obj;
        
        [translator translateTextView:textView];
        translator.translationsLanguageCode = @"pl";
        [translator translateTextView:textView];
        translator.translationsLanguageCode = @"fr";
        
        NSString *frString = __testData[@"fr"][obj];
        
        XCTAssertEqualObjects(textView.text, frString, @"");
    }];
}
// ==========================================================================================

// - (void)translateTextViews:(NSArray *)labels toLanguage:(NSString *)language;
// ------------------------------------------------------------------------------------------
- (void)testTranslateTextViewsToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *textViews = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textView.text = obj;
        
        [textViews insertObject:textView atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateTextViews:textViews toLanguage:@"pl"];
    [textViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UITextView *)obj).text, plString, @"");
    }];
}

- (void)testTranslateTextViewsToLanguageNonexistent
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *textViews= [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textView.text = obj;
        
        [textViews insertObject:textView atIndex:idx];
    }];
    
    XCTAssertThrows([translator translateTextViews:textViews toLanguage:@"de"], @"");
}

- (void)testDoubleTranslateTextViewsToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *textViews = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textView.text = obj;
        
        [textViews insertObject:textView atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateTextViews:textViews toLanguage:@"pl"];
    [translator translateTextViews:textViews toLanguage:@"fr"];
    
    [textViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UITextView *)obj).text, plString, @"");
    }];
}
// ==========================================================================================

// - (void)translateTextViews:(NSArray *)labels;
// ------------------------------------------------------------------------------------------
- (void)testTranslateTextViews
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"pl";
    
    NSMutableArray *textViews = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textView.text = obj;
        
        [textViews insertObject:textView atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateTextViews:textViews];
    [textViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UITextView *)obj).text, plString, @"");
    }];
}

- (void)testTranslateTextViewsWithNonexistentLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"de";
    
    NSMutableArray *textViews = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textView.text = obj;
        
        [textViews insertObject:textView atIndex:idx];
    }];
    
    XCTAssertThrows([translator translateTextViews:textViews], @"");
}

- (void)testDoubleTranslateTextViews
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *textViews = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textView.text = obj;
        
        [textViews insertObject:textView atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateTextViews:textViews toLanguage:@"pl"];
    [translator translateTextViews:textViews toLanguage:@"fr"];
    [textViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UITextView *)obj).text, plString, @"");
    }];
}
// ==========================================================================================

@end
