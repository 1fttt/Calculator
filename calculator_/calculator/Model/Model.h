//
//  Model.h
//  calculator
//
//  Created by 房彤 on 2020/10/2.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject

@property (nonatomic, strong) NSMutableString *str;

- (void)panduan:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
