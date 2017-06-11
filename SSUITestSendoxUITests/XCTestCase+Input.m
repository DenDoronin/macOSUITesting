//
//  XCTestCase+Input.m
//  SSUITestSendox
//
//  Created by Doronin Denis on 6/11/17.
//  Copyright © 2017 SS. All rights reserved.
//

#import "XCTestCase+Input.h"
#import "XCTestCase+Utilities.h"

static const NSTimeInterval NO_TIMEOUT = 0.f;

@implementation XCTestCase (Input)

#pragma mark - Public Methods

- (BOOL)enterText:(NSString *)text
     inViewOfType:(XCUIElementType)type
     withAccessID:(NSString *)accessID
{
    return [self enterText:text
              inViewOfType:type
              withAccessID:accessID
                   timeout:NO_TIMEOUT];
}



//Helper method to enter text into screen element with specific timeout
- (BOOL)enterText:(NSString *)text
     inViewOfType:(XCUIElementType)type
     withAccessID:(NSString *)accessID
          timeout:(NSTimeInterval)timeout
{
    NSLog(
          @"%@ - text = %@, accessID = %@, type = %lu, timeout = %f",
          NSStringFromSelector(_cmd),
          text,
          accessID,
          (unsigned long)type,
          timeout
          );
    
    BOOL success = NO;
    
    XCUIElement *element = [self findElementOfType:type
                                                 withIndentifier:accessID
                                                     inContainer:[self application]];
    
    success = [self typeInElement:element text:text timeout:timeout];
    
    return success;
}

- (BOOL)enterText:(NSString *)text
     inViewOfType:(XCUIElementType)type
   containingText:(NSString *)staticText
{
    return [self enterText:text inViewOfType:type containingText:text timeout:NO_TIMEOUT];
}

- (BOOL)enterText:(NSString *)text
     inViewOfType:(XCUIElementType)type
   containingText:(NSString *)staticText
          timeout:(NSTimeInterval)timeout
{
    NSLog(
          @"%@ - text = %@, staticText = %@, type = %lu, timeout = %f",
          NSStringFromSelector(_cmd),
          text,
          staticText,
          (unsigned long)type,
          timeout
          );
    
    BOOL success = NO;
    
    XCUIElement *element = [self findElementOfType:type
                                                 withIndentifier:staticText
                                                     inContainer:self.application];
    
    success = [self typeInElement:element text:text timeout:timeout];
    
    return success;
}

#pragma mark - Utilities

- (BOOL)typeInElement:(XCUIElement *)element
                 text:(NSString *)text
              timeout:(NSTimeInterval)timeout
{
    if (element.exists)
    {
        return [self tapAndTypeText:text forElement:element];
    }
    
    if (timeout > 0)
    {
        NSLog(@"Target element is not on screen. Wait for appearance...");
        [self waitForElementAppearance:element
                                               timeout:timeout
                                               handler:nil];
        if (element.exists)
        {
            return [self tapAndTypeText:text forElement:element];
        }
    }
    NSLog(@"Typing in element failed!\nHierarchy: %@", [[self application]  debugDescription]);
    return NO;
}

- (BOOL)tapAndTypeText:(NSString *)text forElement:(XCUIElement *) element
{
    if ([self canTypeInElement:element] && element.exists) {
        // iOS app needs to tap on textfield before entering any information
        [element click];
        [element typeText:text];
        return YES;
    }
    return NO;
}

-(BOOL)canTypeInElement:(XCUIElement *)element
{
    switch (element.elementType) {
        case XCUIElementTypeSearchField:
        case XCUIElementTypeTextField:
        case XCUIElementTypeSecureTextField:
        case XCUIElementTypeTextView:
        case XCUIElementTypeWebView:
            return YES;
            break;
        default:
            return NO;
            break;
    }
}


@end
