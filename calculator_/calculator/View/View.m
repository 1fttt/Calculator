//
//  View.m
//  calculator
//
//  Created by 房彤 on 2020/10/2.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "View.h"
#import "Masonry.h"
#define W self.bounds.size.width
#define H self.bounds.size.height

@implementation View

- (void)initView {
    
    _label = [[UILabel alloc] init];
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_top).offset(H / 119.467 * 45.467 - 17);
        make.height.mas_offset(H / 119.467 * 15.333);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_offset(W - (W - H / 119.467 * 11.6 * 4) / 5 * 2 );

    }];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:H / 119.467 * 11.6 * 0.89];
    _label.textAlignment = NSTextAlignmentRight;
    
    NSArray *arr = @[@"AC", @"(", @")", @"+", @"1", @"2", @"3", @"-", @"4", @"5", @"6", @"×", @"7", @"8", @"9", @"÷", @"0", @".", @"="];
    int k = 0;
    
    //按钮
    _buttonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 4; j++) {
            if (i == 4 && j == 1) {
                continue;
            }
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [self addSubview:button];
            button.layer.cornerRadius = H / 119.467 * 11.6 / 2;
            button.tag = k;
            NSString *str = arr[k++];
            [button setTitle:str forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:H / 119.467 * 11.6 * 0.45];
            
            //颜色
            if (i == 0 && j < 3) {
                button.backgroundColor = [UIColor colorWithRed:166 / 255.0 green:165 / 255.0 blue:165 / 255.0 alpha:1];
                button.tintColor = [UIColor blackColor];
                button.titleLabel.font = [UIFont systemFontOfSize:H / 119.467 * 11.6 * 0.42];
                
            } else if (j == 3) {
                button.backgroundColor = [UIColor colorWithRed:255 /255.0 green:158 / 255.0 blue:43 / 255.0 alpha:1];
                button.tintColor = [UIColor whiteColor];
                
            } else {
                button.backgroundColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
                button.tintColor = [UIColor whiteColor];
                
            }
            
            //位置
            if(i == 4 && j == 0) {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset((W - (H / 119.467 * 11.6 * 4)) / 5);
                    make.top.equalTo(self.mas_top).offset(H / 119.467 * 45.467 + H / 119.467 * 13.27 * i);
                    make.width.mas_offset((W - (H / 119.467 * 11.6 * 4)) / 5 + H / 119.467 * 11.6 * 2);
                    make.height.mas_offset(H / 119.467 * 11.6);
                }];
                
            } else {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset((W - (H / 119.467 * 11.6 * 4)) / 5 + ((H / 119.467 * 11.6) + (W - H / 119.467 * 11.6 * 4) / 5) * j);
                    make.top.equalTo(self.mas_top).offset(H / 119.467 * 45.467 + H / 119.467 * 13.27 * i);
                    make.width.mas_offset(H / 119.467 * 11.6);
                    make.height.mas_offset(H / 119.467 * 11.6);
                }];
                
            }
            [_buttonArray addObject:button];
        
        }
       
    }
    
    return;
}

@end
