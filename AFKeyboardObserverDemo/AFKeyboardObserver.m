//
//  AFKeyboardViewsAdjuster.m
//  SocialRehub
//
//  Created by Adrian Florian on 6/5/13.
//  Copyright (c) 2013 Adrian Florian. All rights reserved.
//

#import "AFKeyboardObserver.h"

typedef enum {
    kHeight,
    kYPoint
} kAdjustProperty;

@implementation AFKeyboardObserver {
    NSMutableArray *_registeredObservers;
}

static AFKeyboardObserver *_sharedInstance;

+(id)sharedInstance {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        _sharedInstance = [[AFKeyboardObserver alloc] init];
        [_sharedInstance registerForNotifications];
    });
    
    return _sharedInstance;
}

#pragma mark - Register/Unregister for notifications

-(void)registerForKeyboardNotifications:(id<AFKeyboardObserverDelegate>)observer {
    if (![[self registeredObservers] containsObject:observer])
        [[self registeredObservers] addObject:observer];
}

-(void)unregisterObserver:(id)observer {
    [[self registeredObservers] removeObject:observer];
}

-(NSMutableArray *)registeredObservers {
    if (!_registeredObservers)
        _registeredObservers = [NSMutableArray array];
    
    return _registeredObservers;
}

#pragma mark - Keyboard notifications

- (void)keyboardWillShow:(NSNotification *)notification {    
    CGSize keyboardSize =  [self keyboardSizeForNotification:notification];
    [self adjustViewsWithKeyboardHeight: -keyboardSize.height];
    
    for (id<AFKeyboardObserverDelegate> observer in [self registeredObservers]) {
        if ([observer respondsToSelector:@selector(keyboardWillAppear)])
            [observer keyboardWillAppear];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGSize keyboardSize = [self keyboardSizeForNotification:notification];
    [self adjustViewsWithKeyboardHeight: keyboardSize.height];
    
    for (id<AFKeyboardObserverDelegate> observer in [self registeredObservers]) {
        if ([observer respondsToSelector:@selector(keyboardWillDissapear)])
            [observer keyboardWillDissapear];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    for (id<AFKeyboardObserverDelegate> observer in [self registeredObservers]) {
        if ([observer respondsToSelector:@selector(keyboarDidReturn)])
            [observer keyboarDidReturn];
    }
    
    return YES;
}

- (CGSize)keyboardSizeForNotification:(NSNotification *)notification {
    return [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
}

#pragma mark - Helpers

- (void)adjustViewsWithKeyboardHeight:(float)height {
    for (id<AFKeyboardObserverDelegate> observer in [self registeredObservers]) {
        if ([observer respondsToSelector:@selector(viewsToAdjustHeight)]) {
            for (UIView *view in [observer viewsToAdjustHeight]) {
                [self adjustView:view
                      WithHeight:height
                  adjustProperty:kHeight];
            }
        }
        
        if ([observer respondsToSelector:@selector(viewsToAdjustYPosition)]) {
            for (UIView *view in [observer viewsToAdjustYPosition]) {
                [self adjustView:view
                      WithHeight:height
                  adjustProperty:kYPoint];
            }
        }
    }
}

- (void)adjustView:(UIView *)view
        WithHeight:(float)height
    adjustProperty:(kAdjustProperty)property
{
    CGRect viewFrame = view.frame;
    
    switch (property) {
        case kHeight:
            viewFrame.size.height += height;
            break;
        case kYPoint:
            viewFrame.origin.y += height;
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         view.frame = viewFrame;
                     }];
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark - Dealloc

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
