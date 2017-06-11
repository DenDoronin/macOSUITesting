//
//  XCTestCase+Tap.m
//  SSUITestSendox
//
//  Created by Doronin Denis on 6/11/17.
//  Copyright © 2017 SS. All rights reserved.
//

#import "XCTestCase+Tap.h"
#import "XCTestCase+Utilities.h"

static const NSTimeInterval NO_TIMEOUT = 0.f;

@implementation XCTestCase (Tap)

- (BOOL)tapOnItemOfType:(XCUIElementType)type withAccessID:(NSString *)accessID
{
    return [self tapOnItemOfType:type
                    withAccessID:accessID
                         timeout:NO_TIMEOUT];
}

- (BOOL)tapOnItemOfType:(XCUIElementType)type withAccessID:(NSString *)accessID timeout:(NSTimeInterval)timeout
{
    NSLog(
          @"%@ - type = %lu, accessID = %@, type = %f",
          NSStringFromSelector(_cmd),
          (unsigned long)type,
          accessID,
          timeout
          );
    
    XCUIElement *element = [self findElementOfType:type
                                   withIndentifier:accessID
                                       inContainer:[self application]];
    
    return [self tapOnElement:element
                      timeout:timeout];
}

- (BOOL)tapOnItemOfType:(XCUIElementType)type containingText:(NSString *)text
{
    return [self tapOnItemOfType:type
                  containingText:text
                         timeout:NO_TIMEOUT];
}

- (BOOL)tapOnItemOfType:(XCUIElementType)type containingText:(NSString *)text timeout:(NSTimeInterval)timeout
{
    NSLog(
          @"%@ - type = %lu, accessID = %@, type = %f",
          NSStringFromSelector(_cmd),
          (unsigned long)type,
          text,
          timeout
          );
    
    XCUIElement *element = [self findElementOfType:type
                                                 withIndentifier:text
                                                     inContainer: [self application]];
    
    return [self tapOnElement:element
                      timeout:timeout];
}


- (BOOL)tapOnElement:(XCUIElement *)element timeout:(NSTimeInterval)timeout
{
    if (element.exists)
    {
        [element click];
        return YES;
    }
    if (timeout > 0)
    {
        NSLog(@"Target element is not on screen. Wait for appearance...");
        [self waitForElementAppearance:element
                               timeout:timeout
                               handler:nil];
        if (element.exists)
        {
            [element click];
            return YES;
        }
    }
    NSLog(@"Target element not found!\nHierarchy: %@", [[self application] debugDescription]);
    return NO;
}

@end
