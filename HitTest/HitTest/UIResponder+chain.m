//
//  UIResponder+chain.m
//  HitTest
//
//  Created by Selen on 2019/4/9.
//  Copyright © 2019 selen. All rights reserved.
//

#import "UIResponder+chain.h"
#import <objc/runtime.h>

@implementation UIResponder (chain)
+ (void)load{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(touchesBegan:withEvent:)), class_getInstanceMethod(self, @selector(sch_touchesBegan:withEvent:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(touchesEnded:withEvent:)), class_getInstanceMethod(self, @selector(sch_touchesEnded:withEvent:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(touchesMoved:withEvent:)), class_getInstanceMethod(self, @selector(sch_touchesMoved:withEvent:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(touchesCancelled:withEvent:)), class_getInstanceMethod(self, @selector(sch_touchesCancelled:withEvent:)));
    
}

- (void)sch_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%30@ %@ touchesBegan1",self.name,NSStringFromClass([self class]));
    [self sch_touchesBegan:touches withEvent:event];
    NSLog(@"%30@ %@ touchesBegan2",self.name,NSStringFromClass([self class]));
}

- (void)sch_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%30@ %@ touchesEnded1",self.name,NSStringFromClass([self class]));
    [self sch_touchesEnded:touches withEvent:event];
    NSLog(@"%30@ %@ touchesEnded2",self.name,NSStringFromClass([self class]));
}

- (void)sch_touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%30@ %@ touchesMoved1",self.name,NSStringFromClass([self class]));
    [self sch_touchesMoved:touches withEvent:event];
    NSLog(@"%30@ %@ touchesMoved2",self.name,NSStringFromClass([self class]));
}

- (void)sch_touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%30@ %@ touchesCancelled1",self.name,NSStringFromClass([self class]));
    [self sch_touchesCancelled:touches withEvent:event];
    NSLog(@"%30@ %@ touchesCancelled2",self.name,NSStringFromClass([self class]));
}


@end

@implementation UIView (chain)
+ (void)load{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(touchesBegan:withEvent:)), class_getInstanceMethod(self, @selector(sch1_touchesBegan:withEvent:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(touchesEnded:withEvent:)), class_getInstanceMethod(self, @selector(sch1_touchesEnded:withEvent:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(touchesMoved:withEvent:)), class_getInstanceMethod(self, @selector(sch1_touchesMoved:withEvent:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(touchesCancelled:withEvent:)), class_getInstanceMethod(self, @selector(sch1_touchesCancelled:withEvent:)));
    
}

- (void)sch1_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%30@ %@ touchesBegan1",self.name,NSStringFromClass([self class]));
    [self sch1_touchesBegan:touches withEvent:event];
    NSLog(@"%30@ %@ touchesBegan2",self.name,NSStringFromClass([self class]));
}

- (void)sch1_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%30@ %@ touchesEnded1",self.name,NSStringFromClass([self class]));
    [self sch1_touchesEnded:touches withEvent:event];
    NSLog(@"%30@ %@ touchesEnded2",self.name,NSStringFromClass([self class]));
}

- (void)sch1_touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%30@ %@ touchesMoved1",self.name,NSStringFromClass([self class]));
    [self sch1_touchesMoved:touches withEvent:event];
    NSLog(@"%30@ %@ touchesMoved2",self.name,NSStringFromClass([self class]));
}

- (void)sch1_touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%30@ %@ touchesCancelled1",self.name,NSStringFromClass([self class]));
    [self sch1_touchesCancelled:touches withEvent:event];
    NSLog(@"%30@ %@ touchesCancelled2",self.name,NSStringFromClass([self class]));
}


@end

