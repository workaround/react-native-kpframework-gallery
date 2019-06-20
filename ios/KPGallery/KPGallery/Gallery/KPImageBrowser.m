//
//  KPImageBrowser.m
//  KPGallery
//
//  Created by xukj on 2019/4/23.
//  Copyright © 2019 kpframework. All rights reserved.
//

#import "KPImageBrowser.h"
#import "KPNativeBrowserToolBar.h"
#import "KPNativeBrowserSeekBar.h"

@interface KPImageBrowser ()<YBImageBrowserDelegate, KPNativeBrowserSeekBarProtocal>

@property (nonatomic, strong) KPNativeBrowserToolBar *kpToolBar;
@property (nonatomic, strong) KPNativeBrowserSeekBar *kpSeekBar;
@property (nonatomic, assign) UIInterfaceOrientation kpOrientationBefore;

@end

@implementation KPImageBrowser

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.toolBars = @[self.kpToolBar, self.kpSeekBar];
        self.delegate = self;
        self.kpSeekBar.delegate = self;
        self.kpOrientationBefore = UIInterfaceOrientationUnknown;
    }
    return self;
}

#pragma mark - delegate

- (void)yb_imageBrowser:(YBImageBrowser *)imageBrowser pageIndexChanged:(NSUInteger)index data:(id<YBImageBrowserCellDataProtocol>)data
{
    // do nothing
    if (self.kpDelegate && [self.kpDelegate respondsToSelector:@selector(imageBrowser:pageIndexChanged:)]) {
        [self.kpDelegate imageBrowser:self pageIndexChanged:index];
    }
}

- (void)seekbar:(UISlider *)slider didChangeIndex:(NSUInteger)index
{
    self.currentIndex = index;
}

#pragma mark - override

- (void)yb_imageBrowserViewDismiss:(YBImageBrowserView *)browserView {
    // 屏蔽单击关闭操作
    if (self.useSeek) {
        self.kpSeekBar.hidden = !self.kpSeekBar.isHidden;
    }
}

- (void)show {
    // 重写父类方法，增加横竖屏旋转操作
    self.kpOrientationBefore = [[UIApplication sharedApplication] statusBarOrientation];
    
    if ([KPORIENTATION_PORTRAIT isEqualToString:self.kpOrientation]) {
        // 竖屏旋转
        [self changeOrientation:UIInterfaceOrientationPortrait];
    }
    else if ([KPORIENTATION_LANDSCAPE isEqualToString:self.kpOrientation]) {
        // 横屏旋转
        [self changeOrientation:UIInterfaceOrientationLandscapeRight];
    }
    else {
        // 自动不旋转
    }
    
    [super show];
}

- (void)hide {
    // 重写父类方法，关闭时需要重置横竖屏
    if (self.kpOrientationBefore != [[UIApplication sharedApplication] statusBarOrientation]) {
        [self changeOrientation:self.kpOrientationBefore];
    }
    [super hide];
}

#pragma mark - private

// 旋转屏幕
- (void)changeOrientation:(UIInterfaceOrientation)destOrientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        
        // 设置支持横屏还是竖屏
        if (UIInterfaceOrientationIsPortrait(destOrientation)) {
            self.supportedOrientations = UIInterfaceOrientationMaskPortrait;
        }
        else if (UIInterfaceOrientationIsLandscape(destOrientation)) {
            self.supportedOrientations = UIInterfaceOrientationMaskLandscape;
        }
        
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        NSInteger val = destOrientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
        
        [UIViewController attemptRotationToDeviceOrientation];
    }
}

#pragma mark - getter/setter

- (KPNativeBrowserToolBar *)kpToolBar
{
    if (_kpToolBar == nil) {
        _kpToolBar = [KPNativeBrowserToolBar new];
        [_kpToolBar.closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kpToolBar;
}

- (KPNativeBrowserSeekBar *)kpSeekBar
{
    if (_kpSeekBar == nil) {
        _kpSeekBar = [KPNativeBrowserSeekBar new];
        _kpSeekBar.hidden = YES;
    }
    return _kpSeekBar;
}

- (void)dealloc
{
    if (self.kpDelegate && [self.kpDelegate respondsToSelector:@selector(imageBrowserClose)]) {
        [self.kpDelegate imageBrowserClose];
    }
    NSLog(@"dealloc");
}

@end
