//
//  KPNativeGallery.m
//  KPNativeGallery
//
//  Created by xukj on 2019/4/23.
//  Copyright © 2019 kpframework. All rights reserved.
//

#import "KPNativeGallery.h"
#import <KPGallery/KPGallery.h>

#define KPPHOTO_GALLERY_KEY_IMAGES @"images"
#define KPPHOTO_GALLERY_KEY_INDEX @"index"
#define KPPHOTO_GALLERY_KEY_DEBUG @"debug"
#define KPPHOTO_GALLERY_KEY_MAXSCALE @"maxScale"
#define KPPHOTO_GALLERY_KEY_MINSCALE @"minScale"
#define KPPHOTO_GALLERY_KEY_MODE @"mode"

#define KPMODE_INSIDE @"inside"
#define KPMODE_CROP @"crop"
#define KPMODE_CUSTOM @"custom"

@interface KPNativeGallery () <KPImageBrowserDelegate>

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) float maxScale;
@property (nonatomic, assign) float minScale;
@property (nonatomic, strong) NSString *mode;
@property (nonatomic, assign) BOOL debug;

@property (nonatomic, strong) NSDictionary *options;

@end

@implementation KPNativeGallery

RCT_EXPORT_MODULE();

@synthesize bridge = _bridge;

RCT_EXPORT_METHOD(showGallery:(NSDictionary *)options) {
    
    NSLog(@"options %@", options);
    self.options = options;
    self.images = [options valueForKey:KPPHOTO_GALLERY_KEY_IMAGES];
    self.index = [[options valueForKey:KPPHOTO_GALLERY_KEY_INDEX] intValue];
    self.minScale = [[options valueForKey:KPPHOTO_GALLERY_KEY_MINSCALE] floatValue];
    self.maxScale = [[options valueForKey:KPPHOTO_GALLERY_KEY_MAXSCALE] floatValue];
    self.debug = [[options valueForKey:KPPHOTO_GALLERY_KEY_DEBUG] boolValue];
    self.mode = [options valueForKey:KPPHOTO_GALLERY_KEY_MODE];
    
    [self setGlobalConfiguration];
    [self setImagesConfiguration];
}

- (void)setGlobalConfiguration {
    if ([KPMODE_CROP isEqualToString:self.mode]) {
        [KPImageBrowseCellData setGlobalVerticalfillType:YBImageBrowseFillTypeUnknown];
        [KPImageBrowseCellData setGlobalHorizontalfillType:YBImageBrowseFillTypeFullWidth];
    }
    else if ([KPMODE_CUSTOM isEqualToString:self.mode]) {
        
    }
    else {
        // 使用默认inside
        [KPImageBrowseCellData setGlobalVerticalfillType:YBImageBrowseFillTypeCompletely];
        [KPImageBrowseCellData setGlobalHorizontalfillType:YBImageBrowseFillTypeCompletely];
    }
}

- (void)setImagesConfiguration {
    
    if (self.images == nil || self.images.count <= 0)
        return;
    
    NSMutableArray *dataArray = [NSMutableArray new];
    [self.images enumerateObjectsUsingBlock:^(NSDictionary *image, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *uri = [image valueForKey:@"uri"];
        if (uri == nil) return;
        KPImageBrowseCellData *data = [KPImageBrowseCellData new];
        data.url = [NSURL URLWithString:uri];
        [dataArray addObject:data];
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        KPImageBrowser *browser = [KPImageBrowser new];
        browser.dataSourceArray = dataArray;
        browser.currentIndex = self.index;
        browser.kpDelegate = self;
        [browser show];
    });
}

#pragma mark - delegate

- (void)imageBrowser:(KPImageBrowser *)browser pageIndexChanged:(NSUInteger)index
{
    NSLog(@"index %ld", index);
}

- (void)imageBrowserClose
{
    NSLog(@"close");
}

@end
