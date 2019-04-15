//
//  ViewController.m
//  TimerTest
//
//  Created by Selen on 2018/12/16.
//  Copyright © 2018 selen. All rights reserved.
//

#import "ViewController.h"
#import "TimerTestViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button1 = [self createBtnWithFrame:CGRectMake(80, 80, 100, 35) title:@"timerTest" action:@selector(timerTest)];
    [self.view addSubview:button1];
    
    
}


- (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title action:(SEL)action{
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


//当rootViewController为UIViewController presentVc的touchBegan会触发rootViewController的touchBegan
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"%@",[NSRunLoop currentRunLoop]);

}

- (void)timerTest{
    [self pushVC:[TimerTestViewController new]];
}

- (void)pushVC:(UIViewController *)vc{
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end
