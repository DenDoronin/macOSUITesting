//
//  SSLoginController.m
//  SSUITestSendox
//
//  Created by Doronin Denis on 6/11/17.
//  Copyright © 2017 SS. All rights reserved.
//

#import "SSLoginController.h"
// import constants header
#import "UIAccessibilityIdentifiers.h"

@interface SSLoginController ()

@property (strong) IBOutlet NSTextField *tfLogin;
@property (strong) IBOutlet NSSecureTextField *tfPassword;
@property (strong) IBOutlet NSButton *btnLogin;
@property (strong) IBOutlet NSTextField *lblStatus;

@end

@implementation SSLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAccessibilityIdentifiers];
    [self clearUI];
}

- (void) setupAccessibilityIdentifiers {
    // Set your id's to proper UI elements
    self.tfLogin.accessibilityIdentifier    = SSTextfieldEmail;
    self.tfPassword.accessibilityIdentifier = SSTextfieldPassword;
    self.btnLogin.accessibilityIdentifier   = SSButtonLogin;
    self.lblStatus.accessibilityIdentifier  = SSLabelLoginStatus;
    // That it! nothing more to do with your UI
}

- (void) clearUI {
    [self.tfLogin setStringValue:@""];
    [self.tfPassword setStringValue:@""];
    [self.lblStatus setStringValue:@""];
}

- (IBAction)performClick:(NSButton *)sender {
    
    //very secure check for creddentials:
    if (![self.tfLogin.stringValue isEqualToString:@"login"] ||
        ![self.tfPassword.stringValue isEqualToString:@"password"])
    {
        [self.lblStatus setStringValue:@"Failed to Login"];
        return;
    }
    
    // login segue
    [self clearUI];
    [self performSegueWithIdentifier:@"showMainUISegue" sender:self];
}

@end
