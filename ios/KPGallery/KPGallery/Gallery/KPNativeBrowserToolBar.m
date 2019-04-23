//
//  KPNativeBrowserToolBar.m
//  KPNativeGallery
//
//  Created by xukj on 2019/4/23.
//  Copyright © 2019 kpframework. All rights reserved.
//

#import "KPNativeBrowserToolBar.h"
#import "YBIBUtilities.h"
#import "YBIBFileManager.h"

static CGFloat kToolBarDefaultsHeight = 50.0;

@interface KPNativeBrowserToolBar () {
    id<YBImageBrowserCellDataProtocol> _data;
}

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) CAGradientLayer *gradient;

@end

@implementation KPNativeBrowserToolBar

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.gradient];
        [self addSubview:self.indexLabel];
        [self addSubview:self.closeButton];
    }
    return self;
}

#pragma mark - <YBImageBrowserToolBarProtocol>

- (void)yb_browserUpdateLayoutWithDirection:(YBImageBrowserLayoutDirection)layoutDirection containerSize:(CGSize)containerSize {
    CGFloat height = kToolBarDefaultsHeight, width = containerSize.width, buttonWidth = 53, labelWidth = width / 3.0, hExtra = 0;
    if (containerSize.height > containerSize.width && YBIB_IS_IPHONEX) height += YBIB_HEIGHT_STATUSBAR;
    if (containerSize.height < containerSize.width && YBIB_IS_IPHONEX) hExtra += YBIB_HEIGHT_EXTRABOTTOM;
    
    self.frame = CGRectMake(0, 0, width, height);
    self.gradient.frame = self.bounds;
    self.indexLabel.frame = CGRectMake(0, height - kToolBarDefaultsHeight, width, kToolBarDefaultsHeight);
    self.closeButton.frame = CGRectMake(0, height - kToolBarDefaultsHeight, buttonWidth, kToolBarDefaultsHeight);
}

- (void)yb_browserPageIndexChanged:(NSUInteger)pageIndex totalPage:(NSUInteger)totalPage data:(id<YBImageBrowserCellDataProtocol>)data {
    self->_data = data;
    if (totalPage <= 1) {
        self.indexLabel.hidden = YES;
    } else {
        self.indexLabel.hidden  = NO;
        self.indexLabel.text = [NSString stringWithFormat:@"%ld / %ld", pageIndex + 1, totalPage];
    }
}

#pragma mark - event

- (void)clickCloseButton:(UIButton *)button {
    // 关闭当前controller
}

#pragma mark - getter

- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [UILabel new];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.font = [UIFont boldSystemFontOfSize:18];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _indexLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _closeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(clickCloseButton:)
               forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setImage:[YBIBFileManager getImageWithName:@"ybib_cancel"] forState:UIControlStateNormal];
    }
    return _closeButton;
}

- (CAGradientLayer *)gradient {
    if (!_gradient) {
        _gradient = [CAGradientLayer layer];
        _gradient.startPoint = CGPointMake(0.5, 0);
        _gradient.endPoint = CGPointMake(0.5, 1);
        _gradient.colors = @[(id)[UIColor colorWithRed:0  green:0  blue:0 alpha:0.3].CGColor, (id)[UIColor colorWithRed:0  green:0  blue:0 alpha:0].CGColor];
    }
    return _gradient;
}

@end
