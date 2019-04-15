//
//  TestView.h
//  HitTest
//
//  Created by Selen on 2018/12/19.
//  Copyright © 2018 selen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestLabel : UILabel

+ (instancetype)viewWithTag:(NSInteger)tag;

+ (instancetype)viewWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
