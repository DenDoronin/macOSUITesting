//
//  XCTestCase+Tap.h
//  SSUITestSendox
//
//  Created by Doronin Denis on 6/11/17.
//  Copyright © 2017 SS. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (Tap)

- (BOOL)tapOnItemOfType:(XCUIElementType)type withAccessID:(NSString *)accessID;

- (BOOL)tapOnItemOfType:(XCUIElementType)type withAccessID:(NSString *)accessID timeout:(NSTimeInterval)timeout;

- (BOOL)tapOnItemOfType:(XCUIElementType)type containingText:(NSString *)text;

- (BOOL)tapOnItemOfType:(XCUIElementType)type containingText:(NSString *)text timeout:(NSTimeInterval)timeout;

@end
