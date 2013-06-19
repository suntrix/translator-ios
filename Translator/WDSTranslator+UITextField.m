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

- (void)translateTextField:(UITextField *)textField
{
    [self translateTextField:textField toLanguage:self.translationsLanguageCode];
}

- (void)translateTextField:(UITextField *)textField toLanguage:(NSString *)language
{
    textField.placeholder = [self translate:textField.placeholder toLanguage:language];
}

@end
