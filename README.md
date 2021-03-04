# react-native-kpframework-gallery

[![](https://img.shields.io/npm/v/react-native-kpframework-gallery.svg?style=flat-square)](https://www.npmjs.com/package/react-native-kpframework-gallery)
[![](https://img.shields.io/npm/dm/react-native-kpframework-gallery.svg?style=flat-square)](https://www.npmjs.com/package/react-native-kpframework-gallery)
[![](https://img.shields.io/github/license/xuwaer/KPFrameworkRN.svg?style=flat-square)](https://github.com/xuwaer/KPFrameworkRN/blob/master/LICENSE)

Picture browser, supports left and right sliding, gesture zoom, double-click zoom, network picture download cache and display, local picture display. Support the browsing of oversized pictures.

## Compatibility
  
version 0.4.x requires react-native >= 0.61.0
version 0.3.x requires react-native >= 0.56.0

## Native library

- Android  
  Based on [subsampling-scale-image-view](https://github.com/davemorrissey/subsampling-scale-image-view)
- iOS  
  Based on [YBImageBrowser](https://github.com/indulgeIn/YBImageBrowser)

## Installation method

#### Step 1: Add library

```
yarn add react-native-kpframework-gallery
```

#### Step 2: Link native

```
react-native link react-native-kpframework-gallery
```

#### Third step

**Android**  
Gradle >= 3.1.4 (android/build.gradle)  
Android SDK >= 26 (android/app/build.gradle)

**iOS**

1. Cocoapods(recommended)  
   Modify Podfile file as follows:

```ruby
platform :ios, '9.0'

target '<project_name>' do
  # this is very important to have!
  rn_path = '../node_modules/react-native'
  pod 'yoga', path: "#{rn_path}/ReactCommon/yoga/yoga.podspec"
  pod 'React', path: rn_path, subspecs: [
    'Core',
    'RCTActionSheet',
    'RCTAnimation',
    'RCTGeolocation',
    'RCTImage',
    'RCTLinkingIOS',
    'RCTNetwork',
    'RCTSettings',
    'RCTText',
    'RCTVibration',
    'RCTWebSocket'
  ]

  pod 'KPNativeGallery', :path => '../node_modules/react-native-kpframework-gallery'
end

# very important to have, unless you removed React dependencies for Libraries
# and you rely on Cocoapods to manage it
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == "React"
      target.remove_from_project
    end
  end
end
```

execute `pod install`

2. Manual installation  
   Click on project General tab  
   Under Deployment Info set Deployment Target to 8.0  
   Under Embedded Binaries click + and add KPGallery.framework

## Use

```jsx
import KPGallery from 'react-native-kpframework-gallery';
...

const images = [
    {
        source: require('./test00.png'),
    },
    {
        source: {
            uri:
                'http://m.qpic.cn/psu?/43967169/Y.YMon9Po5EyLcZVxakkQnZn0y.O5dEjvtvA0bKXv9A!/b/YfBXWBFokwAAYrBHfRI4VAAA&a=29&b=31&bo=ngKEAQAAAAABEC4!&rf=viewer_4',
        },
    },
    {
        source: {
            uri:
                'http://m.qpic.cn/psu?/43967169/.P4OPC7dpQi5WtD7AJjRMloPZJIM4w.5wSJ7wCiLFjM!/b/Yf.ZShHKVAAAYsfQfhK4VAAA&a=29&b=31&bo=AAKOAQAAAAABELo!&rf=viewer_4',
        },
    },
    {
        source: require('./test11.jpg'),
    },
];

KPGallery.showGallery({ images },
    index => console.log('callback', index),
    () => console.log('callback', 'close')
);

```

## API

- showGallery(options, onPageChanged, onClose);

### 1. Options - Parameter Description

| Attribute   | Description                                                  | Type   | Default              |
| ----------- | ------------------------------------------------------------ | ------ | -------------------- |
| images      | Image data array, see image description below                | array  | no                   |
| index       | Initial display of the first few                             | number | 0                    |
| debug       | Whether to enable debug mode, only valid on android          | bool   | false                |
| minScale    | Minimum zoom ratio, valid when `mode` is `custom`            | number | 0.5 / iOS fixed to 1 |
| maxScale    | Maximum zoom ratio, valid when `mode` is `custom`            | number | 2                    |
| mode        | Picture display mode `inside` `crop` `custom`                | string | `insde`              |
| orientation | Horizontal and vertical screen `auto` `portrait` `landscape` | string | `auto`               |
| seek        | Whether to display a draggable progress bar                  | bool   | false                |

#### Image single image attribute (only support **android**)

| Attribute   | Description                                                  | Type   | Default              |
| ----------- | ------------------------------------------------------------ | ------ | -------------------- |
| source      | Consistent with react-native's Image source                  |        | no                   |
| debug       | Whether to enable debug mode, only valid on android          | bool   | false                |
| minScale    | Minimum zoom ratio, valid when `mode` is `custom`            | number | 0.5                  |
| maxScale    | Maximum zoom ratio, valid when `mode` is `custom`            | number | 2                    |
| mode        | Picture display mode `inside` `crop` `custom`                | string | insde                |

### 2. onPageChanged

Called when the picture is switched

```jsx
index => {};
```

### 3. onClose

gallery - Called on shutdown

```jsx
() => {};
```

### 4. Other instructions

#### Mode

`inside` zoom the picture to display all;
`crop` scales the width of the picture to the width of the screen. If the picture is narrower than the screen, it will be as wide as the display;
`custom` specifies this mode, you need to provide `minScale` and `maxScale`, the initial scale of the image is `minScale`

#### Orientation

The iOS side must specify the supported horizontal and vertical screen modes in AppDelegate.m

```objc
// portrait - UIInterfaceOrientationMaskPortrait
// landscape - UIInterfaceOrientationMaskLandscape
// auto - UIInterfaceOrientationMaskAllButUpsideDown
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
  return UIInterfaceOrientationMaskLandscape;
}
```

### 5. Precautions

- iOS single image only supports setting `source`
- iOS does not support `minScale`, it is fixed at 1
- iOS does not support `debug` debugging mode

   
### 6. KPAndroidGalleryView  
In RN, when the activity is opened directly on the android side, sometimes there will be unpredictable task switching problems; if the interface cannot be switched directly using startActivity, then you can directly use the component to draw on the interface;

 - `options` `onPageChanged` `onClose`
   **Same as the previous usage**
 - orientation  
   **Invalid**
 - onClosePress
   **New click to close event**
  
```jsx
import { KPAndroidGalleryView } from "react-native-kpframework-gallery";

<KPAndroidGalleryView
  style={{ flex: 1 }}
  options={{
    images,
    debug: true,
    mode: "crop",
    orientation: "auto", // orientation is invalid
    seek: true
  }}
  onPageChanged={index => console.log("onPageChanged:" + index)}
  onClosePress={() => console.log('Button close pressed')}
  onClose={() => console.log('Component closed')}
/>;
```
