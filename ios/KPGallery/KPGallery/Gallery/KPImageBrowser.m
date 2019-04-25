//
//  KPImageBrowser.m
//  KPGallery
//
//  Created by xukj on 2019/4/23.
//  Copyright © 2019 kpframework. All rights reserved.
//

#import "KPImageBrowser.h"
#import "KPNativeBrowserToolBar.h"

@interface KPImageBrowser ()<YBImageBrowserDelegate>

@property (nonatomic, strong) KPNativeBrowserToolBar *kpToolBar;

@end

@implementation KPImageBrowser

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.toolBars = @[self.kpToolBar];
        self.delegate = self;
    }
    return self;
}

#pragma mark - delegate

//- (void)yb_imageBrowser:(YBImageBrowser *)imageBrowser respondsToLongPress:(UILongPressGestureRecognizer *)longPress
//{
//    // do nothing
//    // 屏蔽长按事件
//}

- (void)yb_imageBrowser:(YBImageBrowser *)imageBrowser pageIndexChanged:(NSUInteger)index data:(id<YBImageBrowserCellDataProtocol>)data
{
    // do nothing
    if (self.kpDelegate && [self.kpDelegate respondsToSelector:@selector(imageBrowser:pageIndexChanged:)]) {
        [self.kpDelegate imageBrowser:self pageIndexChanged:index];
    }
}

#pragma mark - override

- (void)yb_imageBrowserViewDismiss:(YBImageBrowserView *)browserView {
    // 屏蔽单击关闭操作
}

#pragma mark - getter

- (KPNativeBrowserToolBar *)kpToolBar
{
    if (_kpToolBar == nil) {
        _kpToolBar = [KPNativeBrowserToolBar new];
        [_kpToolBar.closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kpToolBar;
}

- (void)dealloc
{
    if (self.kpDelegate && [self.kpDelegate respondsToSelector:@selector(imageBrowserClose)]) {
        [self.kpDelegate imageBrowserClose];
    }
    NSLog(@"dealloc");
}

@end
