//
//  SubViewController.m
//  JQLoadingStatusViewDemo
//
//  Created by life on 2018/4/12.
//  Copyright © 2018年 zjq. All rights reserved.
//


//bolck使用 避免循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#import "SubViewController.h"
#import "UIView+LoadState.h"
@interface SubViewController ()


@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    
    if (!self.isShowEmpty) {
        
        self.view.stateView.backgroundColor = [UIColor colorWithRed:0.0f green:174.0/255.0 blue:239.0f/255.0 alpha:1.0];
        
        //使用自定义GIF图片作为加载状态显示
        [self.view.stateView setImages:[self loadingImages] duration:2.25f];
        //使用自定义空界面图
//        [self.view.stateView setEmptyImage:[UIImage imageNamed:@"自定义空数据提示图"]];
        //使用自定义错误界面图
//        [self.view.stateView setErrorImage:[UIImage imageNamed:@"自定义错误数据提示图"]];
        
    }
    
    //显示加载中
    [self.view showLoadStateWithMaskViewStateType:viewStateWithLoading];
    WS(weakSelf);
    //加载状态回调
    [self.view loadStateReturnBlock:^(ViewStateReturnType viewStateReturnType) {
        if (viewStateReturnType == ViewStateReturnReloadViewDataType) {//用户点击了重新加载
            //显示加载中
            [weakSelf.view showMaskStateType:viewStateWithLoading];
            if (!self.isShowEmpty) {
                weakSelf.view.stateView.backgroundColor = [UIColor colorWithRed:0.0f green:174.0/255.0 blue:239.0f/255.0 alpha:1.0];
            }
            //重新请求数据
            [weakSelf loadData];
        }
    }];
    //模拟请求数据
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    
    //模拟请求数据延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.isShowEmpty) {
            self.view.stateView.backgroundColor = [UIColor whiteColor];
            //显示错误界面
            [self.view showMaskStateType:viewStateWithEmpty];
        }else
        {
            self.view.stateView.backgroundColor = [UIColor whiteColor];
            //显示错误界面
            [self.view showMaskStateType:viewStateWithLoadError];
        }
        
        //数据正常加载完成则隐藏加载状态视图
//        [self.view dismessStateView];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)loadingImages
{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:47];
    for (int i=0; i<47; i++)
    {
        NSString *imageNamed = [[NSString alloc]initWithFormat:@"loading_%d",i];
        UIImage *image = [UIImage imageNamed:imageNamed];
        if (image) {
           [ary addObject:image];
        }
    }
    return ary;

}

@end
