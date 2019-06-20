//
//  KPNativeBrowserSeekBar.h
//  KPGallery
//
//  Created by xukj on 2019/6/20.
//

#import <UIKit/UIKit.h>
#import "YBImageBrowserToolBarProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KPNativeBrowserSeekBar : UIView <YBImageBrowserToolBarProtocol>

@property (nonatomic, strong, readonly) UISlider *slider;

@end

NS_ASSUME_NONNULL_END
