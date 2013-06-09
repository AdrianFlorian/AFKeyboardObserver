//
//  AFKeyboardViewsAdjuster.h
//
//  Created by Adrian Florian on 6/5/13.
//  Copyright (c) 2013 Adrian Florian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AFKeyboardObserverDelegate<NSObject>

@optional
-(NSArray *)viewsToAdjustHeight;
-(NSArray *)viewsToAdjustYPosition;
-(void)keyboardWillAppear;
-(void)keyboardWillDissapear;

@end

@interface AFKeyboardObserver : NSObject

+(id)sharedInstance;

-(void)registerForKeyboardNotifications:(id<AFKeyboardObserverDelegate>)observer;
-(void)unregisterObserver:(id)observer;

@end
