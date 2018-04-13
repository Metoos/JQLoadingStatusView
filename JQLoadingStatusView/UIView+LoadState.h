//
//  UIView+LoadState.h
//  JQLoadingStatusViewDemo
//
//  Created by life on 2018/4/4.
//  Copyright © 2018年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JQLoadingStatusView.h"
@interface UIView (LoadState)

@property (strong, nonatomic) JQLoadingStatusView *stateView;


/** 显示加载状态视图*/
- (void)showLoadStateWithMaskViewStateType:(ViewStateType)viewStateType;

- (void)showLoadStateWithFrame:(CGRect)frame maskViewStateType:(ViewStateType)viewStateType;
/** 显示加载状态视图默认展示在当前显示控制器 */
//- (void)showLoadStateWithViewStateType:(ViewStateType)viewStateType;
/** 让加载状态视图消失 */
- (void)dismessStateView;
/** 状态回调 */
- (void)loadStateReturnBlock:(StateReturnBlock)stateReturnBlock;

@end
