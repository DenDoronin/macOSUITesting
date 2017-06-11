//
//  XCTestCase+Input.h
//  SSUITestSendox
//
//  Created by Doronin Denis on 6/11/17.
//  Copyright © 2017 SS. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (Input)

- (BOOL)enterText:(NSString *)text
     inViewOfType:(XCUIElementType)type
     withAccessID:(NSString *)accessID;

- (BOOL)enterText:(NSString *)text
     inViewOfType:(XCUIElementType)type
   containingText:(NSString *)staticText;

@end
