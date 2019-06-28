/**
 * @class
 * @author xukj
 * @date 2018/8/15
 * @description 首页展示组件
 */
import React from 'react';
import PropTypes from 'prop-types';
import { View, Text, TouchableWithoutFeedback, StyleSheet } from 'react-native';

export default class Home extends React.PureComponent {
    static propTypes = {
        message: PropTypes.string,
        onPress: PropTypes.func,
    };

    static defaultProps = {
        onPress: () => {},
    };

    constructor(props) {
        super(props);
        this.state = { visible: false, text: '' };
    }

    componentDidMount() {}

    render() {
        return (
            <View style={styles.page}>
                <Text>{this.props.message}</Text>
                <TouchableWithoutFeedback onPress={this.props.onPress}>
                    <View>
                        <Text style={styles.button}>点击查看图片详情</Text>
                    </View>
                </TouchableWithoutFeedback>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    page: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: 'white'
    },
    button: {
        padding: 8,
    },
});
