# react-native-kpframework-gallery

[![](https://img.shields.io/npm/v/react-native-kpframework-gallery.svg?style=flat-square)](https://www.npmjs.com/package/react-native-kpframework-gallery)
[![](https://img.shields.io/npm/dm/react-native-kpframework-gallery.svg?style=flat-square)](https://www.npmjs.com/package/react-native-kpframework-gallery)
[![](https://img.shields.io/github/license/xuwaer/KPFrameworkRN.svg?style=flat-square)](https://github.com/xuwaer/KPFrameworkRN/blob/master/LICENSE)

图片浏览器，支持左右滑动，手势缩放，双击缩放，网络图片下载缓存并显示，本地图片显示。支持超大图片的浏览。

## 原生库

- Android [subsampling-scale-image-view](https://github.com/davemorrissey/subsampling-scale-image-view)
- iOS 暂未支持

## 安装方式

1. 添加库

```
yarn add react-native-kpframework-gallery
```

2. 链接原生

```
react-native link react-native-kpframework-gallery
```

## 使用

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

**options** 参数说明  

| 属性     | 说明                           | 类型                    | 默认值 |
| -------- | ------------------------------ | ----------------------- | ------ |
| images  | 图片数据数组，见下面的`image`说明                       | array | 无     |
| index | 初始显示第几张         | number                  | 0      |
| debug  | 是否开启debug模式,仅android端有效                     | bool                | false     |
| minScale     | 最小缩放比例，`mode`为`custom`时有效 | number                 | 0.5   |
| maxScale     | 最大缩放比例，`mode`为`custom`时有效 | number                 | 2   |
| mode     | 图片显示模式`inside` `crop` `custom` | string                 | insde   |
  
`inside`缩放图片至全部显示；  
`crop`缩放图片宽度至屏幕宽度，如果图片比屏幕窄，则有多宽显示多宽；  
`custom`指定了该模式，则需要提供`minScale`和`maxScale`，图片初始缩放比例为`minScale`

**image** 单个图片属性

| 属性     | 说明                           | 类型                    | 默认值 |
| -------- | ------------------------------ | ----------------------- | ------ |
| source  | 与react-native 的 Image source一致                       |  | 无     |
| debug  | 是否开启debug模式,仅android端有效                     | bool                | false     |
| minScale     | 最小缩放比例，`mode`为`custom`时有效 | number                 | 0.5   |
| maxScale     | 最大缩放比例，`mode`为`custom`时有效 | number                 | 2   |
| mode     | 图片显示模式`inside` `crop` `custom` | string                 | insde   |
  
**onPageChanged** 图片切换时调用
  
**onClose** gallery关闭时调用

