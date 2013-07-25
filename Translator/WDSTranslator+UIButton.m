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

- (void)translateButton:(UIButton *)button toLanguage:(NSString *)language
{
    NSArray *titles = @[[button titleForState:UIControlStateNormal],
                        [button titleForState:UIControlStateSelected],
                        [button titleForState:UIControlStateHighlighted],
                        [button titleForState:UIControlStateDisabled]];
    
    NSArray *translatesTitles = [self translateMany:titles toLanguage:language];
   
    [button setTitle:translatesTitles[0] forState:UIControlStateNormal];
    [button setTitle:translatesTitles[1] forState:UIControlStateSelected];
    [button setTitle:translatesTitles[2] forState:UIControlStateHighlighted];
    [button setTitle:translatesTitles[3] forState:UIControlStateDisabled];
}

- (void)translateButton:(UIButton *)button
{
    [self translateButton:button toLanguage:self.translationsLanguageCode];
}

- (void)transtaleButtons:(NSArray *)buttons toLanguage:(NSString *)language
{
    [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self translateButton:(UIButton*)obj toLanguage:language];
    }];
}

- (void)translateButtons:(NSArray *)buttons
{
    [self transtaleButtons:buttons toLanguage:self.translationsLanguageCode];
}

@end
