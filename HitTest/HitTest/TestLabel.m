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
    return [[self alloc] initWithName:@(tag).stringValue];
}

+ (instancetype)viewWithName:(NSString *)name{
    return [[self alloc] initWithName:name];
}

- (instancetype)initWithName:(NSString *)name{
    self =  [super initWithFrame:CGRectZero];
    if (self) {
        self.name = name;
        
        self.text = name;
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;

    }
    return self;
}

@end
