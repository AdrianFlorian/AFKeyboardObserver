//
//  ViewController.h
//  AFKeyboardObserverDemo
//
//  Created by Adrian Florian on 6/8/13.
//  Copyright (c) 2013 Adrian Florian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFKeyboardObserverViewController.h"

@interface ViewController : AFKeyboardObserverViewController

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UITextField *textField;

@end
