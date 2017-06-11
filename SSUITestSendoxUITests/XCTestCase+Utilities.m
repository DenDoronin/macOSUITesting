//
//  XCTestCase+Utilities.m
//  SSUITestSendox
//
//  Created by Doronin Denis on 6/11/17.
//  Copyright © 2017 SS. All rights reserved.
//

#import "XCTestCase+Utilities.h"
@import ObjectiveC.runtime;

@implementation XCTestCase (Utilities)

- (XCUIApplication*_Nullable)application {
    return objc_getAssociatedObject(self, @selector(application));
}

- (void)setApplication: (XCUIApplication*_Nullable)application {
    objc_setAssociatedObject(self, @selector(application), application, OBJC_ASSOCIATION_RETAIN);
}

- (XCUIElement *_Nullable)findElementOfType:(XCUIElementType)type withIndentifier:(nonnull NSString *)indentifier inContainer:(XCUIElement *_Nonnull)containerElement
{
    NSLog(@"%@ - type = %lu, indentifier = %@", NSStringFromSelector(_cmd), (unsigned long)type, indentifier);
    
    NSAssert(indentifier, @"%@ : Identifier parameter cannot be nil", NSStringFromSelector(_cmd));
    
    return [[containerElement descendantsMatchingType:type] objectForKeyedSubscript:indentifier];
}

- (void)waitForElementAppearance:(nonnull XCUIElement *)targetUIObject
                         timeout:(NSTimeInterval)timeout
                         handler:(nullable XCWaitCompletionHandler)handler
{
    [self waitForElement:targetUIObject
      elementShouldExist:YES
                 timeout:timeout
                 handler:handler];
}

- (void)waitForElementDisappearance:(nonnull XCUIElement *)targetUIObject
                            timeout:(NSTimeInterval)timeout
                            handler:(nullable XCWaitCompletionHandler)handler
{
    [self waitForElement:targetUIObject
      elementShouldExist:NO
                 timeout:timeout
                 handler:handler];
}

- (void)waitForElement:(nonnull XCUIElement *)targetUIObject
    elementShouldExist:(BOOL)exists
               timeout:(NSTimeInterval)timeout
               handler:(nullable XCWaitCompletionHandler)handler
{
    NSAssert(targetUIObject, @"Method expects non-null XCUIElement for expectation evaluation");
    
    if (targetUIObject.exists == exists)
    {
        // element exist, no need to wait
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"exists == %d", exists];
    
    NSLog(@"Creating expectation using predicate: %@", predicate.description);
    // perform async loop, waiting for the object specified to appear
    XCTestExpectation *te = [self expectationForPredicate:predicate
                                      evaluatedWithObject:targetUIObject
                                                  handler:nil];
    
    [self waitForExpectation:te
                 withTimeout:timeout
                     handler:handler];
}

- (void)waitForExpectation:(XCTestExpectation *)expectation
               withTimeout:(NSTimeInterval)timeout
                   handler:(nullable XCWaitCompletionHandler)handler
{
    NSLog(@"%@ - timeout = %f,", NSStringFromSelector(_cmd), timeout);
    
    // wait no longer than 'timeout + 1' seconds for the request to go through
    [self waitForExpectationsWithTimeout:timeout+1 handler:^(NSError *error) {
        
        // remove expectation only if its inside expectations array
        if (error) {
            NSLog(@"expectation failed");
        }
        
        if (handler)
            handler(error);
    }];
}


- (BOOL)isElementShownWithIdentifier:(NSString *_Nonnull)identifier
                              ofType:(XCUIElementType)type
                             timeout:(NSTimeInterval)timeout
{
    NSLog(
          @"%@ - identifier = %@, type = %lu, timeout = %f",
          NSStringFromSelector(_cmd),
          identifier,
          (unsigned long)type,
          timeout
          );
    
    XCUIElement *targetUIObject = [self findElementOfType:type
                                          withIndentifier:identifier
                                              inContainer:[self application]];
    
    if (targetUIObject.exists)
    {
        return YES;
    }
    
    if (timeout > 0)
    {
        NSLog(@"Target element is not on screen. Wait for appearance...");
        [self waitForElementAppearance:targetUIObject
                               timeout:timeout
                               handler:nil];
    }
    
    return targetUIObject.exists;
}

@end
