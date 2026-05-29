---
title: Android MVVM+RecyclerView
description: 记录在 Android MVVM 架构中结合 DataBinding、ViewModel 和 RecyclerView 实现列表展示的基础流程。
date: 2022-08-21
categories: [技术笔记]
tags: [Android, MVVM, Java]
---

在MVVM框架下实现RecyclerView

## 效果图

![img](@assets/blog/20220821-MVVM+Recy/img1.png)

#### 导入DataBinding引用
首先在app目录下的**build.gradle**文件中，**android**下添加
```groovy
dataBinding{
    enabled = true
}
```
#### 导入RecyclerView引用
首先在app目录下的**build.gradle**文件中，**dependencies**下添加
```groovy
implementation 'androidx.recyclerview:recyclerview:1.1.0'
```
## 代码实现
### 建立实体类
**注意：
    1.继承被观察者模式BaseObservable
    2.使用@Bindable绑定字段
    3.刷新数据（BR自动生成）**

```java
import android.graphics.drawable.BitmapDrawable;
import androidx.databinding.BaseObservable;
import androidx.databinding.Bindable;
import bytedance.example.easy_tiktok.BR;

//    继承被观察者模式BaseObservable
public class MovieItem extends BaseObservable {

    BitmapDrawable img;//图片
    String title;//电影名称
    String score;//豆瓣评分
    String mark;//标记、电影类别
    String timeOn;//上映时间
    String hots;//热度

    public MovieItem(BitmapDrawable img, String title, String score, String mark, String timeOn, String hots) {
        this.img = img;
        this.title = title;
        this.score = score;
        this.mark = mark;
        this.timeOn = timeOn;
        this.hots = hots;
    }

//    使用@Bindable绑定字段
    @Bindable
    public BitmapDrawable getImg() {
        return img;
    }

    public void setImg(BitmapDrawable img) {
        this.img = img;
//        刷新数据（BR自动生成）
        notifyPropertyChanged(BR.img);
    }

    @Bindable
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
        notifyPropertyChanged(BR.title);
    }

    @Bindable
    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
        notifyPropertyChanged(BR.score);
    }

    @Bindable
    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
        notifyPropertyChanged(BR.mark);
    }

    @Bindable
    public String getTimeOn() {
        return timeOn;
    }

    public void setTimeOn(String timeOn) {
        this.timeOn = timeOn;
        notifyPropertyChanged(BR.timeOn);
    }

    @Bindable
    public String getHots() {
        return hots;
    }

    public void setHots(String hots) {
        this.hots = hots;
        notifyPropertyChanged(BR.hots);
    }
}
```

### UI视图XML文件
```xml
<?xml version="1.0" encoding="utf-8"?>
<layout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    xmlns:app="http://schemas.android.com/apk/res-auto">

    <data>
        <variable
            name="vm"
            type="bytedance.example.easy_tiktok.vm.MainVm" />
    </data>

    <androidx.constraintlayout.widget.ConstraintLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent" >
        <androidx.recyclerview.widget.RecyclerView
            android:id="@+id/mainRv"
            android:layout_width="match_parent"
            android:layout_height="match_parent">
        </androidx.recyclerview.widget.RecyclerView>
    </androidx.constraintlayout.widget.ConstraintLayout>
</layout>
```

### 建立RecyclerView 子项
**注意：需要将视图层与数据层进行绑定</br>**
```xml
<?xml version="1.0" encoding="utf-8"?>
<layout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto">
```
**导入实体类**

```xml
    <data>
        <variable
            name="movieItems"
            type="bytedance.example.easy_tiktok.bean.MovieItem" ></variable>
    </data>
```
```xml
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal">
        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal">
            <ImageView
                android:id="@+id/movie_img"
                android:layout_width="100dp"
                android:layout_height="120dp"
                android:layout_marginLeft="10dp"
                android:layout_marginTop="10dp"
                android:layout_marginRight="10dp"
                android:layout_marginBottom="10dp"
                //绑定数据层
                android:src="@{movieItems.img}"/>
            <LinearLayout
                android:layout_width="wrap_content"
                android:layout_height="150dp"
                android:layout_weight="1"
                android:orientation="vertical">
                <TextView
                    android:id="@+id/movie_title"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:layout_marginTop="15dp"
                    android:textSize="20dp"
                    android:textColor="@color/black"
                    android:gravity="center"
                    android:layout_weight="0.8"
                    //绑定数据层
                    android:text="@{movieItems.title}"></TextView>
                <TextView
                    android:id="@+id/movie_score"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:layout_marginTop="5dp"
                    android:textSize="10dp"
                    android:gravity="center"
                    android:layout_weight="0.5"
                    //绑定数据层
                    android:text="@{movieItems.score}"></TextView>
                <TextView
                    android:id="@+id/movie_mark"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:layout_marginTop="5dp"
                    android:textSize="10dp"
                    android:gravity="center"
                    android:layout_weight="0.5"
                    //绑定数据层
                    android:text="@{movieItems.mark}"></TextView>
                <TextView
                    android:id="@+id/movie_timeOn"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:layout_marginTop="5dp"
                    android:textSize="10dp"
                    android:gravity="center"
                    android:layout_weight="0.5"
                    android:text="@{movieItems.timeOn}"></TextView>
                <TextView
                    android:id="@+id/movie_hots"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:layout_weight="5"
                    android:gravity="center"
                    android:textSize="10dp"
                    //绑定数据层
                    android:text="@{movieItems.hots}"></TextView>
            </LinearLayout>
            <Button
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_gravity="center_vertical"
                android:gravity="center"
                android:background="@android:color/holo_red_dark"
                android:layout_marginLeft="15dp"
                android:layout_marginRight="15dp"
                android:text="购票">
            </Button>
        </LinearLayout>
    </LinearLayout>
</layout>
```

### 适配器类
```java
public class MovieAdapter extends RecyclerView.Adapter<MovieAdapter.ViewHolder> {
    private List<MovieItem> lists;
```
**引入数据源**
```java
    public MovieAdapter(List<MovieItem> lists) {
        this.lists = lists;
    }
```
**绑定布局文件**
```java
    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        ViewDataBinding viewDataBinding = DataBindingUtil.inflate(LayoutInflater.from(parent.getContext()), R.layout.movielistitem,parent,false);
        return new ViewHolder(viewDataBinding);
    }
```
**设置数据**
```java
    @Override
    public void onBindViewHolder(MovieAdapter.ViewHolder holder, int position) {
        MovieItem movieItem = lists.get(position);
        holder.viewDataBinding.setVariable(BR.movieItems,movieItem);
        holder.viewDataBinding.executePendingBindings();
    }

    @Override
    public int getItemCount() {
        return lists.size();
    }
```
**自定义ViewHolder内部类**
```java
    public class ViewHolder extends RecyclerView.ViewHolder {

        ViewDataBinding viewDataBinding;

        public ViewHolder(ViewDataBinding viewDataBinding) {
            super(viewDataBinding.getRoot());
            this.viewDataBinding = viewDataBinding;
        }

        public ViewDataBinding getBinding(){
            return viewDataBinding;
        }

    }
}
```
### 数据与视图交互
```java
public class MainActivity extends AppCompatActivity {
    private ActivityMainBinding mainBinding;    //绑定主布局文件
    MainVm mainvm;
    List<MovieItem> items = new ArrayList<>();

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //绑定布局文件
        mainBinding = DataBindingUtil.setContentView(this,R.layout.activity_main);

        mainvm = new ViewModelProvider(this,new ViewModelProvider.NewInstanceFactory()).get(MainVm.class);
        mainBinding.setVm(mainvm);
        mainBinding.setLifecycleOwner(this);

```
**因为是造的假数据，就直接写在了activity中，如果是存放数据的话，应当遵循MVVM，不得在activity中处理数据**
```java
        String t = "标题";
        Random r = new Random();
        for (int i = 0; i < 10; i++) {
            MovieItem item = new MovieItem(null,t+i,"豆瓣评分："+r.nextInt(100),null,"上映时间","热度:"+(r.nextInt(95)*100)+"万");
            items.add(item);
        }
```
```java
        //为视图控件设置adapter，并传入list
        mainBinding.mainRv.setLayoutManager(new LinearLayoutManager(this));
        mainBinding.mainRv.setAdapter(new MovieAdapter(items));

    }
}
```



## 原文链接

稀土掘金-https://juejin.cn/post/7134312961107525640
