/**
 * @author xukj
 * @date 2019/04/10
 * @description Gallery.android
 */
import React from 'react';
import { DeviceEventEmitter, NativeModules } from 'react-native';

const KPPHOTO_GALLERY_EVENT_ONPAGECHANGED = 'KPPHOTO_GALLERY_EVENT_ONPAGECHANGED';
const KPPHOTO_GALLERY_EVENT_ONCLOSE = 'KPPHOTO_GALLERY_EVENT_ONCLOSE';

class GalleryControl {
    constructor() {
        this.onPageChangedListener = DeviceEventEmitter.addListener(
            KPPHOTO_GALLERY_EVENT_ONPAGECHANGED,
            value => {
                if (this.onPageChanged) this.onPageChanged(value.index);
            }
        );

        this.onCloseListener = DeviceEventEmitter.addListener(
            KPPHOTO_GALLERY_EVENT_ONCLOSE,
            () => {
                if (this.onClose) this.onClose();
                // 执行完成后清除
                this.removeOnPageChanged();
                this.removeOnClose();
            }
        );
    }

    addOnPageChanged = (onPageChanged) => {
        this.onPageChanged = onPageChanged;
    };

    removeOnPageChanged = () => {
        this.onPageChanged = null;
    }

    addOnClose = (onClose) => {
        this.onClose = onClose;
    };

    removeOnClose = () => {
        this.onClose = null;
    };
}

const control = new GalleryControl();

function showGallery(options = {}, onPageChanged = null, onClose = null) {
    
}

export default {
    showGallery,
};
