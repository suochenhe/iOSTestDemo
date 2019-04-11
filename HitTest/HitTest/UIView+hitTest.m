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
    printf("%27s [%45s] hitTest_begin\n",clsName.UTF8String,self.name.UTF8String);
    UIView *view = [self sch_hitTest:point withEvent:event];
    printf("%27s [%45s] hitTest_end        hitView:%s[%s]\n",clsName.UTF8String,self.name.UTF8String,NSStringFromClass([view class]).UTF8String,[view.name ? : @"" UTF8String]) ;
    return view;
}

- (BOOL)sch_pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSString *clsName = NSStringFromClass([self class]);
    printf("%27s [%45s] pointInside_begin\n",clsName.UTF8String,self.name.UTF8String);
    BOOL b = [self sch_pointInside:point withEvent:event];
    printf("%27s [%45s] pointInside_end    pointInside:%s\n",clsName.UTF8String,self.name.UTF8String,[b ? @"YES" : @"NO" UTF8String]);
    return b;
}
@end
