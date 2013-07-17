//
//  ExampleViewController.m
//  Translator
//
//  Created by Jacek Wierzbicki-Woś on 16/07/2013.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "ExampleViewController.h"

#import "WDSTranslator.h"
#import "WDSTranslator+UILabel.h"
#import "WDSTranslator+UIButton.h"
#import "WDSTranslator+UITextField.h"

@interface ExampleViewController ()

@end

@implementation ExampleViewController

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
