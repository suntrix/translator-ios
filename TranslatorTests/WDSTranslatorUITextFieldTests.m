//
//  WDSTranslatorUITextFieldTests.m
//  Translator
//
//  Created by Jacek Wierzbicki-Woś on 15/07/2013.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <UIKit/UIKit.h>
#import "WDSTranslator+UITextField.h"

@interface WDSTranslatorUITextFieldTests : XCTestCase
{
    NSDictionary *  __testData;
}
@end

@implementation WDSTranslatorUITextFieldTests

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
- (void)testTranslateTextFieldToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

        textField.placeholder = obj;
        
        [translator translateTextField:textField toLanguage:@"pl"];
        NSString *plString = __testData[@"pl"][obj];
       
        XCTAssertEqualObjects(textField.placeholder, plString, @"");
    }];
}

- (void)testTranslateTextFieldToLanguageNonexistent
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textField.placeholder = obj;
        
        XCTAssertThrows([translator translateTextField:textField toLanguage:@"de"], @"");
    }];
}

- (void)testDoubleTranslateTextFieldToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textField.placeholder = obj;
        
        [translator translateTextField:textField toLanguage:@"pl"];
        [translator translateTextField:textField toLanguage:@"fr"];
        NSString *plString = __testData[@"pl"][obj];
        
        XCTAssertEqualObjects(textField.placeholder, plString, @"");
    }];
}
// ==========================================================================================

// - (void)translateLabel:(UILabel *)label;
// ------------------------------------------------------------------------------------------
- (void)testTranslateTextField
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";
    
    NSArray *keys = [__testData[@"fr"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textField.placeholder = obj;

        [translator translateTextField:textField];
        NSString *frString = __testData[@"fr"][obj];
        
        XCTAssertEqualObjects(textField.placeholder, frString, @"");
    }];
}

- (void)testTranslateTextFieldWithNonexistentLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"de";
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    textField.placeholder = @"TEST123";
    
    XCTAssertThrows([translator translateTextField:textField], @"");
}

- (void)testDoubleTranslateTextField
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"fr";
    
    NSArray *keys = [__testData[@"fr"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textField.placeholder = obj;
        
        [translator translateTextField:textField];
        translator.translationsLanguageCode = @"pl";
        [translator translateTextField:textField];
        translator.translationsLanguageCode = @"fr";
        
        NSString *frString = __testData[@"fr"][obj];
        
        XCTAssertEqualObjects(textField.placeholder, frString, @"");
    }];
}
// ==========================================================================================

// - (void)translateLabels:(NSArray *)labels toLanguage:(NSString *)language;
// ------------------------------------------------------------------------------------------
- (void)testTranslateTextFieldsToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *textFields = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textField.placeholder = obj;
        
        [textFields insertObject:textField atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateTextFields:textFields toLanguage:@"pl"];
    [textFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UITextField *)obj).placeholder, plString, @"");
    }];
}

- (void)testTranslateTextFieldsToLanguageNonexistent
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *textFields = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textField.placeholder = obj;
        
        [textFields insertObject:textField atIndex:idx];
    }];

    XCTAssertThrows([translator translateTextFields:textFields toLanguage:@"de"], @"");
}

- (void)testDoubleTranslateTextFieldsToLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *textFields = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textField.placeholder = obj;
        
        [textFields insertObject:textField atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateTextFields:textFields toLanguage:@"pl"];
    [translator translateTextFields:textFields toLanguage:@"fr"];

    [textFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UITextField *)obj).placeholder, plString, @"");
    }];
}
// ==========================================================================================

// - (void)translateLabels:(NSArray *)labels;
// ------------------------------------------------------------------------------------------
- (void)testTranslateTextFields
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"pl";
    
    NSMutableArray *textFields = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textField.placeholder = obj;
        
        [textFields insertObject:textField atIndex:idx];
    }];
    
    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateTextFields:textFields];
    [textFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UITextField *)obj).placeholder, plString, @"");
    }];
}

- (void)testTranslateTextFieldsWithNonexistentLanguage
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    translator.translationsLanguageCode = @"de";
    
    NSMutableArray *textFields = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textField.placeholder = obj;
        
        [textFields insertObject:textField atIndex:idx];
    }];
    
    XCTAssertThrows([translator translateTextFields:textFields], @"");
}

- (void)testDoubleTranslateTextFields
{
    WDSTranslator *translator = [[WDSTranslator alloc] init];
    
    NSMutableArray *textFields = [NSMutableArray array];
    
    NSArray *keys = [__testData[@"pl"] allKeys];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        textField.placeholder = obj;
        
        [textFields insertObject:textField atIndex:idx];
    }];

    NSArray *translations = [__testData[@"pl"] allValues];
    [translator translateTextFields:textFields toLanguage:@"pl"];
    [translator translateTextFields:textFields toLanguage:@"fr"];
    [textFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *plString = translations[idx];
        
        XCTAssertEqualObjects(((UITextField *)obj).placeholder, plString, @"");
    }];
}
// ==========================================================================================

@end
