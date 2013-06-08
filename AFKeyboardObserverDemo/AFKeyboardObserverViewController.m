//
//  AFKeyboardObserverViewController.m
//  SocialRehub
//
//  Created by Adrian Florian on 6/8/13.
//  Copyright (c) 2013 Adrian Florian. All rights reserved.
//

#import "AFKeyboardObserverViewController.h"

@implementation AFKeyboardObserverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AFKeyboardObserver sharedInstance] registerForKeyboardNotifications:self];
}

- (void)viewDidUnload {
    [[AFKeyboardObserver sharedInstance] unregisterObserver:self];
    [super viewDidUnload];
}

@end
