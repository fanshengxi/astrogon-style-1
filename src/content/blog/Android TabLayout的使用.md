---
title: Android TabLayout的使用
description: 介绍 Android 中结合 TabLayout、ViewPager 和 Fragment 实现滑动标签页的基础用法。
date: 2022-08-22
categories: [技术笔记]
tags: [Android, Java]
---

## 效果图

![img](@assets/blog/20220822-TabLayout的使用/img1.png)

**TabLayout**一般是结合**ViewPager+Fragment**的使用实现滑动的标签选择器。

## 代码实现
### 1. 在布局文件中添加ViewPager控件和TabLayout控件
```xml
<androidx.viewpager.widget.ViewPager
    android:id="@+id/vp"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>

<com.google.android.material.tabs.TabLayout
    android:id="@+id/tablayout"
    android:layout_width="match_parent"
    android:layout_height="match_parent"/>
```
### 2. 为ViewPager控件编写适配器类(继承androidx包下的FragmentPagerAdapter类)
```java
public class MyFragAdapter extends FragmentPagerAdapter {
```
###### 将传入的tab标签标题数组和装有fragment的链表定义为全局变量
```java
    String titleArr[];
    List<Fragment> mFragmentList;
```
###### 通过构造方法传入相关参数
```java
    public MyFragAdapter(FragmentManager fm, List<Fragment> list, String[] titleArr) {
        super(fm);
        this.mFragmentList = list;
        this.titleArr = titleArr;
    }
```
###### 重写相关方法
```java
    @Override
    public Fragment getItem(int position) {
        return mFragmentList.get(position);
    }

    @Override
    public int getCount() {
        return mFragmentList != null ? mFragmentList.size() : 0;
    }

    @Override
    public CharSequence getPageTitle(int position) {
        return titleArr[position];
    }

    @Override
    public void destroyItem( ViewGroup container, int position, Object object) {
//        super.destroyItem(container, position, object);
    }
```
### 3. 编写三个fragment类（继承自Fragment类）
```java
public class VideoFragment extends Fragment {
```
###### 在onCreateView方法中能够加载布局
```java
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        return LayoutInflater.from(getActivity()).inflate(R.layout.videolayout,container,false);
    }
```
###### Fragment类中的onActivityCreated方法相当于Activity中的OnCreate方法
```java
    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
    }
```
##### 以此类推，编写另外两个Fragment类……
**注意：三个fragment需要绑定三个不同的xml布局文件**
### 4. 在Activity中为ViewPager绑定适配器，并将ViewPager与TabLayout进行绑定
###### 设置Tab标签内容的数组以及装有fragment的链表
```java
String[] titles = {"Tab1","Tab2","Tab3"};
List<Fragment> fragmentList = new ArrayList<>();
```
###### 在oncreate方法中填充链表
```java
fragmentList.add(new VideoFragment());
fragmentList.add(new ListFragment());
fragmentList.add(new IndividualFragment());
```
###### 将适配器绑定到ViewPager控件上，并将fragment和标签内容传递进去
###### 然后为TabLayout设置ViewPager
```java
mainBinding.vp.setAdapter(new MyFragAdapter(getSupportFragmentManager(),fragmentList,titles));
mainBinding.tablayout.setupWithViewPager(mainBinding.vp);
```
**写的时候用的是MVVM框架，所以用到了dataBinding，如果有不明白的小伙伴可以去看一下前两篇文章，有初步讲解过MVVM框架。**



## 原文链接

稀土掘金-https://juejin.cn/post/7134652949480865823
