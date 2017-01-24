//
//  FCInsertView.m
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/22.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "FCInsertView.h"

@interface FCInsertView()

@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation FCInsertView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor greenColor];
        [self addSubview:self.closeBtn];
    }
    return self;
}

#pragma mark - Action_Methods
- (void)closeBtn_Pressed{
    
    [self removeFromSuperview];
}

#pragma mark - Setter && Getter
- (UIButton *)closeBtn{

    if (!_closeBtn) {
        
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        [_closeBtn setTitle:@"close" forState:UIControlStateNormal];
        _closeBtn.backgroundColor = [UIColor yellowColor];
        [_closeBtn addTarget:self action:@selector(closeBtn_Pressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end
