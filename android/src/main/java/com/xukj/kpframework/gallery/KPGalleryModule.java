package com.xukj.kpframework.gallery;

import android.content.Intent;
import android.os.Bundle;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.xukj.kpframework.gallery.PhotoImage;
import com.xukj.kpframework.gallery.ViewPagerActivity;


import java.util.ArrayList;


public class KPGalleryModule extends ReactContextBaseJavaModule {


    private static final String KPPHOTO_GALLERY_KEY_IMAGES = "images";
    private static final String KPPHOTO_GALLERY_KEY_MINSCALE = "minScale";
    private static final String KPPHOTO_GALLERY_KEY_MAXSCALE = "maxScale";
    private static final String KPPHOTO_GALLERY_KEY_IMAGE_URI = "uri";
    private static final String KPPHOTO_GALLERY_KEY_DEBUG = "debug";
    private static final String KPPHOTO_GALLERY_KEY_MODE = "mode";

    public static final String KPPHOTO_GALLERY_EVENT_ONPAGECHANGED = "KPPHOTO_GALLERY_EVENT_ONPAGECHANGED";
    public static final String KPPHOTO_GALLERY_EVENT_ONCLOSE = "KPPHOTO_GALLERY_EVENT_ONCLOSE";

    public static final String KPPHOTO_GALLERY_KEY_INDEX = "index";

    // 图片地址
    private ArrayList<PhotoImage> images = new ArrayList<>();
    private int index = 0;
    private float minScale = (float) 0.5;
    private float maxScale = 2;
    private String mode; // 模式
    private boolean debug = false;
    private ReadableMap options;


    public static ReactContext context;
    private ReactContext mReactContext;

    public KPGalleryModule(ReactApplicationContext context) {
        super(context);
        this.mReactContext = context;
        KPGalleryModule.context = context;
    }

    @Override
    public String getName() {
        return "KPGallery";
    }

    /**
     * 开启图片浏览器
     *
     * @param options 配置
     */
    @ReactMethod
    public void showGallery(ReadableMap options) {
        this.options = options;
        setConfiguration(options);

        Intent intent = new Intent();
        intent.setClass(mReactContext, ViewPagerActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        Bundle bundle = new Bundle();
        bundle.putParcelableArrayList("images", images);
        bundle.putInt("index", index);
        intent.putExtras(bundle);
        mReactContext.startActivity(intent);
    }

    private void setConfiguration(final ReadableMap options) {
        index = options.hasKey(KPPHOTO_GALLERY_KEY_INDEX) ? options.getInt(KPPHOTO_GALLERY_KEY_INDEX) : index;
        minScale = options.hasKey(KPPHOTO_GALLERY_KEY_MINSCALE) ? (float) options.getDouble(KPPHOTO_GALLERY_KEY_MINSCALE) : minScale;
        maxScale = options.hasKey(KPPHOTO_GALLERY_KEY_MAXSCALE) ? (float) options.getDouble(KPPHOTO_GALLERY_KEY_MAXSCALE) : maxScale;
        debug = options.hasKey(KPPHOTO_GALLERY_KEY_DEBUG) ? options.getBoolean(KPPHOTO_GALLERY_KEY_DEBUG) : debug;
        mode = options.hasKey(KPPHOTO_GALLERY_KEY_MODE) ? options.getString(KPPHOTO_GALLERY_KEY_MODE) : mode;

        images.clear();
        if (options.hasKey(KPPHOTO_GALLERY_KEY_IMAGES)) {
            setPhotoImages(options.getArray(KPPHOTO_GALLERY_KEY_IMAGES));
        }
    }

    private void setPhotoImages(final ReadableArray images) {

        for (int i = 0; i < images.size(); i++) {
            ReadableMap map = images.getMap(i);
            PhotoImage image = new PhotoImage();

            if (map.hasKey(KPPHOTO_GALLERY_KEY_IMAGE_URI)) {
                image.setUri(map.getString(KPPHOTO_GALLERY_KEY_IMAGE_URI));
            }

            // 设置通用缩放
            image.setMinScale(minScale);
            image.setMaxScale(maxScale);
            image.setDebug(debug);
            image.setMode(mode);

            if (map.hasKey(KPPHOTO_GALLERY_KEY_MINSCALE)) {
                // 如果单个image设置了缩放，则使用单独设置的值
                image.setMinScale((float) map.getDouble(KPPHOTO_GALLERY_KEY_MINSCALE));
            }

            if (map.hasKey(KPPHOTO_GALLERY_KEY_MAXSCALE)) {
                // 如果单个image设置了缩放，则使用单独设置的值
                image.setMaxScale((float) map.getDouble(KPPHOTO_GALLERY_KEY_MAXSCALE));
            }

            if (map.hasKey(KPPHOTO_GALLERY_KEY_MODE)) {
                // 如果单个image设置了模式，则使用单独设置的值
                image.setMode(map.getString(KPPHOTO_GALLERY_KEY_MODE));
            }

            if (map.hasKey(KPPHOTO_GALLERY_KEY_DEBUG)) {
                image.setDebug(map.getBoolean(KPPHOTO_GALLERY_KEY_DEBUG));
            }

            this.images.add(image);
        }
    }
}