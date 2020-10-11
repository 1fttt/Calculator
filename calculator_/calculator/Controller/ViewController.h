//
//  ViewController.h
//  calculator
//
//  Created by 房彤 on 2020/10/2.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"
#import "Model.h"


NS_ASSUME_NONNULL_BEGIN

@interface ViewController : UIViewController

@property (nonatomic, strong) NSMutableString *string;
@property (nonatomic, strong) NSMutableString *labelStr;

@property (nonatomic, strong) View *calculatorView;
@property (nonatomic, strong) Model *calculatormodel;

@end

NS_ASSUME_NONNULL_END
