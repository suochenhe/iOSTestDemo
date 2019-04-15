//
//  MyProxy.m
//  TimerTest
//
//  Created by Selen on 2018/12/17.
//  Copyright © 2018 selen. All rights reserved.
//

#import "MyProxy.h"
@interface MyProxy ()
@property(nonatomic,weak)id target;

@end

@implementation MyProxy
+ (instancetype)proxyWithTarget:(id)target{
    MyProxy *proxy = [MyProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    [invocation invokeWithTarget:self.target];
}
@end


@interface TimerProxy ()
@property(nonatomic,weak)id target;

@end

@implementation TimerProxy

+ (instancetype)proxyWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}

- (instancetype)initWithTarget:(id)target
{
    self = [super init];
    if (self) {
        self.target = target;
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    return self.target;
}

@end
