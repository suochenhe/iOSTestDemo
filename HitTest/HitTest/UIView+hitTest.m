//
//  UIView+hitTest.m
//  HitTest
//
//  Created by Selen on 2019/4/9.
//  Copyright © 2019 selen. All rights reserved.
//

#import "UIView+hitTest.h"
#import <objc/runtime.h>

@implementation UIView (hitTest)

+ (void)load{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(hitTest:withEvent:)), class_getInstanceMethod(self, @selector(sch_hitTest:withEvent:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pointInside:withEvent:)), class_getInstanceMethod(self, @selector(sch_pointInside:withEvent:)));
}

/**
 - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
 if（View的userInteractionEnabled = NO、hidden = YES、alpha = 0或者 enable = NO(UIButton)）
  hitTest方法会直接返回nil
 else
  内部会调用- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event方法 进行边界判断
 
 传递流程：
  从window开始 对window的子视图进行遍历
    如果触摸点 不在 该视图上（pointInside返回NO），则继续遍历 同一层级的上一个视图
    如果触摸点 在   该视图上（pointInside返回YES），则继续遍历 该视图的子视图
 */
- (UIView *)sch_hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSString *clsName = NSStringFromClass([self class]);
    NSLog(@"%30@ %10@ hitTest_begin",clsName,self.name);
    UIView *view = [self sch_hitTest:point withEvent:event];
    NSLog(@"%30@ %10@ hitTest_end       hitView:%@ %@",clsName,self.name,NSStringFromClass([view class]),view ? @(view.tag): @"") ;
    return view;
}

- (BOOL)sch_pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSString *clsName = NSStringFromClass([self class]);
    NSLog(@"%30@ %10@ pointInside_begin",clsName,self.name);
    BOOL b = [self sch_pointInside:point withEvent:event];
    NSLog(@"%30@ %10@ pointInside_end   pointInside:%@",clsName,self.name,b ? @"YES" : @"NO");
    
    return b;
}
@end
