/**
 * @author xukj
 * @date 2019/07/16
 * @description KPGalleryView
 */
import React from 'react';
import PropTypes from 'prop-types';
import ReactNative, {
    StyleSheet,
    View,
    NativeModules,
    requireNativeComponent,
    Image,
    Dimensions,
    Animated,
    TouchableWithoutFeedback,
    DeviceEventEmitter,
    InteractionManager,
    Text,
    TouchableOpacity,
    ActivityIndicator,
    Platform,
    BackHandler,
} from 'react-native';

const { width, height } = Dimensions.get('window');
const UIManager = NativeModules.UIManager;
const config = {};

export default class KPGalleryView extends React.PureComponent {
    static propTypes = {
        images: PropTypes.array,
        minScale: PropTypes.number,
        maxScale: PropTypes.number,
        debug: PropTypes.bool,
        seek: PropTypes.bool,
        mode: PropTypes.oneOf(['inside', 'crop', 'custom']),
        orientation: PropTypes.oneOf(['auto', 'portrait', 'landscape']),
        onIndexChanged: PropTypes.func,
        onClosePress: PropTypes.func,
    };

    static defaultProps = {
        mode: 'inside',
        orientation: 'auto',
        debug: false,
        seek: false,
    };

    render() {
        const { style, ...restProps } = this.props;
        return (
            <KPAndroidGalleryView
                style={{ width, height, backgroundColor: 'black' }}
                {...restProps}
            />
        );
    }
}

const KPAndroidGalleryView = requireNativeComponent('KPGalleryView', KPGalleryView, config);
