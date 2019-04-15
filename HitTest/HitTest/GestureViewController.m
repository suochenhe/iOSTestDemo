//
//  GestureViewController.m
//  HitTest
//
//  Created by Selen on 2019/4/15.
//  Copyright © 2019 selen. All rights reserved.
//

#import "GestureViewController.h"
#import "TestLabel.h"
#import "TestControl.h"

@interface GestureViewController ()

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势Test";
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 100;
    frame.size.height -= 200;
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    contentView.name = @"bgView";
    contentView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:contentView];
    
    [self view:contentView addGestureWithName:@"bgViewGesture"];
    
    
    TestLabel *label = [TestLabel viewWithName:@"label"];
    label.backgroundColor = [UIColor redColor];
    label.frame = CGRectMake(10, 100, 100, 50);
    [contentView addSubview:label];
    
    TestLabel *label1 = [TestLabel viewWithName:@"label1"];
    label1.backgroundColor = [UIColor redColor];
    label1.frame = CGRectMake(140, 100, 100, 50);
    [contentView addSubview:label1];
    [self view:label1 addGestureWithName:@"label1Gesture"];
    
    UIButton *btn = [self buttonWithFrame:CGRectMake(10, 200, 100, 50) title:@"button"];
    btn.backgroundColor = [UIColor yellowColor];
    [contentView addSubview:btn];
    
    UIButton *btn1 = [self buttonWithFrame:CGRectMake(140, 200, 100, 50) title:@"button1"];
    btn1.backgroundColor = [UIColor yellowColor];
    [contentView addSubview:btn1];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [self buttonWithFrame:CGRectMake(270, 200, 100, 50) title:@"button2"];
    btn2.backgroundColor = [UIColor yellowColor];
    [contentView addSubview:btn2];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self view:btn2 addGestureWithName:@"button2Gesture"];
    
    UIControl *control = [UIControl new];
    control.name = @"control";
    control.frame = CGRectMake(10, 300, 100, 50);
    control.backgroundColor = [UIColor blueColor];
    [contentView addSubview:control];
    
    TestControl *control1 = [TestControl new];
    control1.name = @"control1";
    control1.frame = CGRectMake(140, 300, 100, 50);
    control1.backgroundColor = [UIColor blueColor];
    [contentView addSubview:control1];
    [self view:control1 addGestureWithName:@"control1Gesture"];
    
}

- (void)view:(UIView *)view addGestureWithName:(NSString *)gestureName{
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestrue:)];
    gesture.name = gestureName;
    gesture.cancelsTouchesInView = YES;//默认YES，手势响应后，cancel touch事件
    gesture.delaysTouchesBegan = NO;   //默认NO，并行手势分析和view的touchBegan同时进行，识别后view的touchCancel 未识别 view 处理；YES 手势识别器，识别触摸对象后，处理触摸对象，不能识别，交给view的touchBegan  在手势响应识别之后，再开始touchBegan
    gesture.delaysTouchesEnded = YES;  //默认YES，分析手势没有识别，将触摸对象交给View处理
    [view addGestureRecognizer:gesture];
}

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.name = title;
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return btn;
}

- (void)tapGestrue:(UITapGestureRecognizer *)recognizer{
    UIView *view = recognizer.view;
    printf("%27s [%45s] tapGestrue\n",NSStringFromClass([view class]).UTF8String,view.name.UTF8String);
}

- (void)btnClick:(UIButton *)sender{
    UIView *view = sender;
    printf("%27s [%45s] btnClick\n",NSStringFromClass([view class]).UTF8String,view.name.UTF8String);
}

@end
