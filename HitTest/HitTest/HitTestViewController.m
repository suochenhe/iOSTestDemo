//
//  TestViewController.m
//  HitTest
//
//  Created by Selen on 2019/4/9.
//  Copyright © 2019 selen. All rights reserved.
//

#import "HitTestViewController.h"
#import "TestLabel.h"

@interface HitTestViewController ()

@end

@implementation HitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"触摸传递Test";
    
    TestLabel *view1 = [TestLabel viewWithTag:1];
    view1.backgroundColor = [UIColor orangeColor];
    view1.frame = CGRectMake(10, 100, 300, 200);
    [self.view addSubview:view1];
    
    TestLabel *view11 = [TestLabel viewWithTag:11];
    view11.backgroundColor = [UIColor redColor];
    view11.frame = CGRectMake(10, 10, 100, 80);
    [view1 addSubview:view11];
    
    TestLabel *view12 = [TestLabel viewWithTag:12];
    view12.backgroundColor = [UIColor yellowColor];
    view12.frame = CGRectMake(150, 20, 100, 50);
    [view1 addSubview:view12];
    
    TestLabel *view13 = [TestLabel viewWithTag:13];
    view13.backgroundColor = [UIColor greenColor];
    view13.frame = CGRectMake(10, 110, 100, 80);
    [view1 addSubview:view13];
    
    TestLabel *view14 = [TestLabel viewWithTag:14];
    view14.backgroundColor = [UIColor blueColor];
    view14.frame = CGRectMake(260, 80, 100, 100);
    view14.layer.cornerRadius = 50.f;
    view14.layer.masksToBounds = YES;
    [view1 addSubview:view14];
    
    TestLabel *view2 = [TestLabel viewWithTag:2];
    view2.backgroundColor = [UIColor orangeColor];
    view2.frame = CGRectMake(10, 330, 300, 200);
    [self.view addSubview:view2];
    
    TestLabel *view21 = [TestLabel viewWithTag:21];
    view21.backgroundColor = [UIColor redColor];
    view21.frame = CGRectMake(10, 10, 100, 80);
    [view2 addSubview:view21];
    
    TestLabel *view22 = [TestLabel viewWithTag:22];
    view22.userInteractionEnabled = NO;
    view22.backgroundColor = [UIColor yellowColor];
    view22.frame = CGRectMake(150, 20, 100, 50);
    [view2 addSubview:view22];
    
    TestLabel *view23 = [TestLabel viewWithTag:23];
    view23.hidden = YES;
    view23.backgroundColor = [UIColor greenColor];
    view23.frame = CGRectMake(10, 110, 100, 80);
    [view2 addSubview:view23];
    
    TestLabel *view24 = [TestLabel viewWithTag:24];
    view24.alpha = 0.f;
    view24.backgroundColor = [UIColor blueColor];
    view24.frame = CGRectMake(260, 80, 100, 100);
    view24.layer.cornerRadius = 50.f;
    view24.layer.masksToBounds = YES;
    [view2 addSubview:view24];
    
    
}

@end
