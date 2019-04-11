# react-native-kpframework-gallery

[![](https://img.shields.io/npm/v/react-native-kpframework-gallery.svg?style=flat-square)](https://www.npmjs.com/package/react-native-kpframework-gallery)
[![](https://img.shields.io/npm/dm/react-native-kpframework-gallery.svg?style=flat-square)](https://www.npmjs.com/package/react-native-kpframework-gallery)

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
| minScale     | 最小缩放比例，为0表示自动控制 | number                 | 0   |
| maxScale     | 最大缩放比例，为0表示自动控制 | number                 | 0   |

**image** 单个图片说明

| 属性     | 说明                           | 类型                    | 默认值 |
| -------- | ------------------------------ | ----------------------- | ------ |
| source  | 与react-native 的 Image source一致                       |  | 无     |
| minScale     | 最小缩放比例，为0表示自动 | number                 | 0   |
| maxScale     | 最大缩放比例，为0表示自动 | number                 | 0   |