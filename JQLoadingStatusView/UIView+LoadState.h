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

/** //不重新addsubview到父视图 直接改变状态 */
- (void)showMaskStateType:(ViewStateType)viewStateType;

/** 让加载状态视图消失 */
- (void)dismessStateView;
/** 状态回调 */
- (void)loadStateReturnBlock:(StateReturnBlock)stateReturnBlock;

@end
