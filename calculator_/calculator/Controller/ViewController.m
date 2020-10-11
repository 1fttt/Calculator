//
//  ViewController.m
//  calculator
//
//  Created by 房彤 on 2020/10/2.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    _calculatorView = [[View alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_calculatorView];
    [_calculatorView initView];
    
    for (UIButton *button in self.calculatorView.buttonArray) {
        [button addTarget:self action:@selector(pressNum:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.calculatormodel = [[Model alloc] init];
    _string = [[NSMutableString alloc] init];
    _labelStr = [[NSMutableString alloc] init];
    
    //接收error通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressError) name:@"error" object:nil];
    
    //接收figure通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressFigure:) name:@"figure" object:nil];
    
}

- (void)pressError {
    
    self.calculatorView.label.text = @"error";
    [_string setString:@""];
    [_labelStr setString:@""];
}

- (void)pressFigure:(NSNotification *)noti {
    
    [_string setString:@""];
    [_labelStr setString:@""];
    
    //double 转NSString 且省略小数点后多余的0
    double result = [noti.userInfo[@"result"] doubleValue];
    NSString *resultStr = [NSString stringWithFormat:@"%f", result];
    NSDecimalNumber *str = [NSDecimalNumber decimalNumberWithString:resultStr];
    self.calculatorView.label.text = [str stringValue];
}

- (void)pressNum:(UIButton *)button {
    
    if (button.tag == 0) {
        
        [_string setString:@""];
        [_labelStr setString:@""];
        self.calculatorView.label.text = _labelStr;
    } else if (button.tag == 11) {
        
        [_string appendFormat:@"*"];
        [_labelStr appendFormat:@"%@", button.titleLabel.text];
        self.calculatorView.label.text = _labelStr;
    } else if (button.tag == 15) {
        
        [_string appendFormat:@"/"];
        [_labelStr appendFormat:@"%@", button.titleLabel.text];
        self.calculatorView.label.text = _labelStr;
    } else if (button.tag > 0 && button.tag < 18) {
        
        [_string appendFormat:@"%@", button.titleLabel.text];
        [_labelStr appendFormat:@"%@", button.titleLabel.text];
        self.calculatorView.label.text = _labelStr;
    }  else {
        
        [_string appendFormat:@"="];
        NSLog(@"%@", _string);
        [self.calculatormodel panduan:_string];
    }
    
}

@end
