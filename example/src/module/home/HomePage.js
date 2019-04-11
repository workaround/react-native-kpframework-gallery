/**
 * @class
 * @author xukj
 * @date 2018/8/15
 * @description 首页交互组件
 */
import React from 'react';
import PropTypes from 'prop-types';
import { Actions } from 'react-native-router-flux';
import Home from './Home';
import KPGallery from 'react-native-kpframework-gallery';

export default class HomePage extends React.PureComponent {
    static propTypes = {};

    static defaultProps = {};

    constructor(props) {
        super(props);
    }

    componentDidMount() {}

    render() {
        return <Home onPress={this._onPress} />;
    }

    /*
     * @private
     * @description 点击详情
     */
    _onPress = () => {
        // Actions.push('zoom');
        // NativeModules.ViewPagerModule.showViewPager();
        // NativeModules.ViewPagerModule.showTest();
        // NativeModules.ViewPagerModule.showGallery({
        //     images: [
        //         {
        //             url:
        //                 'https://r.photo.store.qq.com/psb?/43967169/eWlMurWU5GXLj0Ys4bcVYGKWUYFNn9V87DEmr2g1fAk!/r/dL8AAAAAAAAA',
        //         },
        //         {
        //             url:
        //                 'http://m.qpic.cn/psu?/43967169/Y.YMon9Po5EyLcZVxakkQnZn0y.O5dEjvtvA0bKXv9A!/b/YfBXWBFokwAAYrBHfRI4VAAA&a=29&b=31&bo=ngKEAQAAAAABEC4!&rf=viewer_4',
        //         },
        //         {
        //             url:
        //                 'http://m.qpic.cn/psu?/43967169/.P4OPC7dpQi5WtD7AJjRMloPZJIM4w.5wSJ7wCiLFjM!/b/Yf.ZShHKVAAAYsfQfhK4VAAA&a=29&b=31&bo=AAKOAQAAAAABELo!&rf=viewer_4',
        //         },
        //     ],
        //     index: 1,
        // }, null, null);
        console.log('images', images);
        KPGallery.showGallery(
            { images, index: 1, debug: true, maxScale: 2 },
            index => {
                console.log('callback', index);
            },
            () => {
                console.log('callback', 'close');
            }
        );
    };
}

const images = [
    {
        source: {
            uri:
                'https://r.photo.store.qq.com/psb?/43967169/eWlMurWU5GXLj0Ys4bcVYGKWUYFNn9V87DEmr2g1fAk!/r/dL8AAAAAAAAA',
        },
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
