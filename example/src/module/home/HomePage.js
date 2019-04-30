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
        KPGallery.showGallery(
            { images, debug: true, mode: 'crop', orientation: 'landscape' },
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
        source: require('./test00.png'),
        mode: 'crop'
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
        mode: 'custom',
        minScale: 0.5,
        maxScale: 2,
        debug: false,
    },
    {
        source: require('./test11.jpg'),
    },
];
