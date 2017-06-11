//
//  ViewController.m
//  SSUITestSendox
//
//  Created by Doronin Denis on 6/11/17.
//  Copyright © 2017 SS. All rights reserved.
//

#import "ViewController.h"
// import constants header
#import "UIAccessibilityIdentifiers.h"

@interface ViewController()
@property (strong) IBOutlet NSTextField *tfLogin;
@property (strong) IBOutlet NSTextField *tfPassword;
@property (strong) IBOutlet NSButton *btnLogin;
@property (strong) IBOutlet NSTextField *lblStatus;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAccessibilityIdentifiers];
}

- (void) setupAccessibilityIdentifiers {
    // Set your id's to proper UI elements
    self.tfLogin.accessibilityIdentifier    = SSTextfieldEmail;
    self.tfPassword.accessibilityIdentifier = SSTextfieldPassword;
    self.btnLogin.accessibilityIdentifier   = SSButtonLogin;
    self.lblStatus.accessibilityIdentifier  = SSLabelLoginStatus;
    // That it! nothing more to do with your UI
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
