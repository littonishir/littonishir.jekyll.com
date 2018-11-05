---
layout:     post
title:      "umeng-upush"
subtitle:   "你的第一次也未免太多了点."
date:       2018-11-05 16:38:13
author:     "ishir"
header-img: "img/2018-08-10-ishir2.jpg"
header-mask: 0.5
catalog:    true
tags:
    - umeng
---
**<font size="5">  </font>**
<!--上标:º ¹ ² ³ ⁴⁵ ⁶ ⁷ ⁸ ⁹ ⁺ ⁻ ⁼ ⁽ ⁾ ⁿ ′ ½下标:₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉ ₊ ₋ ₌ ₍ ₎
[<font size="2" color="#006666">包级函数</font>](#package)<p id = "package"></p>-->

## 友盟推送极速集成

### 创建应用

#### 1. 使用你应用包名在友盟后台创建应用

![](http://dev.umeng.com/system/resources/W1siZiIsIjIwMTcvMTAvMjUvMTFfMjVfMzVfNjY5X18yLnBuZyJdXQ/%E5%88%9B%E5%BB%BA%E5%BA%94%E7%94%A82.png)

#### 2. 获取应用对应的AppKey和Umeng Message Secret

![](http://dev.umeng.com/system/resources/W1siZiIsIjIwMTcvMTAvMjUvMTFfMjVfNDVfMTM0X2FwcGtleV8ucG5nIl1d/appkey%E6%9B%BF%E6%8D%A2.png)

#### 3. 导入PushSDK

1.app模块的build.gradle配置脚本

```gradle
    implementation 'com.umeng.sdk:common:1.5.3'
    implementation 'com.umeng.sdk:utdid:1.1.5.3'
    implementation 'com.umeng.sdk:push:4.2.0'
```
2.工程目录下的build.gradle添加如下配置

```gradle
	allprojects {
    	repositories {
          	mavenCentral()
    	}
	}
```

### 初始化PushSDK

1.必须在工程的自定义Application类的 onCreate() 方法中调用基础组件包提供的初始化函数.(

```java
public class App extends Application {
    private static final String TAG = App.class.getName();
    public static final String UPDATE_STATUS_ACTION = "com.umeng.message.example.action.UPDATE_STATUS";

    @Override
    public void onCreate() {
        super.onCreate();
        //初始化友盟推送
        UMConfigure.setLogEnabled(true);
        UMConfigure.init(this, "5bdffa42f1f556039c000317", "Umeng", UMConfigure.DEVICE_TYPE_PHONE,
                "de529fa0779ce3ecbb3aa6d888993205");
        initUpush();
    }

    private void initUpush() {
        PushAgent mPushAgent = PushAgent.getInstance(this);
        mPushAgent.setNotificationPlaySound(MsgConstant.NOTIFICATION_PLAY_SDK_ENABLE);
        UmengMessageHandler messageHandler = new UmengMessageHandler() {
            /**
             * 通知的回调方法(通知送达时会回调)
             */
            @Override
            public void dealWithNotificationMessage(Context context, UMessage msg) {
                super.dealWithNotificationMessage(context, msg);
            }

        };
        mPushAgent.setMessageHandler(messageHandler);
        mPushAgent.register(new IUmengRegisterCallback() {
            @Override
            public void onSuccess(String deviceToken) {
                Log.e(TAG, "device token: " + deviceToken);
                sendBroadcast(new Intent(UPDATE_STATUS_ACTION));
            }

            @Override
            public void onFailure(String s, String s1) {
                sendBroadcast(new Intent(UPDATE_STATUS_ACTION));
            }
        });
    }
}
```

2.在AndroidManifest.xml添加

```xml
 <!-- 友盟消息推送 -->
        <meta-data
            android:name="UMENG_APPKEY"
            android:value="xxxxxxxxxxx" />
        <meta-data
            android:name="UMENG_MESSAGE_SECRET"
            android:value="xxxxxxxxxxx" />
        <meta-data
            android:name="UMENG_CHANNEL"
            android:value="Channel ID" />
```
