//
//  FCDetailViewController.m
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/22.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "FCDetailViewController.h"
#import "FCWebViewManager.h"

@interface FCDetailViewController ()

@end

@implementation FCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    FCWebView *webView = [[FCWebView alloc] initWithFrame:self.view.bounds url:@"http://188.188.2.3:8090/app/index.html"];
    FCWebViewManager *webView = [[FCWebViewManager alloc] initWithFrame:self.view.bounds url:@"http://188.188.3.6:8080/app/detail.html"];
    [self.view addSubview:webView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
