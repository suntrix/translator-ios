//
//  TranslationsViewController.m
//  Translator
//
//  Created by Sebastian Owodziń on 8/19/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "TranslationsViewController.h"

#import "WDSTranslator.h"
#import "WDSTranslatorUIKitAddons.h"

@interface TranslationsViewController ()

@end

@implementation TranslationsViewController

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WDSTranslator *translator = [WDSTranslator sharedObject];
    
    switch (self.mode) {
        case TranslationsViewControllerModeSeparated:
        {
            [translator translateLabel:self.translatedLabel];
            [translator translateButton:self.translatedButton];
            [translator translateTextField:self.translatedTextField];
            [translator translateTextView:self.translatedTextView];
        }
            break;

        case TranslationsViewControllerModeFullView:
            [translator translateView:self.view];
            break;
            
        case TranslationsViewControllerModeFullViewTagsOnly:
            [translator translateView:self.view onlySubviewsWithTags:@[@11, @12]];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
