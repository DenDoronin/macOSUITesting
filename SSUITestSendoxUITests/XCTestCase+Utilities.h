//
//  XCTestCase+Utilities.h
//  SSUITestSendox
//
//  Created by Doronin Denis on 6/11/17.
//  Copyright © 2017 SS. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (Utilities)

- (XCUIApplication*_Nullable)application;
- (void)setApplication: (XCUIApplication*_Nullable)application;

- (XCUIElement *_Nullable)findElementOfType:(XCUIElementType)type withIndentifier:(nonnull NSString *)indentifier inContainer:(XCUIElement *_Nonnull)containerElement;


- (void)waitForElementAppearance:(nonnull XCUIElement *)targetUIObject
                         timeout:(NSTimeInterval)timeout
                         handler:(nullable XCWaitCompletionHandler)handler;

- (void)waitForElementDisappearance:(nonnull XCUIElement *)targetUIObject
                            timeout:(NSTimeInterval)timeout
                            handler:(nullable XCWaitCompletionHandler)handler;

- (BOOL)isElementShownWithIdentifier:(NSString *_Nonnull)identifier
                              ofType:(XCUIElementType)type
                             timeout:(NSTimeInterval)timeout;
@end
