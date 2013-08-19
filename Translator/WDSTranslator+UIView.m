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
    [view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ( [obj class] == [UIView class] )
        {
            [self translateView:obj toLanguage:language];
        }
        else
        {
            if ( [[obj class] isSubclassOfClass:[UILabel class]] )
            {
                [self translateLabel:obj toLanguage:language];
            }
            else if ( [[obj class] isSubclassOfClass:[UIButton class]] )
            {
                [self translateButton:obj toLanguage:language];
            }
            else if ( [[obj class] isSubclassOfClass:[UITextField class]] )
            {
                [self translateTextField:obj toLanguage:language];
            }
            else if ( [[obj class] isSubclassOfClass:[UITextView class]] )
            {
                [self translateTextView:obj toLanguage:language];
            }
        }
    }];
}

- (void)translateView:(UIView *)view
{
    [self translateView:view toLanguage:self.translationsLanguageCode];
}

- (void)translateView:(UIView *)view onlySubviewsWithTags:(NSArray *)tags toLanguage:(NSString *)language
{
    [view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ( [obj class] == [UIView class] )
        {
            [self translateView:obj onlySubviewsWithTags:tags toLanguage:language];
        }
        else
        {
            UIView *viewObject = (UIView *)obj;
            if ( [tags containsObject:[NSNumber numberWithInteger:viewObject.tag]] )
            {
                if ( [[obj class] isSubclassOfClass:[UILabel class]] )
                {
                    [self translateLabel:obj toLanguage:language];
                }
                else if ( [[obj class] isSubclassOfClass:[UIButton class]] )
                {
                    [self translateButton:obj toLanguage:language];
                }
                else if ( [[obj class] isSubclassOfClass:[UITextField class]] )
                {
                    [self translateTextField:obj toLanguage:language];
                }
                else if ( [[obj class] isSubclassOfClass:[UITextView class]] )
                {
                    [self translateTextView:obj toLanguage:language];
                }
            }
        }
    }];
}

- (void)translateView:(UIView *)view onlySubviewsWithTags:(NSArray *)tags
{
    [self translateView:view onlySubviewsWithTags:tags toLanguage:self.translationsLanguageCode];
}

@end
