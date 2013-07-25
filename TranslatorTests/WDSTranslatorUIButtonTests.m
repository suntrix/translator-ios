//
//  WDSTranslatorUIButtonTests.m
//  Translator
//
//  Created by Jacek Wierzbicki-Woś on 12/07/2013.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "WDSTranslator+UIButton.h"

@interface WDSTranslatorUIButtonTests : XCTestCase
{
    NSDictionary *  __testData;
}
@end

@implementation WDSTranslatorUIButtonTests

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

// - (void)translateButton:(UIButton *)button toLanguage:(NSString *)language;
// ------------------------------------------------------------------------------------------

- (void)testTranslateButtonToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

    [button setTitle:keys[0] forState:UIControlStateNormal];
    [button setTitle:keys[1] forState:UIControlStateSelected];
    [button setTitle:keys[2] forState:UIControlStateHighlighted];
    [button setTitle:keys[3] forState:UIControlStateDisabled];

    [translator translateButton:button toLanguage:@"pl"];
    
    XCTAssertTrue([[button titleForState:UIControlStateNormal] isEqualToString:__testData[@"pl"][keys[0]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateSelected] isEqualToString:__testData[@"pl"][keys[1]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateHighlighted] isEqualToString:__testData[@"pl"][keys[2]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateDisabled] isEqualToString:__testData[@"pl"][keys[3]]], @"");
}

- (void)testTranslateButtonToLanguageNonexistent
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];

    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        button.titleLabel.text = obj;
        
        XCTAssertThrows([translator translateButton:button toLanguage:@"de"], @"");
    }];
}

- (void)testDoubleTranslateButtonToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
  
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateSelected];
        [button setTitle:obj forState:UIControlStateHighlighted];
        [button setTitle:obj forState:UIControlStateDisabled];
        
        
        [translator translateButton:button toLanguage:@"pl"];
        [translator translateButton:button toLanguage:@"fr"];
        NSString *plString = __testData[@"pl"][obj];
        
        XCTAssertEqualObjects(button.titleLabel.text, plString, @"");
    }];
}


// - (void)translateButton:(UIButton *)button;
// ------------------------------------------------------------------------------------------

- (void)testTranslateButton
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";
    
    NSArray *keys = [__testData[@"fr"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateSelected];
        [button setTitle:obj forState:UIControlStateHighlighted];
        [button setTitle:obj forState:UIControlStateDisabled];
        
        [translator translateButton:button];
        NSString *frString = __testData[@"fr"][obj];
        
        XCTAssertEqualObjects(button.titleLabel.text, frString, @"");
    }];
}

- (void)testTranslateButtonWithNonexistentLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"de";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    button.titleLabel.text = @"TEST123";
    
    XCTAssertThrows([translator translateButton:button], @"");
}

- (void)testDoubleTranslateButton
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";
    
    NSArray *keys = [__testData[@"fr"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
       
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateSelected];
        [button setTitle:obj forState:UIControlStateHighlighted];
        [button setTitle:obj forState:UIControlStateDisabled];
        
        [translator translateButton:button];
        translator.translationsLanguageCode = @"pl";
        [translator translateButton:button];
        translator.translationsLanguageCode = @"fr";
        
        NSString *frString = __testData[@"fr"][obj];
        
        XCTAssertEqualObjects(button.titleLabel.text, frString, @"");
    }];
}

//- (void)transtaleButtons:(NSArray *)buttons toLanguage:(NSString *)language;
// ------------------------------------------------------------------------------------------
- (void)testTranslateButtonsToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateSelected];
        [button setTitle:obj forState:UIControlStateHighlighted];
        [button setTitle:obj forState:UIControlStateDisabled];
        
        [buttons insertObject:button atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator transtaleButtons:buttons toLanguage:@"pl"];
    [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        NSString *plString = translations[idx];

        XCTAssertEqualObjects(((UIButton *)obj).titleLabel.text, plString, @"");
    }];
}

- (void)testTranslateButtonsToLanguageNonexistent
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        button.titleLabel.text = obj;
        
        [buttons insertObject:button atIndex:idx];
    }];
    
    XCTAssertThrows([translator transtaleButtons:buttons toLanguage:@"de"], @"");
}

- (void)testDoubleTranslateButtonsToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateSelected];
        [button setTitle:obj forState:UIControlStateHighlighted];
        [button setTitle:obj forState:UIControlStateDisabled];
        
        [buttons insertObject:button atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator transtaleButtons:buttons toLanguage:@"pl"];
    [translator transtaleButtons:buttons toLanguage:@"fr"];
    
    [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        [translator transtaleButtons:buttons toLanguage:@"pl"];
        XCTAssertEqualObjects( ((UIButton *)obj).titleLabel.text, plString, @"");
    }];
}


//- (void)translateButtons:(NSArray *)buttons;
// ------------------------------------------------------------------------------------------
- (void)testTranslateButtons
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"pl";
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateSelected];
        [button setTitle:obj forState:UIControlStateHighlighted];
        [button setTitle:obj forState:UIControlStateDisabled];
        
        [buttons insertObject:button atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateButtons:buttons];
    [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
    XCTAssertEqualObjects( ((UIButton *)obj).titleLabel.text, plString, @"");
    }];
}

- (void)testTranslateLabelsWithNonexistentLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"de";
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateSelected];
        [button setTitle:obj forState:UIControlStateHighlighted];
        [button setTitle:obj forState:UIControlStateDisabled];
        
        [buttons insertObject:button atIndex:idx];
    }];
    
    XCTAssertThrows([translator translateButtons:buttons], @"");
}

- (void)testDoubleTranslateButtons
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateSelected];
        [button setTitle:obj forState:UIControlStateHighlighted];
        [button setTitle:obj forState:UIControlStateDisabled];
       
        [buttons insertObject:button atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator transtaleButtons:buttons toLanguage:@"pl"];
    [translator transtaleButtons:buttons toLanguage:@"fr"];
    [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UIButton *)obj).titleLabel.text, plString, @"");
    }];
}
// ==========================================================================================

@end
