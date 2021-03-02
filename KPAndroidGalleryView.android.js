/**
 * @author xukj
 * @date 2019/07/16
 * @description KPAndroidGalleryView
 */
import React from "react";
import PropTypes from "prop-types";
import { NativeEventEmitter, requireNativeComponent } from "react-native";
const resolveAssetSource = require("react-native/Libraries/Image/resolveAssetSource");
const config = {};

// Configuration information
const KPPHOTO_GALLERY_EVENT_ONPAGECHANGED = "KPPHOTO_GALLERY_EVENT_ONPAGECHANGED";
const KPPHOTO_GALLERY_EVENT_ONCLOSEPRESS = "KPPHOTO_GALLERY_EVENT_ONCLOSEPRESS";
const KPPHOTO_GALLERY_EVENT_ONSINGLETAP = "KPPHOTO_GALLERY_EVENT_ONSINGLETAP";
const NativeEventModule = new NativeEventEmitter(KPAndroidGalleryView);

export default class KPGalleryView extends React.PureComponent {
  static propTypes = {
    options: PropTypes.object,
    onPageChanged: PropTypes.func,
    onClose: PropTypes.func,
    onClosePress: PropTypes.func,
    onSingleTap: PropTypes.func
  };

  static defaultProps = {
    options: {}
  };

  componentDidMount() {
    this.onPageChangedListener = NativeEventModule.addListener(
      KPPHOTO_GALLERY_EVENT_ONPAGECHANGED,
      value => {
        if (this.props.onPageChanged) this.props.onPageChanged(value.index);
      }
    );

    this.onCloseListener = NativeEventModule.addListener(
      KPPHOTO_GALLERY_EVENT_ONCLOSEPRESS,
      () => {
        if (this.props.onClosePress) this.props.onClosePress();
      }
    );
    
    this.onSingleTapListener = NativeEventModule.addListener(
      KPPHOTO_GALLERY_EVENT_ONSINGLETAP,
      () => {
        if (this.props.onSingleTap) this.props.onSingleTap();
      }
    );
  }

  componentWillUnmount() {
    if (this.onPageChangedListener) this.onPageChangedListener.remove();
    if (this.onCloseListener) this.onCloseListener.remove();
    if (this.props.onClose) this.props.onClose();
    if (this.onSingleTapListener) this.onSingleTapListener.remove();
  }

  render() {
    const { style, options, ...restProps } = this.props;
    const values = this._resolveImages(options);
    return (
      <KPAndroidGalleryView style={style} options={values} {...restProps} />
    );
  }

  _resolveImages = options => {
    const values = { ...options };
    let images = values.images;
    if (images) {
      images = images.map(image => {
        const source = resolveAssetSource(image.source);
        return {
          ...image,
          uri: source.uri
        };
      });
      values.images = images;
    }
    return values;
  };
}

const KPAndroidGalleryView = requireNativeComponent(
  "KPGalleryView",
  KPGalleryView,
  config
);
