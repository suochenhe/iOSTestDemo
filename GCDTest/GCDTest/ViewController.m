//
//  ViewController.m
//  GCDTest
//
//  Created by Selen on 2018/11/30.
//  Copyright © 2018 selen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test];
//    [self groupTest1];
    
//    [self sync_async_Test];
    [self applyTest];
    
//    dispatch_queue_t CONCURRENT_queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t SERIAL_queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
//
//
//    //在并发队列中使用aync不会造成死锁
//    //是串行队列中，t向同一个串行队列中添加同步任务，会造成死锁
//    dispatch_async(CONCURRENT_queue, ^{
//        dispatch_sync(CONCURRENT_queue, ^{
//            NSLog(@"0");
//            sleep(1);
//            NSLog(@"1");
//        });
//
//        dispatch_async(CONCURRENT_queue, ^{
//
//            NSLog(@"3");
//        });
//    });
//
//    dispatch_async(SERIAL_queue, ^{
//        dispatch_async(SERIAL_queue, ^{
//            NSLog(@"barrier_1");
//        });
//        dispatch_barrier_async(SERIAL_queue, ^{
//            NSLog(@"barrier_async");
//        });
//
//        dispatch_async(SERIAL_queue, ^{
//            NSLog(@"barrier_3");
//        });
//    });
//
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    dispatch_queue_t CONCURRENT_queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t SERIAL_queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    
//        [self groupTest];
    
//    [self groupEnterLeaveTest];
    
    [self applyTest];
    
    
    NSLog(@"finish touch");
}

- (void)groupTest{
    dispatch_queue_t CONCURRENT_queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t SERIAL_queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = CONCURRENT_queue;
    dispatch_group_t group = dispatch_group_create();
    
    
    for (unsigned int i = 0; i < 5; i++) {
        dispatch_group_async(group, queue, ^{
            NSLog(@"%@ group begin",@(i));
            sleep(i);
            NSLog(@"%@ group end",@(i));
        });
    }
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"dispatch_group_notify");
    });
    
    NSLog(@"开始等待---------------");
    dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)));
    NSLog(@"finish group");
}


//group所传queue是指在queue中执行
- (void)groupTest1{
    dispatch_queue_t CONCURRENT_queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t SERIAL_queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = CONCURRENT_queue;
    dispatch_group_t group = dispatch_group_create();
    
    for (unsigned int i = 0; i < 5; i++) {
        dispatch_group_async(group, CONCURRENT_queue, ^{
            NSLog(@"%@ group1 begin",@(i));
            sleep(i);
            NSLog(@"%@ group1 end",@(i));
        });
    }
    
    
    for (unsigned int i = 0; i < 5; i++) {
        dispatch_group_async(group, SERIAL_queue, ^{
            NSLog(@"%@ group2 begin",@(i));
            sleep(i);
            NSLog(@"%@ group2 end",@(i));
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"dispatch_group_notify_main");
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"dispatch_group_notify_global");
    });
    
    NSLog(@"开始等待---------------");

}


//CONCURRENT_queuequeue dispatch_group_notify 和 finish group 顺序不定
//SERIAL_queue 在enter后会被阻塞 ，在wait过期后 finish group，才会执行leave最后dispatch_group_notify
//dispatch_group_wait 会阻塞当前进程，直到group执行完毕 或 timeout

- (void)groupEnterLeaveTest{
    dispatch_queue_t CONCURRENT_queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t SERIAL_queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = SERIAL_queue;
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_async(queue, ^{
        NSInteger count = 3;
        for (NSInteger i = 0; i < count; i++) {
            NSLog(@"%@ will enter",@(i));
            dispatch_group_enter(group);
            NSLog(@"%@ did enter",@(i));
        }
        
        dispatch_group_notify(group, queue, ^{
            NSLog(@"dispatch_group_notify");
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), queue, ^{
            for (NSInteger i = 0; i < count; i++) {
                NSLog(@"%@ will leave",@(i));
                dispatch_group_leave(group);
                NSLog(@"%@ did leave",@(i));
            }
        });
        
//        for (NSInteger i = 0; i < count; i++) {
//            NSLog(@"%@ will leave",@(i));
//            dispatch_group_leave(group);
//            NSLog(@"%@ did leave",@(i));
//        }
        
        NSLog(@"开始等待---------------");
        
        dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)));
        
        NSLog(@"finish group");
    });
    NSLog(@"finish");
}

//    当queue为并发队列，可能会开启新的线程执行，无序
//    当queue为串行队列，只会在当前线程执行,有序
//只有apply的queue为并发队列，才可能会开启新的线程
//dispatch_apply 是同步方法会阻塞当前线程，所传队列不能是当前串行队列 
- (void)applyTest{
    dispatch_queue_t CONCURRENT_queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t SERIAL_queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = CONCURRENT_queue;

    
    dispatch_apply(100, queue, ^(size_t i) {
        NSLog(@"%@ %@",@(i),[NSThread currentThread]);
    });
    

//    dispatch_async(queue, ^{
//        dispatch_apply(100, queue, ^(size_t i) {
//            NSLog(@"%@ %@",@(i),[NSThread currentThread]);
//        });
//    });
    
    NSLog(@"1------------------------------------------------");
    
    dispatch_async(queue, ^{
        NSLog(@"%@ %@",@"dispatch_async",[NSThread currentThread]);
    });
    NSLog(@"2------------------------------------------------");
}

- (void)barrierTest{
    dispatch_queue_t CONCURRENT_queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t SERIAL_queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    for (NSInteger i = 0; i < 1000; i++) {
        dispatch_async(CONCURRENT_queue, ^{
            NSLog(@"%@",@(i));
        });
    }
    
    dispatch_barrier_sync(CONCURRENT_queue, ^{
        NSLog(@"dispatch_barrier");
    });
    
    NSLog(@"finish");
}


//同步 异步
//同步：在当前线程执行，不具备开启新线程的能力
//异步：在新线程中执行，具备开启新线程的能力
//
//串行 并发
//串行：任务按顺序执行
//并发：多任务（可同时）执行
- (void)sync_async_Test{
    dispatch_queue_t CONCURRENT_queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t SERIAL_queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queue = SERIAL_queue;
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"dispatch_sync1 : %@  %@",@(i),[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"dispatch_sync2 : %@  %@",@(i),[NSThread currentThread]);
        }
    });
    NSLog(@"------------");
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"dispatch_async1 : %@  %@",@(i),[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"dispatch_async2 : %@  %@",@(i),[NSThread currentThread]);
        }
    });
}

- (void)test{
    dispatch_queue_t CONCURRENT_queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t SERIAL_queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queue = SERIAL_queue;
    
    NSLog(@"1");
    [self performSelector:@selector(log) withObject:nil afterDelay:0.0];
    NSLog(@"3");
    
    
    dispatch_async(queue, ^{

        NSLog(@"dispatch_async 1");
      
//        [self runloop]; //卡住
//        [[NSRunLoop currentRunLoop] run];//如果__CFRunLoopModeIsEmpty,没有source/observer/timer 就会结束循环
        
        [self performSelector:@selector(dispatch_async_log) withObject:nil afterDelay:0.0];
        
//        [self runloop];//卡住
        [[NSRunLoop currentRunLoop] run];//runloop中已经添加了timmer，执行完timers，runloop为空，会结束循环
        
        NSLog(@"dispatch_async 3");
        
    });
    
}

- (void)runloop{
        [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
}

- (void)log{
    NSLog(@"2");
}

- (void)dispatch_async_log{
    NSLog(@"dispatch_async 2");
}

@end
