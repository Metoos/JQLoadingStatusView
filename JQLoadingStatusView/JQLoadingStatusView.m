//
//  JQLoadingStatusView.m
//  JQLoadingStatusViewDemo
//
//  Created by life on 2018/4/4.
//  Copyright © 2018年 zjq. All rights reserved.
//

#import "JQLoadingStatusView.h"
#import "JQLoadingIndefiniteAnimatedView.h"
@interface JQLoadingStatusView ()

@property (weak, nonatomic) IBOutlet UIView *navView;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet JQLoadingIndefiniteAnimatedView *loadingView;

@property (weak, nonatomic) IBOutlet UIImageView *loadingGifView;

@property (weak, nonatomic) IBOutlet UIView *emptyView;

@property (weak, nonatomic) IBOutlet UIImageView *emptyImg;

@property (weak, nonatomic) IBOutlet UIView *errorView;

@property (weak, nonatomic) IBOutlet UIImageView *errorImg;

@property (assign, nonatomic) BOOL isGifLoading;

@property (strong, nonatomic) StateReturnBlock stateReturnBlock;

@end

@implementation JQLoadingStatusView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"JQLoadingStatusView" owner:nil options:nil] lastObject];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadViewData)];
        self.userInteractionEnabled = YES;
        tap.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tap];
        self.backBtnHidden = YES;
        self.showNavigationBar = NO;
        self.navigationBarColor = [UIColor whiteColor];
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url = [bundle URLForResource:@"JQLoadingStatusView" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        NSString *pathLoadEmpty = [imageBundle pathForResource:@"loadEmpty@2x" ofType:@"png"];
        NSString *pathLoadError = [imageBundle pathForResource:@"loadError@2x" ofType:@"png"];
        NSString *pathBack = [imageBundle pathForResource:@"jq_back@2x" ofType:@"png"];
        [self.backBtn setImage:[UIImage imageWithContentsOfFile:pathBack] forState:UIControlStateNormal];
        self.emptyImage   = [UIImage imageWithContentsOfFile:pathLoadEmpty];
        self.errorImage   = [UIImage imageWithContentsOfFile:pathLoadError];
        
    }
    return self;
}

- (void)setEmptyImage:(UIImage *)emptyImage
{
    _emptyImage = emptyImage;
    
    _emptyImg.image = _emptyImage;
}

- (void)setErrorImage:(UIImage *)errorImage
{
    _errorImage = errorImage;
    
    _errorImg.image = _errorImage;
}

- (void)setBackBtnHidden:(BOOL)backBtnHidden
{
    _backBtnHidden = backBtnHidden;
    self.backBtn.hidden = _backBtnHidden;
}

- (void)setShowNavigationBar:(BOOL)showNavigationBar
{
    _showNavigationBar = showNavigationBar;
    self.navView.hidden = _showNavigationBar;
}

- (void)setNavigationBarColor:(UIColor *)navigationBarColor
{
    _navigationBarColor = navigationBarColor;
    self.navView.backgroundColor = navigationBarColor;
}

- (void)setNavigationTitle:(NSString *)navigationTitle
{
    _navigationTitle = navigationTitle;
    self.titleLab.text = navigationTitle;
}

- (void)setNavigationTitleColor:(UIColor *)navigationTitleColor
{
    _navigationTitleColor = navigationTitleColor;
    self.titleLab.textColor = _navigationTitleColor;
}


-(void)layoutSubviews
{
    if (!_isGifLoading) {
        _loadingView.strokeColor = [UIColor blackColor];
        _loadingView.strokeThickness = 3;
        _loadingView.radius = 25;
        [_loadingView sizeToFit];
    }
    
}

- (IBAction)backAction:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(backActionStateView)]) {
        [_delegate backActionStateView];
    }
    
    !self.stateReturnBlock?:self.stateReturnBlock(ViewStateReturnBackActionType);
}


- (void)reloadViewData
{
    if (_delegate && [_delegate respondsToSelector:@selector(reloadViewDataStateView)]) {
        [_delegate reloadViewDataStateView];
    }
//    [self setMaskViewStateType:viewStateWithLoading];
    !self.stateReturnBlock?:self.stateReturnBlock(ViewStateReturnReloadViewDataType);
}

- (void)setMaskViewStateType:(ViewStateType)maskViewStateType
{
    _maskViewStateType = maskViewStateType;
    switch (maskViewStateType) {
        case viewStateWithNone:
        {
            _loadingView.hidden    = YES;
            _loadingGifView.hidden = YES;
            _errorView.hidden      = YES;
            _emptyView.hidden      = YES;
            _backBtn.hidden        = YES;
            break;
        }
        case viewStateWithLoading:
        {
            _loadingView.hidden = _isGifLoading;
            _loadingGifView.hidden = !_isGifLoading;
            _emptyView.hidden   = YES;
            _errorView.hidden   = YES;
            if (_delegate && [_delegate respondsToSelector:@selector(loadingDataWithStateView)]) {
                [_delegate loadingDataWithStateView];
            }
            !self.stateReturnBlock?:self.stateReturnBlock(ViewStateReturnLoadingDataType);
            
            break;
        }
        case viewStateWithEmpty:
        {
            _loadingView.hidden    = YES;
            _loadingGifView.hidden = YES;
            _emptyView.hidden      = NO;
            _errorView.hidden      = YES;
            break;
        }
        case viewStateWithLoadError:
        {
            _loadingView.hidden    = YES;
            _loadingGifView.hidden = YES;
            _emptyView.hidden      = YES;
            _errorView.hidden      = NO;
            break;
        }
        default:
            break;
    }

}

/** 设置loading状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration
{
    if (!images || images.count == 0) {
        return;
    }
    _isGifLoading = YES;
    _loadingView.hidden = _isGifLoading;
    _loadingGifView.hidden = !_isGifLoading;
    if (images.count == 1) { // 单张图片
        self.loadingGifView.image = [images lastObject];
        [self.loadingGifView stopAnimating];
    } else { // 多张图片
        if (duration <= 0.0f) {
            duration = images.count * 0.1;
        }
        [self.loadingGifView stopAnimating];
        self.loadingGifView.animationImages = images;
        self.loadingGifView.animationDuration = duration;
        [self.loadingGifView startAnimating];
    }
    
}


- (void)showWithInView:(UIView*)view maskViewStateType:(ViewStateType)viewStateType
{
    [self showWithInView:view andFrame:view.bounds maskViewStateType:viewStateType];
}

- (void)showWithInView:(UIView*)view andFrame:(CGRect)frame maskViewStateType:(ViewStateType)viewStateType
{
     [self setValue:[[NSString alloc] initWithFormat:@"%ld",viewStateType] forKey:@"maskViewStateType"];
    
    [self setMaskViewStateType:viewStateType];
    self.frame = frame;
    [self removeFromSuperview];
    [view addSubview:self];
}

- (void)showWithViewStateType:(ViewStateType)viewStateType
{
    UIViewController *viewController = [self getCurrentViewController];
    
    [self showWithInView:viewController.view maskViewStateType:viewStateType];
}


- (void)dismessStateView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
       [self removeFromSuperview];
        self.alpha = 1;
        
        [self setValue:[[NSString alloc] initWithFormat:@"%ld",viewStateWithLoadDismess] forKey:@"maskViewStateType"];
        self.maskViewStateType = viewStateWithLoadDismess;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didDismessStateView)]) {
            [self.delegate didDismessStateView];
        }
        !self.stateReturnBlock?:self.stateReturnBlock(ViewStateReturnDidDismessType);
        
    }];
    
}

/** 状态回调 */
- (void)stateReturnBlock:(StateReturnBlock)stateReturnBlock
{
    self.stateReturnBlock = stateReturnBlock;
}

- (void)dealloc
{
    self.emptyImg.image = nil;
    self.errorImg.image   = nil;
}

#pragma mark -获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentViewController
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal){
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for(UIWindow * tmpWin in windows){
            
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                
                window = tmpWin;
                
                break;
                
            }
            
        }
        
    }
    
    UIViewController *result = window.rootViewController;
    
    while (result.presentedViewController) {
        
        result = result.presentedViewController;
        
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        
        result = [(UITabBarController *)result selectedViewController];
        
    }
    
    if ([result isKindOfClass:[UINavigationController class]]) {
        
        result = [(UINavigationController *)result topViewController];
        
    }
    
    return result;
    
    
}

@end
