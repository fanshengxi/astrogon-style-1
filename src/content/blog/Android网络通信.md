---
title: Android网络通信
description: Android-向Tomcat服务器发送/接受请求。
date: 2022-04-17
categories: [技术笔记]
tags: [Android, Java, Tomcat]
---

## 1.编写APP程序

### 修改配置文件
AndroidManifest.xml

为程序添加网络权限：
````xml
<uses-permission android:name="android.permission.INTERNET"/>
````

````xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.fffffff.mytestapp">

    <uses-permission android:name="android.permission.INTERNET"/>

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:supportsRtl="true"
        android:theme="@style/AppTheme">
        <activity android:name=".WebActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
````
### 然后写java文件

WebActivity.java

````java
package com.example.fffffff.mytestapp;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class WebActivity extends AppCompatActivity {

    String ip;//Tomcat服务器ip地址
    String extra;//接口或其他文件地址

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_web);

        //Http连接需要在子线程中完成，不可以在主线程！！！否则会报错
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    //例如：URL url = new URL("http://192.168.0.110/mydata/MyJson.json");
                    URL url = new URL("http://"+ip+extra);
                    HttpURLConnection http = (HttpURLConnection) url.openConnection();
                    //设置请求方式
                    http.setRequestMethod("POST");
                    //设置请求超时限制
                    http.setConnectTimeout(1000 * 6);
                    http.setDoInput(true);
                    http.setDoOutput(true);
                    //设置请求不使用缓存
                    http.setUseCaches(false);
                    //设置请求文件类型为JSON
                    http.setRequestProperty("Content-Type","application/json;charset=UTF-8");
                    //设置请求Keep-Alive(但HTTP是短连接！)
                    http.setRequestProperty("Connection", "Keep-Alive");
                    http.connect();
                    
                    //若有发送请求！没有发送请求这段可以不写
                    //创建发送请求的json对象
                    JSONObject jsonObject = new JSONObject();
                    //此处自己填充具体的键值对
                    jsonObject.put(Key,Value);
                    //若发送的json请求中含有中文字符，需要设置编码格式为“UTF-8”，否则会出现乱码
                    OutputStreamWriter out = new OutputStreamWriter(http.getOutputStream(),"UTF-8");
                    out.append(jsonObject.toString());
                    //输出流进入缓冲流
                    out.flush();
                    out.close();
                    
                    //log打印出http的回应码，若为200则连接成功，否则失败
                    Log.d("****responsecode****", ""+http.getResponseCode() );
                    if (http.getResponseCode()==200) {
                        //获取输入流
                        InputStream is = http.getInputStream();
                        StringBuilder s_Builder = new StringBuilder();
                        //若接受的json数据中含有中文字符，需要设置编码格式为“UTF-8”，否则会出现乱码
                        BufferedReader bf = new BufferedReader(new InputStreamReader(is,"UTF-8"));
                        String str;
                        while ((str = bf.readLine())!=null){
                            s_Builder.append(str).append("\n");
                        }
                        Log.i("全部数据", "************************ response = " + s_Builder.toString());
                    }
                } catch (MalformedURLException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }).start();

    }
}
````

## 2.启动Tomcat网络服务器
![img1.png](@assets/blog/20220417-android网络通信/img1.png)
出现如上界面则为Tomcat服务器启动完毕

## 3.使用HttpURLConnection建立连接，访问Tomcat服务器，发送json请求并解析接受内容

![QQ截图20220417125047.png](@assets/blog/20220417-android网络通信/img2.png)

![QQ截图20220417125158.png](@assets/blog/20220417-android网络通信/img3.png)
## 4.通过json解析出的网络地址读取图片
### 界面文件
activity_web.xml

``````xml
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_web"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:paddingBottom="@dimen/activity_vertical_margin"
    android:paddingLeft="@dimen/activity_horizontal_margin"
    android:paddingRight="@dimen/activity_horizontal_margin"
    android:paddingTop="@dimen/activity_vertical_margin"
    tools:context="com.example.fffffff.mytestapp.WebActivity">

    <ImageView
        android:id="@+id/web_img"
        android:layout_width="300dp"
        android:layout_height="300dp" />

</RelativeLayout>
``````
### java文件
WebActivity.java

``````java
package com.example.fffffff.mytestapp;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.ImageView;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class WebActivity extends AppCompatActivity {

    Bitmap bitmap;
    String addr;      //图片位置

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_web);

        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    //将url设置为图片位置,例:http://192.168.0.110/skill/ic_launcher.png
                    URL url = new URL("http://"+addr);
                    HttpURLConnection http = (HttpURLConnection) url.openConnection();
                    http.setRequestMethod("POST");
                    http.setConnectTimeout(1000 * 6);
                    http.setDoInput(true);
                    http.setDoOutput(true);
                    http.setUseCaches(false);
                    http.setRequestProperty("Content-Type","application/json;charset=UTF-8");
                    http.setRequestProperty("Connection", "Keep-Alive");
                    http.connect();

                    Log.d("code****", ""+http.getResponseCode() );
                    if (http.getResponseCode()==200) {
                        InputStream is = http.getInputStream();
                        bitmap = BitmapFactory.decodeStream(is);
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                ((ImageView)findViewById(R.id.web_img)).setImageBitmap(bitmap);
                            }
                        });
                    }
                } catch (MalformedURLException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();

    }
}
``````


![QQ截图20220417130449.png](@assets/blog/20220417-android网络通信/img4.png)

*图片有些糊因为设置了imageview的大小，将图片强行拉大了



## 原文链接

稀土掘金-https://juejin.cn/post/7133572227399680036
