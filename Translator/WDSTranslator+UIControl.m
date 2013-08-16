//
//  WDSTranslator+UIControl.m
//  Translator
//
//  Created by Sebastian Owodziń on 8/12/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator+UIControl.h"

#import <UIKit/UIKit.h>

#import "WDSTranslator+UIButton.h"
#import "WDSTranslator+UITextField.h"

@implementation WDSTranslator (UIControl)

- (void)translateControl:(UIControl *)control toLanguage:(NSString *)language
{
    if ( [[control class] isSubclassOfClass:[UIButton class]] )
    {
        [self translateButton:(UIButton *)control toLanguage:language];
    }
    else if ( [[control class] isSubclassOfClass:[UITextField class]] )
    {
        [self translateTextField:(UITextField *)control toLanguage:language];
    }
}

- (void)translateControl:(UIControl *)control
{
    [self translateControl:control toLanguage:self.translationsLanguageCode];
}

- (void)translateControls:(NSArray *)controls toLanguage:(NSString *)language
{
    [controls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self translateControl:(UIControl *)obj toLanguage:language];
    }];
}

- (void)translateControls:(NSArray *)controls
{
    [self translateControls:controls toLanguage:self.translationsLanguageCode];
}

@end
