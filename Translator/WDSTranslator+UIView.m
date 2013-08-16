//
//  WDSTranslator+UIView.m
//  Translator
//
//  Created by Sebastian Owodziń on 6/20/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator+UIView.h"

#import <UIKit/UIKit.h>

#import "WDSTranslatorUIKitAddons.h"

@interface WDSTranslator ()

@end

@implementation WDSTranslator (UIView)

- (void)translateView:(UIView *)view toLanguage:(NSString *)language
{
//    [view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ( [[obj class] isSubclassOfClass:[UILabel class]] )
//        {
//            [self translateLabel:obj toLanguage:language];
//        }
//        else if ( [[obj class] isSubclassOfClass:[UIControl class]] )
//        {
//            [self translateControl:obj toLanguage:language];
//        }
//        else if ( [[obj class] isSubclassOfClass:[UIView class]] )
//        {
//            [self translateView:obj toLanguage:language];
//        }
//    }];
}

- (void)translateView:(UIView *)view
{
    [self translateView:view toLanguage:self.translationsLanguageCode];
}

- (void)translateView:(UIView *)view onlySubviewsWithTags:(NSArray *)tags toLanguage:(NSString *)language
{
    
}

- (void)translateView:(UIView *)view onlySubviewsWithTags:(NSArray *)tags
{
    
}

@end
