---
title: 初识OkHttp
description: 介绍 Android 网络请求框架 OkHttp 的基本概念、请求流程，以及 GET、POST、同步和异步请求的基础写法。
date: 2022-08-19
categories: [技术笔记]
tags: [Android, OkHttp, Java, 网络请求]
---

## 什么是OkHttp

Android网络请求框架之OkHttp，一个处理网络请求的开源框架，是安卓端最火热的轻量级框架,用于替代HttpUrlConnection和Apache HttpClient。

之前个人也写过一篇使用HttpUrlConnection进行网络请求的[博客](https://juejin.cn/post/7087435604400537607)(Android网络通信)。


![image.png](@assets/blog/20220819-初识OkHttp/img1.png)

## 请求流程

       1：首先生成一个OkHttpClient对象
       
       2：用键值对来包装我们的Request请求
    
       3：将请求加入队列生成一个Call管理请求
    
       4：若是同步请求直接执行调用excute方法等待处理返回Response，若为异步则实现Callback回调，在onResponse里获取Response参数

## 代码实现

### 1. 修改权限

首先还是修改配置文件，并添加网络权限

AndroidManifest.xml

为程序添加网络权限：

 ````````xml
 <uses-permission android:name="android.permission.INTERNET"/>
 ````````




```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="bytedance.example.easy_tiktok">

    <uses-permission android:name="android.permission.INTERNET"/>

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.AppCompat.Light.NoActionBar">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
```

### 2. 功能模块


```java
public class MyOkHttp {
    OkHttpClient client;    //OkHttpClient对象
    String url;         //目标网络地址
    Request request;    //请求
    Response response;  //响应
    Call call;
```
###### 不发送POST请求的构造函数
```java
    public MyOkHttp(String url) {
        this.url = url;             //设置目标网络地址

//        创建OKHttpClient类的实例
        client = new OkHttpClient();

//        创建request对象（并设置目标地址、请求方式等）
        request = new Request.Builder()
                .url(url)           //设置目标网络地址
                .get()              //默认为get请求
                .build();

//        调用newCall（）方法创建call对象
        call = client.newCall(request);
    }

```
###### 发送POST请求的构造函数
```java
    public MyOkHttp(String url, RequestBody requestBody) {
        this.url = url;

//        创建OKHttpClient类的实例
        client = new OkHttpClient();

//        创建request对象（并设置目标地址、请求方式等）
        request = new Request.Builder()
                .url(url)           //设置目标网络地址
                .post(requestBody)  //为post请求设置请求体
                .build();

//        调用newCall（）方法创建call对象
        call = client.newCall(request);
    }

```


###### 同步请求
执行请求的操作是阻塞式，直到HTTP响应返回。

如果当前OkHttpClient已经执行了一个同步任务，如果这个任务没有释放锁，那么新发起的请求将被阻塞，直到当前任务释放锁。

同步请求对应OkHttp中的execute()方法。

因为同步请求的方式会阻塞调用线程，所以提交同步请求的操作应放在子线程中执行，否则有可能会引起ANR异常，并且在Android 3.0以后已经不允许在主线程中进行网络操作了。
```java
    public void postRequest(){
//        new Thread(new Runnable() {
//            @Override
//            public void run() {
//                try {
//                    response = call.execute();
//                    String responseData = response.body().string();
//                    Log.d(TAG, "run: "+responseData);
//                }catch (IOException e){
//                    e.printStackTrace();
//                }
//            }
//        });

```

###### 异步请求
执行的是非阻塞式请求，它的执行结果一般都是通过接口回调的方式告知调用者。

同一时刻可以发起多个请求，因为异步请求每一个都是在一个独立的线程，由线程队列管理。
         
异步请求对应OkHttp中的enqueue()方法。

通过Call对象的enqueue(Callback)方法来提交异步请求，异步发起的请求会被加入到队列中通过线程池来执行。

最后通过接口回调的onResponse()方法来接收服务器返回的数据。

```java
        call.enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                Log.d(TAG, "onFailure: ");
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                String responseData = response.body().string();
                Log.d(TAG, "run: "+responseData);
            }
        });
    }

}
```



## 原文链接

稀土掘金-https://juejin.cn/post/7133572227399680036
