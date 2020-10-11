//
//  View.h
//  calculator
//
//  Created by 房彤 on 2020/10/2.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface View : UIView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSMutableArray *buttonArray;

- (void)initView;

@end

NS_ASSUME_NONNULL_END
