//
//  ViewController.m
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/17.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "ViewController.h"
#import "FCWebViewManager.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"];
    
//    FCWebView *webView = [[FCWebView alloc] initWithFrame:self.view.bounds url:@"http://188.188.3.6:8080/app/index.html"];
    FCWebViewManager *webView = [[FCWebViewManager alloc] initWithFrame:self.view.bounds url:path];
    [self.view addSubview:webView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
