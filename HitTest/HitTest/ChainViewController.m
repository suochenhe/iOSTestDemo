//
//  ViewController.m
//  HitTest
//
//  Created by Selen on 2018/12/19.
//  Copyright © 2018 selen. All rights reserved.
//

#import "ChainViewController.h"


@interface ChainViewController ()

@end

@implementation ChainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"响应者链Test";
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 100;
    frame.size.height -= 200;
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    contentView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:contentView];
    
    UIButton *btn1 = [self buttonWithFrame:CGRectMake(10, 10, 200, 30) title:@"pushVC" tag:0];
    [contentView addSubview:btn1];
    
    UIButton *btn2 = [self buttonWithFrame:CGRectMake(10, 60, 200, 30) title:@"presentVC" tag:1];
    [contentView addSubview:btn2];
    
    UIButton *btn3 = [self buttonWithFrame:CGRectMake(10, 110, 200, 30) title:@"logResponseChain" tag:2];
    [contentView addSubview:btn3];
    
    UIButton *btn4 = [self buttonWithFrame:CGRectMake(10, 250, 200, 30) title:@"presentback" tag:3];
    [contentView addSubview:btn4];
    
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
        case 0:{
            ChainViewController *vc = [ChainViewController new];
            vc.name = @"pushVc";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            ChainViewController *vc = [ChainViewController new];
            vc.name = @"presentVc";
            NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
            nav.name = @"presentNav";
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 2:{
            [sender logResponderChain];
        }
            break;
        case 3:{
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
