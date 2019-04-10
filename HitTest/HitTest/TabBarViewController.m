//
//  TabBarViewController.m
//  HitTest
//
//  Created by Selen on 2019/4/9.
//  Copyright © 2019 selen. All rights reserved.
//

#import "TabBarViewController.h"
#import "ChainViewController.h"
#import "NavigationController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *classArray = @[@"HitTestViewController",@"ChainViewController"];
    NSArray *titleArray = @[@"事件传递",@"响应者链"];
    for (NSInteger i = 0; i < titleArray.count; i ++){
        [self createTabBarViewControllerWithTitle:titleArray[i] class:classArray[i] index:i];
    }
}

/**
 初始化tabBar的子控制器
 */
- (void)createTabBarViewControllerWithTitle:(NSString *)title class:(NSString *)class index:(NSInteger)index{
    UIViewController *viewController = [NSClassFromString(class) new];
    viewController.name = [NSString stringWithFormat:@"vc%@",@(index)];
    
    NavigationController *navController = [[NavigationController alloc]initWithRootViewController:viewController];
    navController.name = [NSString stringWithFormat:@"nav%@",@(index)];
    
    UITabBarItem *tabBarItem = navController.tabBarItem;
    tabBarItem.title = title;
    [self addChildViewController:navController];
}


@end
