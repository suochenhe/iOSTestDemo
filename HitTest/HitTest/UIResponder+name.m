//
//  UIResponder+name.m
//  HitTest
//
//  Created by Selen on 2019/4/9.
//  Copyright © 2019 selen. All rights reserved.
//

#import "UIResponder+name.h"
#import <objc/runtime.h>

@implementation UIResponder (name)
- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//controller.view.name和controller.name相同
//name为空的情况下，name会返回为 控制器name 和 父视图class的拼接
- (NSString *)name{
    NSString *name = objc_getAssociatedObject(self, _cmd);
    NSString *returnName = name;
    if ([self isKindOfClass:[UIViewController class]]) {
        
    }else{
        
        if (returnName.length == 0) {
            UIViewController *viewController = [self viewController];
            if (viewController) {
                returnName = [NSString stringWithFormat:@"vc:%@",viewController.name];
            }
            NSString *superViewName = [self superViewName];
            if (returnName && superViewName) {
                returnName = [NSString stringWithFormat:@"%@ %@",returnName,superViewName];
            }
            
        }
    }
    
    if (returnName == nil) {
        returnName = @"";
    }
    return returnName;
}

- (NSString *)superViewName{
    if ([self isKindOfClass:[UIView class]]) {
        UIView *superView = [(UIView *)self superview];
        return superView ? [NSString stringWithFormat:@"superview:%@",NSStringFromClass([superView class])] : nil;
    }else{
        return nil;
    }
}

- (UIViewController *)viewController{
    if ([self isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)self;
    }
    
    id next = [self nextResponder];
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return next;
        }
        next = [next nextResponder];
    }
    return nil;
}

- (void)logResponderChain{
    NSLog(@"-----------chain-----------");
    UIResponder *next = self;
    while (next) {
        NSLog(@"%@ %@",NSStringFromClass([next class]),next.name);
        next = [next nextResponder];
        
    }
    NSLog(@"---------------------------");
}
@end


@implementation UIViewController (name)
+ (void)load{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(viewWillAppear:)), class_getInstanceMethod(self, @selector(sch_viewWillAppear:)));
}

- (void)sch_viewWillAppear:(BOOL)animated{
    [self sch_viewWillAppear:animated];
    self.view.name = self.name;
}

@end
