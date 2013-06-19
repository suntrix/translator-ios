//
//  WDSTranslator+UIButton.m
//  Translator
//
//  Created by Sebastian Owodziń on 6/20/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator+UIButton.h"

#import <UIKit/UIKit.h>

@implementation WDSTranslator (UIButton)

- (void)translateButton:(UIButton *)button
{
    [self translateButton:button toLanguage:self.translationsLanguageCode];
}

- (void)translateButton:(UIButton *)button toLanguage:(NSString *)language
{
    NSString *translatedText = [self translate:button.titleLabel.text toLanguage:language];
    
    [button setTitle:translatedText forState:UIControlStateNormal];
    [button setTitle:translatedText forState:UIControlStateSelected];
    [button setTitle:translatedText forState:UIControlStateHighlighted];
    [button setTitle:translatedText forState:UIControlStateDisabled];
}

@end
