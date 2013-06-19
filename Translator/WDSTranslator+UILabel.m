//
//  WDSTranslator+UILabel.m
//  Translator
//
//  Created by Sebastian Owodziń on 6/20/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator+UILabel.h"

#import <UIKit/UIKit.h>

@implementation WDSTranslator (UILabel)

- (void)translateLabel:(UILabel *)label
{
    [self translateLabel:label toLanguage:self.translationsLanguageCode];
}

- (void)translateLabel:(UILabel *)label toLanguage:(NSString *)language
{
    label.text = [self translate:label.text toLanguage:language];
}

@end
