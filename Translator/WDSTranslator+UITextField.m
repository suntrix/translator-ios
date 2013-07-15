//
//  WDSTranslator+UITextField.m
//  Translator
//
//  Created by Sebastian Owodziń on 6/20/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator+UITextField.h"

#import <UIKit/UIKit.h>

@implementation WDSTranslator (UITextField)

- (void)translateTextField:(UITextField *)textField toLanguage:(NSString *)language
{
    textField.placeholder = [self translate:textField.placeholder toLanguage:language];
}

- (void)translateTextField:(UITextField *)textField
{
    [self translateTextField:textField toLanguage:self.translationsLanguageCode];
}

- (void)translateTextFields:(NSArray *)textFields toLanguage:(NSString *)language
{
    NSMutableArray *texts = [NSMutableArray array];
    
    [textFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [texts insertObject:((UITextField *)obj).placeholder atIndex:idx];
    }];
    
    NSArray *translatedTexts = [self translateMany:texts toLanguage:language];
    
    [textFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((UITextField *)obj).placeholder = translatedTexts[idx];
    }];
}

- (void)translateTextFields:(NSArray *)textFields
{
    [self translateTextFields:textFields toLanguage:self.translationsLanguageCode];
}

@end
