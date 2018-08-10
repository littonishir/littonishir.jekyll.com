---
layout:     post
title:      "Toolbar+RecycleView实现透明度渐变效果"
subtitle:   "本文仅代表本人观点，与官方立场无关。"
date:       2017-08-05 12:00:00
author:     "ishir"
header-img: "img/2017-08-05-toolbar-tra.jpg"
header-mask: 0.5
catalog:    true
tags:
    - Android
---
**<font size="5">  </font>** 

## **<font size="5">效果图</font>** 
![渐变.gif](http://upload-images.jianshu.io/upload_images/1074123-318f26f14514f1f0.gif?imageMogr2/auto-orient/strip)

## **<font size="5">布局</font>** 

```xml
<?xml version="1.0" encoding="utf-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@mipmap/pic2442"
    android:fitsSystemWindows="true">


    <android.support.v7.widget.RecyclerView
        android:id="@+id/recyclerview"
        android:layout_width="match_parent"
        android:layout_height="wrap_content" />

    <android.support.v7.widget.Toolbar
        android:id="@+id/toolbar"
        android:layout_width="match_parent"
        android:layout_height="?android:actionBarSize"
        android:background="@color/gary">

        <ImageView
            android:id="@+id/imageview"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginLeft="20dp"
            android:background="@mipmap/back_toolbar"
            android:gravity="center_vertical"
            android:onClick="close" />

        <TextView
            android:id="@+id/textview"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginRight="40dp"
            android:gravity="center"
            android:text="您的好友东方月初已上线"
            android:textColor="@color/white"
            android:textSize="15sp" />
    </android.support.v7.widget.Toolbar>
</FrameLayout>
```

## **<font size="5">代码实现</font>** 

```java
package com.master.gradualchangetoolbar;

import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.RequiresApi;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private RecyclerView mRecyclerView;
    private Toolbar mToolbar;
    private TextView textview;
    private ImageView imageview;
    private List<Object> mTexts = new ArrayList<>();
    private Double mDistanceY = 0.0;
    private MainActivity context;
    private TextAdapter mAdapter;
    private Window window;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //透明状态栏
        window = getWindow();
        transparentStatusBar(window);
        initData();
        //初始化控件
        initView();
    }

    private void initData() {
        Object[] arrayItemText = new Object[]{"过了许久，在喧扰的人来人往中", "在酒吧喧闹的噪声、宣言和粗俗的玩笑声中", "我们俩，知足、快乐地坐在一起", "说的很少，似乎什么都没说", "仿佛永远分离,却又终身相依,这才是伟大的爱情."};

        addData(arrayItemText, mTexts);
    }

    private void addData(Object[] objarray, List<Object> mlist) {
        for (int i = 0; i < 25; i++) {
            mlist.add((objarray[i % 5]));
        }
    }

    private void initView() {
        context = this;
        mRecyclerView = (RecyclerView) findViewById(R.id.recyclerview);
        mToolbar = (Toolbar) findViewById(R.id.toolbar);
        textview = (TextView) findViewById(R.id.textview);
        imageview = (ImageView) findViewById(R.id.imageview);
        mRecyclerView.setLayoutManager(new LinearLayoutManager(this));
        // 设置适配器
        mRecyclerView.setAdapter(mAdapter = new TextAdapter(context, mTexts));
        // 添加RecycleView的滑动监听
        mRecyclerView.addOnScrollListener(new RecyclerView.OnScrollListener() {
            @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
            @Override
            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
                //滑动的距离
                mDistanceY += dy;
                //toolbar的高度
                int toolbarHeight = mToolbar.getBottom();
                //当滑动的距离 <= toolbar高度的时候，改变Toolbar背景色的透明度，达到渐变的效果
                if (mDistanceY <= toolbarHeight) {
                    if (Build.VERSION.SDK_INT >= 21) {
                        //设置状态栏透明
                        window.setStatusBarColor(Color.TRANSPARENT);
                    }
                    double d = mDistanceY / toolbarHeight;
                    int i = Double.valueOf(d * 255).intValue();    //i 有可能小于0
                    mToolbar.setAlpha(Math.max(i, 0));   // 0~255 透明度
                    textview.setAlpha((float) Math.max(d, 0));
                    imageview.setAlpha((float) Math.max(d, 0));
                } else {
                    if (Build.VERSION.SDK_INT >= 21) {
                        window.setStatusBarColor(getResources().getColor(R.color.gary));
                    }
                }
            }
        });
    }

    public static void transparentStatusBar(Window window) {
        /**
         * 透明状态栏方法(SDK_INT >= 21)
         * */
        if (Build.VERSION.SDK_INT >= 21) {
            View decorView = window.getDecorView();
            int option = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                    | View.SYSTEM_UI_FLAG_LAYOUT_STABLE;
            decorView.setSystemUiVisibility(option);
            window.setStatusBarColor(Color.TRANSPARENT);
        }
    }

    public void close(View view) {
        finish();
    }
}
```
[源码下载](https://github.com/littonishir/GradualChangeToolbar.git)