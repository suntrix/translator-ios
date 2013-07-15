//
//  WDSTranslator+UITextField.h
//  Translator
//
//  Created by Sebastian Owodziń on 6/20/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator.h"

@class UITextField;

@interface WDSTranslator (UITextField)

- (void)translateTextField:(UITextField *)textField toLanguage:(NSString *)language;

- (void)translateTextField:(UITextField *)textField;

- (void)translateTextFields:(NSArray *)textFields toLanguage:(NSString *)language;

- (void)translateTextFields:(NSArray *)textFields;

@end
