//
//  MyProxy.h
//  TimerTest
//
//  Created by Selen on 2018/12/17.
//  Copyright © 2018 selen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;

@end

@interface TimerProxy : NSObject

+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
