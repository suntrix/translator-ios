//
//  SeparateTranslationsViewController.m
//  Translator
//
//  Created by Jacek Wierzbicki-Woś on 16/07/2013.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "SeparateTranslationsViewController.h"

#import "WDSTranslator.h"
#import "WDSTranslatorUIAddons.h"

@interface SeparateTranslationsViewController ()

@end

@implementation SeparateTranslationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
	// Do any additional setup after loading the view.
    
    WDSTranslator *translator = [WDSTranslator sharedObject];
    [translator translateLabel:self.translatedLabel];
    [translator translateButton:self.translatedButton];
    [translator translateTextField:self.translatedTextField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
