package com.xukj.kpframework.gallery;

import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;

import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.request.animation.GlideAnimation;
import com.bumptech.glide.request.target.SimpleTarget;
import com.davemorrissey.labs.subscaleview.ImageSource;
import com.davemorrissey.labs.subscaleview.SubsamplingScaleImageView;
import com.xukj.kpframework.gallery.R;

import java.io.File;

public class ViewPagerFragment extends Fragment {

    private static final String BUNDLE_PHOTOIMAGE = "PhotoImage";

    private PhotoImage image;
    private SubsamplingScaleImageView mImageView;
    private ProgressBar mProgress;
    private TextView mTextView;

    public void setImage(PhotoImage image) {
        this.image = image;
    }

    public PhotoImage getImage() {
        return image;
    }

    public ViewPagerFragment() {
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.view_pager_page, container, false);

        if (savedInstanceState != null) {
            if (image == null && savedInstanceState.containsKey(BUNDLE_PHOTOIMAGE)) {
                image = savedInstanceState.getParcelable(BUNDLE_PHOTOIMAGE);
            }
        }

        mImageView = rootView.findViewById(R.id.imageView);
        mProgress = rootView.findViewById(R.id.loading);
        mTextView = rootView.findViewById(R.id.info);

        loadPhotoImage();

        return rootView;
    }

    @Override
    public void onSaveInstanceState(@NonNull Bundle outState) {
        super.onSaveInstanceState(outState);
        View rootView = getView();
        if (rootView != null) {
            outState.putParcelable(BUNDLE_PHOTOIMAGE, image);
        }
    }

    /**
     * 获取图片
     */
    private void loadPhotoImage() {
        if (image == null || image.getUri() == null) return;

        // 网络图片
        Glide.with(this).load(image.getUri()).downloadOnly(new SimpleTarget<File>() {
            @Override
            public void onLoadStarted(Drawable placeholder) {
                super.onLoadStarted(placeholder);
                mProgress.setVisibility(View.VISIBLE);
                mTextView.setText("");
                mTextView.setVisibility(View.GONE);
            }

            @Override
            public void onLoadFailed(Exception e, Drawable errorDrawable) {
                super.onLoadFailed(e, errorDrawable);
                mProgress.setVisibility(View.GONE);
                mTextView.setText("图片加载失败");
                mTextView.setVisibility(View.VISIBLE);
            }

            @Override
            public void onResourceReady(File resource, GlideAnimation<? super File> glideAnimation) {
                if (image.getMinScale() > 0) {
                    mImageView.setMinimumScaleType(SubsamplingScaleImageView.SCALE_TYPE_CUSTOM);
                    mImageView.setMinScale(image.getMinScale());
                }

                if (image.getMaxScale() > 0) {
                    mImageView.setMaxScale(image.getMaxScale());
                }

                mImageView.setDebug(image.isDebug());
                mImageView.setImage(ImageSource.uri(Uri.fromFile(resource)));
                mTextView.setVisibility(View.GONE);
                mProgress.setVisibility(View.GONE);
            }
        });

    }
}
