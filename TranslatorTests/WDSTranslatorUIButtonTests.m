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
    
    NSDictionary *plStrings = __testData[@"pl"];
    NSArray *keys = [plStrings allKeys];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

    [button setTitle:keys[0] forState:UIControlStateNormal];
    [button setTitle:keys[1] forState:UIControlStateSelected];
    [button setTitle:keys[2] forState:UIControlStateHighlighted];
    [button setTitle:keys[3] forState:UIControlStateDisabled];

    [translator translateButton:button toLanguage:@"pl"];
    
    XCTAssertTrue([[button titleForState:UIControlStateNormal] isEqualToString:plStrings[keys[0]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateSelected] isEqualToString:plStrings[keys[1]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateHighlighted] isEqualToString:plStrings[keys[2]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateDisabled] isEqualToString:plStrings[keys[3]]], @"");
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
    
    NSDictionary *plStrings = __testData[@"pl"];
    NSArray *keys = [plStrings allKeys];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    
    [button setTitle:keys[0] forState:UIControlStateNormal];
    [button setTitle:keys[1] forState:UIControlStateSelected];
    [button setTitle:keys[2] forState:UIControlStateHighlighted];
    [button setTitle:keys[3] forState:UIControlStateDisabled];
    
    [translator translateButton:button toLanguage:@"pl"];
    [translator translateButton:button toLanguage:@"fr"];
    
    XCTAssertTrue([[button titleForState:UIControlStateNormal] isEqualToString:plStrings[keys[0]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateSelected] isEqualToString:plStrings[keys[1]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateHighlighted] isEqualToString:plStrings[keys[2]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateDisabled] isEqualToString:plStrings[keys[3]]], @"");
}


// - (void)translateButton:(UIButton *)button;
// ------------------------------------------------------------------------------------------

- (void)testTranslateButton
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";
    
    NSDictionary *frStrings = __testData[@"fr"];
    NSArray *keys = [frStrings allKeys];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    
    [button setTitle:keys[0] forState:UIControlStateNormal];
    [button setTitle:keys[1] forState:UIControlStateSelected];
    [button setTitle:keys[2] forState:UIControlStateHighlighted];
    [button setTitle:keys[3] forState:UIControlStateDisabled];
    
    [translator translateButton:button];
    
    XCTAssertTrue([[button titleForState:UIControlStateNormal] isEqualToString:frStrings[keys[0]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateSelected] isEqualToString:frStrings[keys[1]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateHighlighted] isEqualToString:frStrings[keys[2]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateDisabled] isEqualToString:frStrings[keys[3]]], @"");
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
    
    NSDictionary *frStrings = __testData[@"fr"];
    NSArray *keys = [frStrings allKeys];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    
    [button setTitle:keys[0] forState:UIControlStateNormal];
    [button setTitle:keys[1] forState:UIControlStateSelected];
    [button setTitle:keys[2] forState:UIControlStateHighlighted];
    [button setTitle:keys[3] forState:UIControlStateDisabled];
    
    [translator translateButton:button];
    translator.translationsLanguageCode = @"pl";
    [translator translateButton:button];
    
    XCTAssertTrue([[button titleForState:UIControlStateNormal] isEqualToString:frStrings[keys[0]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateSelected] isEqualToString:frStrings[keys[1]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateHighlighted] isEqualToString:frStrings[keys[2]]], @"");
    XCTAssertTrue([[button titleForState:UIControlStateDisabled] isEqualToString:frStrings[keys[3]]], @"");
}

//- (void)transtaleButtons:(NSArray *)buttons toLanguage:(NSString *)language;
// ------------------------------------------------------------------------------------------
- (void)testTranslateButtonsToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    NSDictionary *plStrings = __testData[@"pl"];
    NSArray *keys = [plStrings allKeys];
    
    for ( NSInteger idx = 0; idx < 2; idx++ )
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [button setTitle:keys[idx] forState:UIControlStateNormal];
        [button setTitle:keys[idx+1] forState:UIControlStateSelected];
        [button setTitle:keys[idx+2] forState:UIControlStateHighlighted];
        [button setTitle:keys[idx+3] forState:UIControlStateDisabled];
        [buttons insertObject:button atIndex:idx];
    }
    
    [translator translateButtons:buttons toLanguage:@"pl"];
    
    [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        XCTAssertTrue([[button titleForState:UIControlStateNormal] isEqualToString:plStrings[keys[idx]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateSelected] isEqualToString:plStrings[keys[idx+1]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateHighlighted] isEqualToString:plStrings[keys[idx+2]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateDisabled] isEqualToString:plStrings[keys[idx+3]]], @"");
    }];
}

- (void)testTranslateButtonsToLanguageNonexistent
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        
        [buttons insertObject:button atIndex:idx];
    }];
    
    XCTAssertThrows([translator translateButtons:buttons toLanguage:@"de"], @"");
}

- (void)testDoubleTranslateButtonsToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    NSDictionary *plStrings = __testData[@"pl"];
    NSArray *keys = [plStrings allKeys];
    
    for ( NSInteger idx = 0; idx < 2; idx++ )
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [button setTitle:keys[idx] forState:UIControlStateNormal];
        [button setTitle:keys[idx+1] forState:UIControlStateSelected];
        [button setTitle:keys[idx+2] forState:UIControlStateHighlighted];
        [button setTitle:keys[idx+3] forState:UIControlStateDisabled];
        [buttons insertObject:button atIndex:idx];
    }
    
    [translator translateButtons:buttons toLanguage:@"pl"];
    [translator translateButtons:buttons toLanguage:@"fr"];
    
    [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        XCTAssertTrue([[button titleForState:UIControlStateNormal] isEqualToString:plStrings[keys[idx]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateSelected] isEqualToString:plStrings[keys[idx+1]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateHighlighted] isEqualToString:plStrings[keys[idx+2]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateDisabled] isEqualToString:plStrings[keys[idx+3]]], @"");
    }];
}


//- (void)translateButtons:(NSArray *)buttons;
// ------------------------------------------------------------------------------------------
- (void)testTranslateButtons
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"pl";
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    NSDictionary *plStrings = __testData[@"pl"];
    NSArray *keys = [plStrings allKeys];
    
    for ( NSInteger idx = 0; idx < 2; idx++ )
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [button setTitle:keys[idx] forState:UIControlStateNormal];
        [button setTitle:keys[idx+1] forState:UIControlStateSelected];
        [button setTitle:keys[idx+2] forState:UIControlStateHighlighted];
        [button setTitle:keys[idx+3] forState:UIControlStateDisabled];
        [buttons insertObject:button atIndex:idx];
    }
    
    [translator translateButtons:buttons];
    
    [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        XCTAssertTrue([[button titleForState:UIControlStateNormal] isEqualToString:plStrings[keys[idx]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateSelected] isEqualToString:plStrings[keys[idx+1]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateHighlighted] isEqualToString:plStrings[keys[idx+2]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateDisabled] isEqualToString:plStrings[keys[idx+3]]], @"");
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
        
        [buttons insertObject:button atIndex:idx];
    }];
    
    XCTAssertThrows([translator translateButtons:buttons], @"");
}

- (void)testDoubleTranslateButtons
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"pl";
    
    NSMutableArray *buttons = [NSMutableArray array];
    
    NSDictionary *plStrings = __testData[@"pl"];
    NSArray *keys = [plStrings allKeys];
    
    for ( NSInteger idx = 0; idx < 2; idx++ )
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [button setTitle:keys[idx] forState:UIControlStateNormal];
        [button setTitle:keys[idx+1] forState:UIControlStateSelected];
        [button setTitle:keys[idx+2] forState:UIControlStateHighlighted];
        [button setTitle:keys[idx+3] forState:UIControlStateDisabled];
        [buttons insertObject:button atIndex:idx];
    }
    
    [translator translateButtons:buttons];
    translator.translationsLanguageCode = @"fr";
    [translator translateButtons:buttons];
    
    [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        XCTAssertTrue([[button titleForState:UIControlStateNormal] isEqualToString:plStrings[keys[idx]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateSelected] isEqualToString:plStrings[keys[idx+1]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateHighlighted] isEqualToString:plStrings[keys[idx+2]]], @"");
        XCTAssertTrue([[button titleForState:UIControlStateDisabled] isEqualToString:plStrings[keys[idx+3]]], @"");
    }];
}
// ==========================================================================================

@end
