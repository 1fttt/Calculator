//
//  Model.m
//  calculator
//
//  Created by 房彤 on 2020/10/2.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "Model.h"
#include <stdlib.h>
#define M 100

typedef struct numStack {
    double data[M];
    int top;
}numStack;

typedef struct operStack{
    char data[M];
    int top;
}operStack;

//priority[当前][栈顶]
char priority[7][7]={
    //+    -    *    /   （     ）   #
    {'>', '>', '<', '<', '<', '>', '>'},
    {'>', '>', '<', '<', '<', '>', '>'},
    {'>', '>', '>', '>', '<', '>', '>'},
    {'>', '>', '>', '>', '<', '>', '>'},
    {'<', '<', '<', '<', '<', '=', '0'},    // = 表示左右括号相遇 括号里运算已完成 ，0表示不可能出现
    {'>', '>', '>', '>', '0', '>', '>'},
    {'<', '<', '<', '<', '<', '0', '='}
};


@implementation Model

- (void)count:(NSString *)str {
    
    numStack *numStack = [self initNumStack];
    operStack *operStack = [self initOperStack];
    
    char str0[M];
    for (int i = 0; i < str.length; i++) {
        str0[i] = [str characterAtIndex:i];
    }
    
    str0[str.length - 1] = '#';
    [self pushOper:operStack oper:'#'];
    
    int i = 0;
    while (str0[i] != '#' || [self getOperTop:operStack] != '#') {  //表达式未完或运算未完

       // if ([self isNumber:str0[i]]) {     //是数字
        if (str0[i] >= '0' && str0[i] <= '9') {
            char number[10] = {0};
            int k = 0;
            while ((str0[i] >= '0' && str0[i] <= '9') || str0[i] == '.') {
                number[k++] = str0[i++];
            }
            //字符串转double
            double num = atof(number);
            [self pushNum:numStack num:num];
        } else {                          //是运算符
            
            switch ([self procede:[self getOperTop:operStack] oper:str0[i]]) {
                    
                case'<': {     //栈顶小于当前运算符
                    [self pushOper:operStack oper:str0[i++]];
                    break;
                }
                case'=': {     //当栈顶为(，当前为）
                    [self operPop:operStack];  //去掉栈顶（
                    i++;
                    break;
                }
                case'>': {     //栈顶大于当前运算符 operpop， 运算，结果 pushNum
                    char ch;
                    ch = [self getOperTop:operStack];
                    [self operPop:operStack];
                    
                    double a = [self getNumTop:numStack];
                    [self numPop:numStack];
                    
                    double b = [self getNumTop:numStack];
                    [self numPop:numStack];
                    
                    [self pushNum:numStack num:[self operate:b num:a oper:ch]];
                    break;
                }
            }
        }
    }
    
    //result
    NSLog(@"%lf", [self getNumTop:numStack]);
    if ([self getNumTop:numStack]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"figure" object:nil userInfo:@{@"result":[NSNumber numberWithDouble:[self getNumTop:numStack]]}];
    } else {
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"figure" object:nil userInfo:@{@"result":[NSNumber numberWithDouble:0.0]}];
        [self error];
    }
    
}


//初始化numStack
- (numStack *)initNumStack {
    numStack *num = malloc(sizeof(numStack));
    num->top = -1;
    return num;
}


- (operStack *)initOperStack {
    operStack * oper = malloc(sizeof(operStack));
    oper->top = -1;
    return oper;
}



//push
- (void)pushNum:(numStack *)stack num:(double)x {
    if(stack->top == M - 1) {
        return;
    }
    stack->top++;
    stack->data[stack->top] = x;
    
}

- (void)pushOper:(operStack *)stack oper:(char)ch {
    if(stack->top == M - 1) {
        return;
    }
    stack->top++;
    stack->data[stack->top] = ch;
}

//pop
- (void)numPop:(numStack *)stack {
    if(stack->top == -1) {
        return;
    }
    stack->top--;
}

- (void)operPop:(operStack *)stack {
    if(stack->top == -1) {
        return;
    }
    stack->top--;
}

// get
- (char)getOperTop:(operStack *)stack {
    if(stack->top == -1) {
        return NULL;
    }
    char ch = stack->data[stack->top];
    return ch;
    
}

- (double)getNumTop:(numStack *)stack {
    if(stack->top == -1) {
        return 0;
    }
    double x = stack->data[stack->top];
    return x;
    
}


//优先级表下标
- (char)procede:(char)a oper:(char)b {
    int i = 0, j = 0;
    switch(a) {
        case'+': i = 0; break;
        case'-': i = 1; break;
        case'*': i = 2; break;
        case'/': i = 3; break;
        case'(': i = 4; break;
        case')': i = 5; break;
        case'#': i = 6; break;
    }
    switch(b) {
        case'+': j = 0; break;
        case'-': j = 1; break;
        case'*': j = 2; break;
        case'/': j = 3; break;
        case'(': j = 4; break;
        case')': j = 5; break;
        case'#': j = 6; break;
    }
    return priority[i][j];
}

//运算
- (double)operate:(double)a num:(double)b oper:(char)ch {
    if(ch == '+') {
        return a + b;
    } else if(ch == '-') {
        return a - b;
    } else if(ch == '*') {
        return a * b;
    } else if(ch == '/') {
        return a / b;
    }
    return 0;
     
}
 
//判断表达式
- (void)panduan:(NSString *)str {
    
    NSMutableString *string = [NSMutableString stringWithString:str];
    _str = [[NSMutableString alloc] init];
    int k = 0, t = 0;
    
    for(int i = 0; i < string.length - 1; i++) {
        
        char a = [str characterAtIndex:i];
        if(i == 0) {
            if(a == '/' || a == '*') {
                NSLog(@"error");
                [self error];
                return;
            }
            if(a == '-' || a == '+' || a == '.') {
                [_str appendString:@"0"];
                NSLog(@"%@", _str);
            }
        }
        
        if (a == '+' || a == '-' || a == '*' || a == '/'   || a == '.') {
            if (t == 2) {
                if (a == '-' || a == '+') {
                    [_str appendString:@"0"];
                    
                }
            }
            if (t == 1) {
                NSLog(@"error");
                [self error];
                return;
            }
            
            t = 1;
        } else if (a == '(') {
            k++;
            if(t == 0 && i != 0) {
                NSLog(@"error");
                [self error];
                return;
            }
            t = 2;
        } else if (a == ')') {
            k--;
            if((t == 2 && t == 1) ||(t == 1)) {
                NSLog(@"error");
                [self error];
                return;
            }
            t = 3;
        
        } else {
            if (t == 3 && i != string.length - 1) {
                NSLog(@"error");
                //[self error];
                return;
            }
            t = 0;
        }
        
        if(k < 0) {
            NSLog(@"error");
            [self error];
            return;
        }
        
        [_str appendFormat:@"%c", [string characterAtIndex:i]];
    }
    if (t == 1) {
        NSLog(@"error");
        [self error];
    }
    if(k != 0) {
        NSLog(@"%d", k);
        NSLog(@"error");
        [self error];
        return;
    }
    
    [_str appendString:@"="];
    [self count:_str];
    
}

- (void)error {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"error" object:nil];
}


@end
