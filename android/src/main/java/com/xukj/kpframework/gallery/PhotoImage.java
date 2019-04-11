package com.xukj.kpframework.gallery;

import android.os.Parcel;
import android.os.Parcelable;

/**
 * 图片对象
 */
public class PhotoImage implements Parcelable {

    private String uri;
    private float minScale = 0;
    private float maxScale = 0;
    private boolean debug = false;

    public static PhotoImage withUri(String uri) {
        PhotoImage image = new PhotoImage();
        image.uri = uri;
        return image;
    }

    public PhotoImage() {
        super();
    }

    public PhotoImage(Parcel parcel) {
        uri = parcel.readString();
        minScale = parcel.readFloat();
        maxScale = parcel.readFloat();
        debug = parcel.readByte() != 0;
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel parcel, int flags) {
        parcel.writeString(uri);
        parcel.writeFloat(minScale);
        parcel.writeFloat(maxScale);
        parcel.writeByte((byte)(debug ? 1 : 0));
    }

    public static final Creator<PhotoImage> CREATOR = new Creator<PhotoImage>() {
        @Override
        public PhotoImage createFromParcel(Parcel parcel) {
            return new PhotoImage(parcel);
        }

        @Override
        public PhotoImage[] newArray(int i) {
            return new PhotoImage[i];
        }
    };

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public float getMinScale() {
        return minScale;
    }

    public void setMinScale(float minScale) {
        this.minScale = minScale;
    }

    public float getMaxScale() {
        return maxScale;
    }

    public void setMaxScale(float maxScale) {
        this.maxScale = maxScale;
    }

    public boolean isDebug() {
        return debug;
    }

    public void setDebug(boolean debug) {
        this.debug = debug;
    }
}
