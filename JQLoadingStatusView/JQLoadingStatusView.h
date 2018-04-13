//
//  JQLoadingStatusView.h
//  JQLoadingStatusViewDemo
//
//  Created by life on 2018/4/4.
//  Copyright © 2018年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ViewStateType) {
    
    viewStateWithNone = 0, //default
    viewStateWithLoading, //页面状态：正在加载
    viewStateWithEmpty,//页面状态：空页面
    viewStateWithLoadError,//页面状态：加载错误或页面数据错误
    viewStateWithLoadDismess//页面状态：页面消失隐藏
    
};

typedef NS_ENUM(NSInteger,ViewStateReturnType) {
    
    ViewStateReturnReloadViewDataType = 0, ////加载错误时点击重新加载
    ViewStateReturnDidDismessType, //加载页面消失
    ViewStateReturnLoadingDataType,//正在加载
    ViewStateReturnBackActionType,//返回上一页
    
};


@protocol StateViewDelegate <NSObject>

@optional
- (void)reloadViewDataStateView; //加载错误时点击重新加载回调方法

- (void)didDismessStateView; //加载页面消失时调用

- (void)loadingDataWithStateView;//正在加载时调用

- (void)backActionStateView;//返回上一页

@end

typedef void(^StateReturnBlock)(ViewStateReturnType viewStateReturnType);

@interface JQLoadingStatusView : UIView

@property (weak, nonatomic) id<StateViewDelegate>delegate;



@property (weak, nonatomic) IBOutlet UIButton *backBtn;
/** 是否隐藏返回按钮 默认YES */
@property (assign, nonatomic) BOOL backBtnHidden;
/** 显示自定义导航栏 默认 NO 不显示 */
@property (assign, nonatomic) BOOL showNavigationBar;
/** 设置自定义导航栏颜色 */
@property (strong, nonatomic) UIColor *navigationBarColor;
/** 设置自定义导航栏标题 */
@property (strong, nonatomic) NSString *navigationTitle;
/** 设置自定义导航栏标题颜色 */
@property (strong, nonatomic) UIColor *navigationTitleColor;

/** 设置自定义空数据提示图片*/
@property (strong, nonatomic) UIImage *emptyImage;

/** 设置自定义加载错误提示图片*/
@property (strong, nonatomic) UIImage *errorImage;

@property (assign, nonatomic) ViewStateType maskViewStateType;

/** 设置loading状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration;

- (void)showWithInView:(UIView*)view maskViewStateType:(ViewStateType)viewStateType;

- (void)showWithInView:(UIView*)view andFrame:(CGRect)frame maskViewStateType:(ViewStateType)viewStateType;

- (void)showWithViewStateType:(ViewStateType)viewStateType;

- (void)dismessStateView;
/** 状态回调 */
- (void)stateReturnBlock:(StateReturnBlock)stateReturnBlock;

@end
