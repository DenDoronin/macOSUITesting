//
//  SSUITestSendoxUITests.m
//  SSUITestSendoxUITests
//
//  Created by Doronin Denis on 6/11/17.
//  Copyright © 2017 SS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestCase+Utilities.h"
#import "XCTestCase+Input.h"
#import "XCTestCase+Tap.h"
// it's important to include identifiers, so we can use it in tests
#import "UIAccessibilityIdentifiers.h"
@interface SSUITestSendoxUITests : XCTestCase

@end

@implementation SSUITestSendoxUITests

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;

    [self setApplication:[[XCUIApplication alloc] init]];
    [[self application] launch];
    
}

- (void)tearDown {
    [super tearDown];
    [[self application] terminate];
}

- (void)testLogin {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCTAssertTrue([self isElementShownWithIdentifier:SSTextfieldEmail ofType:XCUIElementTypeTextField timeout:10.f],@"Textfield has not appeared!");
    
    XCTAssertTrue([self enterText:@"login" inViewOfType:XCUIElementTypeTextField withAccessID:SSTextfieldEmail], @"Faield to enter text!");
    
    XCTAssertTrue([self enterText:@"password" inViewOfType:XCUIElementTypeSecureTextField withAccessID:SSTextfieldPassword], @"Faield to enter password!");
    
    XCTAssertTrue([self tapOnItemOfType:XCUIElementTypeAny withAccessID:SSButtonLogin],@"Failed to tap on login button");
    
    XCUIElement *mainUiWindow = [self findElementOfType:XCUIElementTypeAny withIndentifier:@"Main UI" inContainer:[self application]];
    
    [self waitForElementAppearance:mainUiWindow timeout:10.0 handler:^(NSError * _Nullable error) {
        XCTAssertFalse(error == nil, @"Element hasn't appeared");
    }];
    
    XCUIElement *mainUILabel = [self findElementOfType:XCUIElementTypeAny withIndentifier:@"Amazing!" inContainer:mainUiWindow];
    
    [self waitForElementAppearance:mainUILabel timeout:10.0 handler:^(NSError * _Nullable error) {
            XCTAssertFalse(error == nil, @"Element hasn't appeared");
    }];
    
}

- (void) testLoginNegative {
    XCTAssertTrue([self isElementShownWithIdentifier:SSTextfieldEmail ofType:XCUIElementTypeTextField timeout:10.f],@"Textfield has not appeared!");
    
    XCTAssertTrue([self enterText:@"dummy_login" inViewOfType:XCUIElementTypeTextField withAccessID:SSTextfieldEmail], @"Faield to enter text!");
    
    XCTAssertTrue([self enterText:@"dummy_password" inViewOfType:XCUIElementTypeSecureTextField withAccessID:SSTextfieldPassword], @"Faield to enter password!");
    
    XCTAssertTrue([self tapOnItemOfType:XCUIElementTypeAny withAccessID:SSButtonLogin],@"Failed to tap on login button");
    
    XCUIElement *labelStatus = [self application].staticTexts[@"Failed to Login"];
    
    [self waitForElementAppearance:labelStatus timeout:10.0 handler:^(NSError * _Nullable error) {
        XCTAssertFalse(error == nil, @"Element hasn't appeared");
    }];

}

@end
