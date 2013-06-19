//
//  WDSTranslator+UIView.m
//  Translator
//
//  Created by Sebastian Owodziń on 6/20/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator+UIView.h"

#import <UIKit/UIKit.h>

@implementation WDSTranslator (UIView)

- (void)translateView:(UIView *)viewObject
{
    [self translateView:viewObject toLanguage:self.translationsLanguageCode];
}

- (void)translateView:(UIView *)viewObject toLanguage:(NSString *)language
{
    if ( [[viewObject class] isSubclassOfClass:[UILabel class]] )
    {
        [self translateLabel:(UILabel *)viewObject toLanguage:language];
    }
    else if ( [[viewObject class] isSubclassOfClass:[UIButton class]] )
    {
        [self translateButton:(UIButton *)viewObject toLanguage:language];
    }
    else if ( [[viewObject class] isSubclassOfClass:[UITextField class]] )
    {
        [self translateTextField:(UITextField *)viewObject toLanguage:language];
    }
}

@end
