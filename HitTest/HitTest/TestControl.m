//
//  TestControl.m
//  HitTest
//
//  Created by Selen on 2019/4/15.
//  Copyright © 2019 selen. All rights reserved.
//

#import "TestControl.h"

@implementation TestControl



- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    return NO;
    if (gestureRecognizer.view != self) {
        return NO;
    }
    return YES;
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;

@end
