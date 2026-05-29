---
title: Android Fragment
description: 介绍 Android Fragment 的概念、生命周期，以及静态和动态添加 Fragment 的两种方式。
date: 2022-08-23
categories: [技术笔记]
tags: [Android, Java]
---

## 什么是Fragment
Fragment译为“碎片”，是Android 3.0（API 11）提出的，最开始是为了适配大屏的平板。</br>
Fragment看起来和Activity一样，是一个用户界面。可以结合多个Fragments到一个activity中来构建一个有多方面功能的UI，还可以重用同一个Fragment在多个activities中。Fragment可以当成是activity的一个组件，每个Fragment有单独的生命周期，可以在activity运行时进行添加和移除Fragment。因此，相比较于activity，Fragment更加轻量级，更加灵活。</br>

## Fragment的基本生命周期

![screenshot-20220823-211233.png](@assets/blog/20220823-fragment/img1.png)

（1）onAttach：Fragment和Activity相关联时调用，可以通过该方法获取Activity引用。</br>
（2）onCreate：Fragment被创建时调用。</br>
（3）onCreateView：创建Fragment的布局。</br>
（4）onActivityCreated：当关联的Activity完成onCreate方法后调用。</br>
（5）onStart：当Fragment可见时调用。</br>
（6）onResume：当Fragment可见且可交互时调用。</br>
（7）onPause：当Fragment可见但不可交互时调用。</br>
（8）onStop：当Fragment不可见且不可交互时调用。</br>
（9）onDestroyView：当Fragment的视图结构从Fragment中移除时调用。</br>
（10）onDestroy：销毁Fragment时调用。</br>
（11)onDetach：移除与Activity时调用。</br>

## 将Fragment加入Activity的两种方式

### **静态使用**
**使用fragment标签，将Fragment当成普通的控件，直接写在Activity的布局文件中，用布局文件调用Fragment。**

1.  继承Fragment，重写onCreateView设置Fragemnt的布局文件；
2.  在Activity的布局文件中，使用<Fragment>标签，属性android:name指定Fragment的全限定类名；
3.  在Activity中声明此Fragment，就当和普通的View一样。

### **动态使用**

1.  继承Fragment，重写onCreateView设置Fragemnt的布局文件;
2.  在Activity的布局文件中，使用<Fragment>标签 ；
3.  在Activity中实例化此Fragment；
4.  获取FragmentManager对象，并通过FragmentManager对象获取FragmentTransaction对象；
5.  通过FragmentTransaction对象的方法将实例化Fragment，添加到在Activity的布局文件的标签容器中。



## 原文链接

稀土掘金-https://juejin.cn/post/7135060954374504455
