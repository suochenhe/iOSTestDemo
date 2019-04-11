//
//  ViewController.m
//  HitTest
//
//  Created by Selen on 2018/12/19.
//  Copyright © 2018 selen. All rights reserved.
//

#import "ChainViewController.h"


@interface ChainViewController ()
@property(nonatomic,weak)UIViewController *childVC;

@end

@implementation ChainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"响应者链Test";
    
    UIViewController *childVC = [UIViewController new];
    childVC.name = @"childVC";
    [self addChildViewController:childVC];
    _childVC = childVC;
    childVC.view.frame = CGRectMake(0.f, 100.f, 100.f, 80.f);
    childVC.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:childVC.view];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 200;
    frame.size.height -= 300;
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    contentView.name = @"bgView";
    contentView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:contentView];
    
    UIButton *btn1 = [self buttonWithFrame:CGRectMake(10, 10, 300, 30) title:@"pushVC" tag:1];
    [contentView addSubview:btn1];
    
    UIButton *btn2 = [self buttonWithFrame:CGRectMake(10, 60, 300, 30) title:@"presentVC" tag:2];
    [contentView addSubview:btn2];
    
    //btn3的响应链
    UIButton *btn3 = [self buttonWithFrame:CGRectMake(10, 110, 300, 30) title:@"logResponseChain" tag:3];
    [contentView addSubview:btn3];
    
    //ChildVc.view的响应链
    UIButton *btn4 = [self buttonWithFrame:CGRectMake(10, 160, 300, 30) title:@"logChildVcViewResponseChain" tag:4];
    [contentView addSubview:btn4];
    
    UIButton *btn5 = [self buttonWithFrame:CGRectMake(10, 250, 200, 30) title:@"presentback" tag:5];
    [contentView addSubview:btn5];
    
}

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.tag = tag;
    btn.name = title;
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:{
            ChainViewController *vc = [ChainViewController new];
            vc.name = @"pushVc";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            ChainViewController *vc = [ChainViewController new];
            vc.name = @"presentVc";
            NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
            nav.name = @"presentNav";
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 3:{
            [sender logResponderChain];
        }
            break;
        case 4:{
            [self.childVC.view logResponderChain];
        }
            break;
        case 5:{
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
            break;
            
        default:
            break;
    }
}
@end
