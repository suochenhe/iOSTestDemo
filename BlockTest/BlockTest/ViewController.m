//
//  ViewController.m
//  BlockTest
//
//  Created by Selen on 2018/12/4.
//  Copyright © 2018 selen. All rights reserved.
//

#import "ViewController.h"

//xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-12.0.0  viewController.m -o viewController.cpp
@interface ViewController ()

@end

int num1 = 1;

typedef void(^Myblock)(void);

@implementation ViewController

- (void)test{
    static int num2 = 2;
    int num3 = 3;//auto
    __block int num4 = 4;
    
    NSObject *obj = [NSObject new];
    __block NSObject *obj1 = [NSObject new];
    
    __block id blockSelf = self;
    __weak  id weakSelf = self;
    
    Myblock block = ^() {
        num1; num2; num3; num4;
        
        NSLog(@"num1: %@, num2: %@,num3: %@,num4: %@",@(num1),@(num2),@(num3),@(num4));
        
        obj;
        obj1 = [NSObject new];
        
        self;
        blockSelf;
        weakSelf;
    };
    
    num1 = 21;
    num2 = 22;
    num3 = 23;
    num4 = 24;
    
    block();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}


struct __Block_byref_num4_0 {
    void *__isa;
    struct __Block_byref_num4_0 *__forwarding;
    int __flags;
    int __size;
    int num4;
};
struct __Block_byref_obj1_1 {
    void *__isa;
    struct __Block_byref_obj1_1 *__forwarding;
    int __flags;
    int __size;
    void (*__Block_byref_id_object_copy)(void*, void*);
    void (*__Block_byref_id_object_dispose)(void*);
    NSObject *__strong obj1;
};
struct __Block_byref_blockSelf_2 {
    void *__isa;
    struct __Block_byref_blockSelf_2 *__forwarding;
    int __flags;
    int __size;
    void (*__Block_byref_id_object_copy)(void*, void*);
    void (*__Block_byref_id_object_dispose)(void*);
    __strong id blockSelf;
};

@end
