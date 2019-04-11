package com.xukj.kpframework.gallery;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.xukj.kpframework.gallery.R;
import com.xukj.kpframework.gallery.KPGalleryModule;

import java.util.ArrayList;


public class ViewPagerActivity extends AppCompatActivity {

    private ViewPagerBar mHeader;
    private ViewPager mViewPager;

    // gallery图片
    private ArrayList<PhotoImage> mImages = new ArrayList<>();
    private int mPosition = 0;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.view_pager);

        setDefaultConfiguration();
        setHeaderConfiguration();
        setViewPagerConfiguration();
        changeTitle();
    }

    @Override
    public void onBackPressed() {
//        closeActivity();
        super.onBackPressed();
    }


    private void changeTitle() {
        mHeader.getTitleBarTitle().setText((mPosition + 1) + " / " + mImages.size());
    }

    private void setDefaultConfiguration() {
        Bundle bundle = getIntent().getExtras();
        mPosition = bundle.getInt("index");
        mImages = bundle.getParcelableArrayList("images");
    }

    private void setHeaderConfiguration() {
        // 高度
        mHeader = findViewById(R.id.header);
        mHeader.getTitleBarLeftBtn().setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                closeActivity();
            }
        });
    }

    private void setViewPagerConfiguration() {
        // 分页
        mViewPager = findViewById(R.id.horizontal_pager);
        mViewPager.setAdapter(new ScreenSlidePagerAdapter(getSupportFragmentManager()));
        mViewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {
                mPosition = position;

                WritableMap params = Arguments.createMap();
                params.putInt(KPGalleryModule.KPPHOTO_GALLERY_KEY_INDEX, position);
                sendEventToJS(KPGalleryModule.KPPHOTO_GALLERY_EVENT_ONPAGECHANGED, params);

                changeTitle();
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });

        if (mImages.size() > mPosition) {
            mViewPager.setCurrentItem(mPosition);
        }
    }

    /**
     * 关闭当前界面
     */
    private void closeActivity() {
        // 关闭当前界面
        sendEventToJS(KPGalleryModule.KPPHOTO_GALLERY_EVENT_ONCLOSE, null);
        finish();
    }

    /**
     * 发送JS通知
     *
     * @param name   key
     * @param params 数据
     */
    private void sendEventToJS(String name, @Nullable WritableMap params) {
        ReactContext context = KPGalleryModule.context;
        context.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit(name, params);
    }

    private class ScreenSlidePagerAdapter extends FragmentStatePagerAdapter {
        ScreenSlidePagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            ViewPagerFragment fragment = new ViewPagerFragment();
            fragment.setImage(mImages.get(position));
            return fragment;
        }

        @Override
        public int getCount() {
            return mImages.size();
        }
    }
}
