//
//  TimerTestViewController.m
//  TimerTest
//
//  Created by Selen on 2018/12/16.
//  Copyright © 2018 selen. All rights reserved.
//

#import "TimerTestViewController.h"
#import "MyProxy.h"

@interface TimerTestViewController ()
@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)CADisplayLink *displayLink;
@property(nonatomic,strong)NSTimer *timer0;
@property(nonatomic,strong)NSTimer *timer1;

@property(nonatomic,strong)dispatch_source_t timer;
@end

@implementation TimerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    NSLog(@"----------------");
    __weak typeof(self) weakSelf = self;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0., 0., 100, 100)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(100, 300);
    [self.view addSubview:scrollView];
    
    
//    CADisplayLink 和 NSTimer  会对Target强引用，可能造成循环引用
//    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:[MyProxy proxyWithTarget:self] selector:@selector(displayLinkMethod:)];
//    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//    self.displayLink = displayLink;

    NSTimer *timer0 = [NSTimer scheduledTimerWithTimeInterval:5 target:[TimerProxy proxyWithTarget:self] selector:@selector(timerMethod:) userInfo:nil repeats:YES];
    self.timer0 = timer0;


//    NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval:19966 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [weakSelf weakSelfBlock];
//    }];
//    self.timer1 = timer1;
    
    //GCD的定时器更加准时 不是runloop实现，内核实现
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
//    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
//    dispatch_source_set_timer(timer, start, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
////    dispatch_source_set_event_handler(timer, ^{
////        [weakSelf gcdBlock];
////    });
//    dispatch_source_set_event_handler_f(timer, gcdFun);
//    dispatch_resume(timer);
//    self.timer = timer;
    
}

void gcdFun(){
    NSLog(@"gcdFun");
}

- (void)gcdBlock{
    self.name = @"test";
    NSLog(@"gcdBlock");
}

- (void)weakSelfBlock{
    self.name = @"test";
    NSLog(@"block");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    self.timer = nil;
}

- (void)displayLinkMethod:(id)dd{
    NSLog(@"displayLinkMethod");
}

static NSInteger timerCount = 0;
- (void)timerMethod:(id)dd{
    timerCount++;
    NSLog(@"timerMethod %@",@(timerCount));
}

- (void)dealloc{
    NSLog(@"%s",__func__);
    [self.displayLink invalidate];
    [self.timer0 invalidate];
    [self.timer1 invalidate];
    dispatch_source_cancel(self.timer);
}
@end
