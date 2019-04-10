//
//  UIResponder+name.h
//  HitTest
//
//  Created by Selen on 2019/4/9.
//  Copyright © 2019 selen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (name)
/**扩展属性 方便log中Responder的识别*/
@property(nonatomic,copy)NSString *name;

- (UIViewController *)viewController;
- (void)logResponderChain;
@end

NS_ASSUME_NONNULL_END
