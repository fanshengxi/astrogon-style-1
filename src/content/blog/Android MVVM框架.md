---
title: Android-MVVM框架
description: 介绍 Android MVVM 架构的基本概念、核心思想，以及 View、ViewModel、Model 各层的职责划分。
date: 2022-08-20
categories: [技术笔记]
tags: [Android, Java, MVVM, 架构模式]
---

MVVM框架是有由来的，这个其实说来话长了，还得从最开始的Android 视图、UI来说起。最开始的时候Android编写页面，里面的业务逻辑和UI处理都在Activity中，很符合上面这张图。

![无标题.png](@assets/blog/20220820-MVVM框架/img1.png)


## 什么是MVVM
Model:实体模型
View:对应于Activity和XML，负责View的绘制以及用户与UI间的交互。
ViewModel:负责完成View与Model间的交互以及业务逻辑。
**MVVM利用数据绑定(DataBinding)、依赖属性(Dependency Property)、命令(Command)、路由事件(Routed Event)等新特性，打造了一个更加灵活高效的架构。**

### MVVM的核心思想： 数据驱动UI
在常规的开发模式中，数据变化需要更新UI的时候，需要先获取UI控件的引用，然后再更新UI。获取用户的输入和操作也需要通过UI控件的引用。在MVVM中，这些都是通过数据驱动来自动完成的，数据变化后会自动更新UI，UI的改变也能自动反馈到数据层，数据成为主导因素。这样MVVM层在业务逻辑处理中只要关心数据，不需要直接和UI打交道，在业务处理过程中简单方便很多。
在MVVM中，数据发生变化后,在数据是线程安全的情况下，我们在工作线程直接修改ViewModel的数据即可，不用再考虑要切到主线程更新UI了，这些事情相关框架都帮我们做了。

## MVVM框架各层的职责
![无标题.png](@assets/blog/20220820-MVVM框架/img2.png)
### View

View层做的就是和UI相关的工作，我们只在XML、Activity和Fragment写View层的代码，View层不做和业务相关的事，也就是我们在Activity不写业务逻辑和业务数据相关的代码，更新UI通过数据绑定实现，尽量在ViewModel里面做（更新绑定的数据源即可），Activity要做的事就是初始化一些控件（如控件的颜色、样式等属性），View层可以提供更新UI的接口（但是我们更倾向所有的UI元素都是通过数据来驱动更改UI），View层可以处理事件（但是我们更希望UI事件通过Command来绑定）。**简单地说：View层不做任何业务逻辑、不涉及操作数据、不处理数据，UI和数据严格的分开。**

### ViewModel

**ViewModel层做的事情刚好和View层相反，ViewModel只做和业务逻辑和业务数据相关的事，不做任何和UI相关的事情**，ViewModel 层不会持有任何控件的引用，更不会在ViewModel中通过UI控件的引用去做更新UI的事情。ViewModel就是专注于业务的逻辑处理，做的事情也都只是对数据的操作（这些数据绑定在相应的控件上会自动去更改UI）。同时DataBinding框架已经支持双向绑定，让我们可以通过双向绑定获取View层反馈给ViewModel层的数据，并对这些数据上进行操作。关于对UI控件事件的处理，我们也希望能把这些事件处理绑定到控件上，并把这些事件的处理统一化，为此我们通过BindingAdapter对一些常用的事件做了封装，把一个个事件封装成一个个Command，对于每个事件我们用一个ReplyCommand去处理就行了，ReplyCommand会把你可能需要的数据带给你，这使得我们在ViewModel层处理事件的时候只需要关心处理数据就行了。**再强调一遍：ViewModel 不做和UI相关的事。**

### Model

Model层最大的特点是被赋予了数据获取的职责，与我们平常Model层只定义实体对象的行为截然不同。实例中，数据的获取、存储、数据状态变化都是Model层的任务。Model包括实体模型（Bean）、Retrofit的Service ，获取网络数据接口，本地存储（增删改查）接口，数据变化监听等。Model提供数据获取接口供ViewModel调用，经数据转换和操作并最终映射绑定到View层某个UI元素的属性上。



## 原文链接

稀土掘金-https://juejin.cn/post/7133941263404892190
