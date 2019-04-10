//
//  TestView.m
//  HitTest
//
//  Created by Selen on 2018/12/19.
//  Copyright © 2018 selen. All rights reserved.
//

#import "TestLabel.h"

@interface TestLabel ()

@end

@implementation TestLabel
+ (instancetype)viewWithTag:(NSInteger)tag{
    return [[self alloc] initWithTag:tag];
}

- (instancetype)initWithTag:(NSInteger)tag{
    self =  [super initWithFrame:CGRectZero];
    if (self) {
        self.tag = tag;
        self.name = @(tag).stringValue;
        
        self.text = @(tag).stringValue;
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;

    }
    return self;
}

@end
