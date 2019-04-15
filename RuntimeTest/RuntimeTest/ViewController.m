//
//  ViewController.m
//  RuntimeTest
//
//  Created by Selen on 2018/12/7.
//  Copyright © 2018 selen. All rights reserved.
//

#import "ViewController.h"

@interface EXPerson : NSObject
- (void)unrecongnizeMethod;

@end

@implementation EXPerson

+ (BOOL)resolveClassMethod:(SEL)sel{
    return NO;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    return YES;
}


- (id)forwardingTargetForSelector:(SEL)aSelector{
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    //    return [NSMethodSignature methodSignatureForSelector:aSelector];
    
    //    return [NSMethodSignature instanceMethodSignatureForSelector:aSelector];
    return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
}
@end

@interface Person : NSObject
@property(nonatomic,copy)NSString *name;


- (void)unrecongnizeMethod;

- (void)test;
@end

@implementation Person
- (void)test{
    NSLog(@"person test %p",@selector(test));
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
//    return YES;
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
//    return [EXPerson new];//下面不会调用
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
//    return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
//    return [[EXPerson new] methodSignatureForSelector:@selector(unrecongnizeMethod)];
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    [anInvocation invokeWithTarget:[EXPerson new]];
    
}
@end


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [Person new];
    [p test];

    [p unrecongnizeMethod];

}


@end
