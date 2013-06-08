//
//  ViewController.m
//  AFKeyboardObserverDemo
//
//  Created by Adrian Florian on 6/8/13.
//  Copyright (c) 2013 Adrian Florian. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

//
-(NSArray *)viewsToAdjustHeight {
    return @[self.mainView];
}

-(NSArray *)viewsToAdjustYPosition {
    return @[self.textField];
}

-(void)keyboardWillAppear {
    // do additional setup
}

-(void)keyboardWillDissapear {
    // do additional setup
}

-(void)keyboarDidReturn {
    // do additional setup
}

@end
