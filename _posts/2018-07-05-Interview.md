---
layout:     post
title:      "Android四大组件 "
subtitle:   "Small scale chopper"
date:       2018-07-05 09:28:06
author:     "ishir"
header-img: "img/2018-05-24-ishir.jpg"
header-mask: 0.5
catalog:    true
tags:
    - Android
---
**<font size="5">  </font>**
<!--上标:º ¹ ² ³ ⁴⁵ ⁶ ⁷ ⁸ ⁹ ⁺ ⁻ ⁼ ⁽ ⁾ ⁿ ′ ½下标:₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉ ₊ ₋ ₌ ₍ ₎-->

# Android四大组件

## Activity

### 1.什么是Activity?

Activity即用户看到的界面,Android四大组件之,可与用户进行交互.

### 2. Activity的生命周期
onCreate 	onStart	 onResume	 onPause 	onStop	 onDestory 补充两个与生命周期相关的重要方法 onSaveInstanceState与onRestoreInstanceState方法

![](https://upload-images.jianshu.io/upload_images/944365-76db333cbf9ace12.png?imageMogr2/auto-orient/)

这里补充一下fragment生命周期:onAttach onCreate onCreateView onCreateActivity  onStart onResume onPause onStop onDestoryView
onDestory onDetach

![](https://upload-images.jianshu.io/upload_images/944365-cc85e7626552d866.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/317)

### 3. Activity的启动模式

1 Standard模式

Standard模式是Android的默认启动模式,Activity可以有多个实例,每次启动Activity,无论任务栈中是否已经有这个Activity的实例,系统都会创建一个新的Activity实例.

2 SingleTop模式

SingleTop模式和standard模式非常相似,主要区别就是当一个singleTop模式的Activity已经位于任务栈的栈顶,再去启动它时,不会再创建新的实例,如果不位于栈顶,就会创建新的实例.

3 SingleTask模式

SingleTask模式的Activity在同一个Task栈内只有一个实例,如果Activity已经位于栈顶,系统不会创建新的Activity实例,和singleTop模式一样.但Activity已经存在但不位于栈顶时,系统就会把该Activity移到栈顶,并把它上面的activity出栈

4 SingleInstance模式

singleInstance模式也是单例的,但和singleTask不同,singleTask只是任务栈内单例,系统里是可以有多个singleTask Activity实例的,而singleInstance Activity在整个系统里只有一个实例.启动一个singleInstanceActivity时,系统会创建一个新的任务栈,并且这个任务栈只有他一个Activity.

## BroadcastReceiver
[原文请戳](https://www.jianshu.com/p/ca3d87a4cdf3)

### 1.定义
BroadcastReceiver即广播接收者,Android四大组件之一,是一个全局的监听器.

> Android 广播分为两个角色:广播发送者\广播接收者.

### 2.作用
监听 / 接收 应用 App 发出的广播消息,并做出响应.

### 3. 应用场景
1. 多线程通信
2. 不同组件间的通信(含 :应用内 / 不同应用之间)
3. 与 Android 系统在特定情况下的通信(如:电话呼入时\耳机拔插时)

### 4.实现原理
广播采用的是观察者模式,基于消息的 发布/订阅 事件模型.

### 5. 使用
广播的注册分为两种

- 静态注册
- 动态注册

**静态注册广播代码演示**

1.在清单文件中注册静态广播

```
    <application>
 		<receiver android:name=".JavaVersion.broadcastreceiver.StaticBroadcastReceiver">
            <intent-filter>
                <action android:name="ishir" />
            </intent-filter>
        </receiver>  
    </application>
   
```
2.创建广播接收者

```
public class StaticBroadcastReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        String info = intent.getStringExtra("info");
        Toast.makeText(context, info + " 我接收到静态注册的广播了----来自Java的输出", Toast.LENGTH_SHORT).show();
    }
}
```
3.发送广播

```
	Intent intent = new Intent();
    intent.setAction("ishir");
    intent.putExtra("info", "ishir");
    sendBroadcast(intent);
```

**动态注册广播代码演示**

1.创建广播接收者

```
public class DynamicBroadcastReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        String info = intent.getStringExtra("info");
        Toast.makeText(context, info + " 我接收到动态注册的广播了----来自Java的输出", Toast.LENGTH_SHORT).show();
    }
}
```

2.代码中动态注册广播

```
    @Override
    protected void onResume() {
        super.onResume();
        // 1. 实例化BroadcastReceiver子类
        dynamicBroadcastReceiver = new DynamicBroadcastReceiver();
        IntentFilter intentFilter = new IntentFilter();
        // 2. 设置接收广播的类型
        intentFilter.addAction("com.littonishir");
        // 3. 动态注册:调用Context的registerReceiver()方法
        registerReceiver(dynamicBroadcastReceiver, intentFilter);

    }

    @Override
    protected void onPause() {
        super.onPause();
        unregisterReceiver(dynamicBroadcastReceiver);
    }
```

3.发送广播

```
	  Intent dynamic_intent = new Intent();
      dynamic_intent.setAction("com.littonishir");
      dynamic_intent.putExtra("info", "ishir");
      sendBroadcast(dynamic_intent);
```


> 注意:动态广播最好在Activity 的 onResume()注册\onPause()注销.

为什么呢?
> 不在onCreate() & onDestory() 或 onStart() & onStop()注册\注销是因为:
当系统内存不足回收Activity占用的资源时,Activity在执行完onPause()方法后就会被销毁,生命周期方法onStop(),onDestory()不会执行.此时广播还未注销,从而导致内存泄露.但是,onPause()一定会被执行,从而保证了广播在App死亡前一定会被注销,从而防止内存泄露.

**本地广播代码演示**

前面的广播全部属于系统广播(可被任意程序接收,可接收来自任意程序的广播),这容易引起安全问题. 
为解决广播安全问题,Android引入一套本地广播机制(本地广播只在应用程序内部传递). 
本地广播主要使用一个LocalBroadcastManager进行管理(提供了发送广播和注册广播接收器的方法)

```
public class LocalBroadcastActivity extends AppCompatActivity {
    private IntentFilter intentFilter;
    private LocalReceiver localReceiver;
    private LocalBroadcastManager localBroadcastManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_local_broadcast);
        //1. 获取LocalBroadcastManager的实例
        localBroadcastManager = LocalBroadcastManager.getInstance(this);
        //2. 创建IntentFilter并设置接收广播的类型
        intentFilter = new IntentFilter();
        intentFilter.addAction("com.littonishir.androidfantasticfour");
    }

    @Override
    protected void onResume() {
        super.onResume();
        //3. 动态注册本地广播监听器
        localReceiver = new LocalReceiver();
        localBroadcastManager.registerReceiver(localReceiver, intentFilter);
    }

    @Override
    protected void onPause() {
        super.onPause();
        localBroadcastManager.unregisterReceiver(localReceiver);
    }

    public void send(View view) {
        //发送本地广播
        Intent intent = new Intent("com.littonishir.androidfantasticfour");
        localBroadcastManager.sendBroadcast(intent);
    }
}

// 创建广播接收器
class LocalReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        Toast.makeText(context, "received local broadcast", Toast.LENGTH_SHORT).show();
    }
}
```

## Service

### 1.定义
Service(服务),Android四大组件之一,可以在后台执行长时间运行且不提供UI界面.

> Android 广播分为两个角色:广播发送者\广播接收者.

### 2.作用
可以与组件绑定进行交互,进程间通信(IPC).例如,服务能够在后台处理网络事物\播放音乐\执行文件I/O或者与ContentProvider通信.

### 3. Service的分类
![](https://upload-images.jianshu.io/upload_images/944365-ab970a084ab936c2.png?imageMogr2/auto-orient/)

详细介绍

![](https://upload-images.jianshu.io/upload_images/944365-dec9e6e2428f41f0.png?imageMogr2/auto-orient/)

### 4. 生命周期

![](https://upload-images.jianshu.io/upload_images/944365-cf5c1a9d2dddaaca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/456)

在Service的生命周期里,常用的有:

4个手动调用的方法

* startService()	启动服务
* stopService()	关闭服务
* bindService()	绑定服务
* unbindService()	解绑服务

5个内部自动调用的方法

* onCreat()	创建服务
* onStartCommand()	开始服务
* onDestroy()	销毁服务
* onBind()	绑定服务
* onUnbind()	解绑服务

### 5. Service 与 Thread的区别
结论:Service 与 Thread 无任何关系

之所以有不少人会把它们联系起来,主要因为Service的后台概念
后台:后台任务运行完全不依赖UI,即使Activity被销毁 / 程序被关闭,只要进程还在,后台任务就可继续运行

二者的异同

![](https://upload-images.jianshu.io/upload_images/944365-ad8ff95781d19451.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700)
>注意:一般会将 Service 和 Thread联合着用,即在Service中再创建一个子线程去处理耗时操作

```
@Override  
public int onStartCommand(Intent intent, int flags, int startId) {  
//新建工作线程
    new Thread(new Runnable() {  
        @Override  
        public void run() {  
            // 开始执行后台任务  
        }  
    }).start();  
    return super.onStartCommand(intent, flags, startId);  
}
```

### 6. 使用

**本地service的基本使用**


1.新建一个MyService继承自Service,并重写父类的onCreate()\onStartCommand()和onDestroy()方法

```
public class MyService extends Service {

    public static final String TAG = "MyService";
    private MyBinder mBinder = new MyBinder();

    @Override
    public void onCreate() {
        super.onCreate();
        Log.e(TAG, "onCreate() executed");

    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.e(TAG, "onStartCommand() executed");
        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.e(TAG, "onDestroy() executed");
    }
//2.并复写onBind
    @Override
    public IBinder onBind(Intent intent) {
        return mBinder;
    }
//1.创建MyBinder使Service和Activity通信
    class MyBinder extends Binder {

        public void startDownload() {
            Log.e(TAG, "startDownload() executed");
            // 执行具体的下载任务
        }
    }
}
```

2.每一个Service都必须在AndroidManifest.xml中注册(注意在application标签内)

```
        <service android:name=".JavaVersion.service.MyService" />

```

3.我们通过如下方法对service进行操作

*  startService : 开启服务
*  stopService : 停止服务
*  bindService : 绑定服务
*  unbindService : 解绑服务


```
@Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.tv_start:
                Intent startIntent = new Intent(this, MyService.class);
                startService(startIntent);
                break;
            case R.id.tv_stop:
                Intent stopIntent = new Intent(this, MyService.class);
                stopService(stopIntent);
                break;
            case R.id.tv_bind:
                Intent bindIntent = new Intent(this, MyService.class);
                bindService(bindIntent, connection, BIND_AUTO_CREATE);
                break;
            case R.id.tv_unbind:
                unbindService(connection);
                break;
            default:
                break;
        }
    }
```


**远程Service的使用**

### **Service端代码**

1.创建远程service和本地service一样继承自Service

```
public class RemoteService extends Service {

    public static final String TAG = "RemoteService";

    @Override
    public void onCreate() {
        super.onCreate();
        Log.e(TAG, "onCreate() executed");
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.e(TAG, "onStartCommand() executed");
        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.e(TAG, "onDestroy() executed");
    }

    @Override
    public IBinder onBind(Intent intent) {
        return mBinder;
    }
//自己定义的aidl接口的实现,这里为什么这样写呢?
//因为Stub其实就是Binder的子类,所以在onBind()方法中可以直接返回Stub的实现就好了
    IMyAidlInterface.Stub mBinder = new IMyAidlInterface.Stub() {

        @Override
        public int plus(int a, int b) {
            return a + b;
        }

        @Override
        public String toUpperCase(String str) {
            if (str != null) {
                return str.toUpperCase();
            }
            return null;
        }
    };
}
```

2.在那个清单文件中proces配置成remote 

```
     <service android:name=".JavaVersion.service.RemoteService"
            android:process=":remote">
```
如何才能让Activity与一个远程Service建立关联呢?这就要使用AIDL来进行跨进程通信了(IPC)

AIDL(Android Interface Definition Language)是Android接口定义语言的意思,它可以用于让某个Service与多个应用程序组件之间进行跨进程通信

3.首先需要新建一个AIDL文件,在这个文件中定义好Activity需要与Service进行通信的方法.这个时候同步一下工程,然后修改RemoteService中的代码在里面实现我们刚刚定义好的IMyAidlInterface接口

```
interface IMyAidlInterface {

    int plus(int a, int b);

    String toUpperCase(String str);
}
```

4.修改请单文件,为我们的service添加action

```
<service android:name=".JavaVersion.service.RemoteService"
            android:process=":remote">
            <intent-filter>
                <action android:name="com.littonishir.servicetest.IMyAidlInterface"/>
            </intent-filter>
        </service>
```

### **Client端代码**

1.新建项目然后将aidl文件夹直接拷贝到新建工程的main目录下,你没有听错直接拷贝直接拷贝不要不相信自己的眼睛就是简单.

2.这时候我们去绑定服务首先创建ServiceConnection.

```
    private IMyAidlInterface iMyAidlInterface;

    private ServiceConnection connection = new ServiceConnection() {

        @Override
        public void onServiceDisconnected(ComponentName name) {
        }

        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            iMyAidlInterface = IMyAidlInterface.Stub.asInterface(service);
            try {
                int result = iMyAidlInterface.plus(50, 50);
                String upperStr = iMyAidlInterface.toUpperCase("comes from ClientTest");
                Log.e("TAG", "result is " + result);
                Log.e("TAG", "upperStr is " + upperStr);
            } catch (RemoteException e) {
                e.printStackTrace();
            }
        }
    };

```

3.绑定服务

此时在你的手机上装上service端 在装上client端,点击绑定服务时看LogCat是不是有日志输出呀,恭喜你大功告成啦!

```
 Intent intent = new Intent();
        //设置Action
        intent.setAction("com.littonishir.servicetest.IMyAidlInterface");
        //设置包名
        intent.setPackage("com.littonishir.androidfantasticfour");
        bindService(intent, connection, BIND_AUTO_CREATE);
```

## ContentProvider

### 1.定义
ContentProvider内容提供者 Android的四大组件之一

### 2.作用
进程间 进行数据交互和共享,即跨进程通信.

### 3.原理
ContentProvider的底层原理是Android中的Binder机制

## Binder


IPC:Inter Process Communication
### 1. Binder是什么?
1. 从机制角度来说Binder是一种android中实现跨进程通信(IPC)的方式
2. 从模型结构组成来说Binder是一种虚拟的物理驱动,连接Service Client ServiceManger 进程
3. 从代码实现的角度来说Binder是一个类实现了IBinder接口,将Binder机制模型在Android中以代码的形式具体实现

### 2. 知识储备

在说Binder前,我们先了解一些Linux的基础知识--->进程空间划分

- 一个进程空间分为 用户空间和内核空间(Kernel),即进程内用户和内核是隔离开来的.

- 二者有什么区别呢:
	1. 进程间,用户空间数据不可共享
	2. 进程间,内核空间数据可共享
	3. 注:所有进程共用1个内核空间

- 进程内用户空间和内核空间进行交互需要通过系统调度.主要通过调用函数
	1. copy\_from\_user():将用户空间的数据拷贝到内核空间
	2. copy\_to\_user():将内核空间的数据拷贝到用户空间
	3. 注:传统的跨进程通信需拷贝数据2次,但Binder机制只需1次.

![](https://upload-images.jianshu.io/upload_images/944365-12935684e8ec107c.png?imageMogr2/auto-orient/)


### 3. Binder跨进程通信机制

- 工作流程
 1. Binder驱动创建一块接受缓存区
 2. 实现地址映射关系,根据需映射接收进程信息,实现内核缓存区和接收进程用户空间地址同时映射到同一个共享接收缓存区中
 3. 需要发送数据的进程通过系统调用copy\_from\_user()发送数据到虚拟内存区域(数据拷贝1次)
 4. 由于内核缓存区和接收进程的用户空间地址存在映射关系(同时映射到Binder创建的缓存接收缓存区),即实现跨进程通信.
 
![](https://upload-images.jianshu.io/upload_images/944365-d3c78b193c3e8a38.png?imageMogr2/auto-orient/)


















