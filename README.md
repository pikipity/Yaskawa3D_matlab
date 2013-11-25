Yaskawa 3D model (Matlab)
===============

![3D Yaskawa Robot Arm (Matlab)](https://lh3.googleusercontent.com/-ty3uhBgoYjY/UpL6TaePauI/AAAAAAAABX4/l2egtnPhFfA/s720/%25E5%25B1%258F%25E5%25B9%2595%25E5%25BF%25AB%25E7%2585%25A7%25202013-11-25%2520%25E4%25B8%258B%25E5%258D%25883.19.34.png)

使用 Matlab 建立了一个 6 自由度的 3D Yaskawa 模型演示。主要参考了 Don Riley 的 3D PUMA 演示文件，具体介绍可以看[这里](http://pikipity.github.io/blog/3d-puma-demo.html)。

使用 AutoCAD 建立的模型，文件在 ```model``` 文件夹中，用 ```stlread.m``` 函数将其导入 Matlab 中，然后用 Matlab 自带的 ```patch``` 函数进行绘制。

此演示中包括了六轴的基本转动（kinematics）和根据目标位置进行六轴的控制（inverse kinematics）。Inverse kinematics 使用的是 simulink 进行计算，所以第一次运行的时候会比较慢，请耐心等待（Mac 可能需要打开 X11）。

此演示中包括两个 demo，一个是控制机器臂绘制 “UM” 字样，一个是控制控制机器臂绘制一个圆形，由于圆形是由多个直线进行连接而成，结果可能并不圆。

下面是此演示的三段视频地址：

1. [基本功能演示视频](http://v.youku.com/v_show/id_XNjM5NTA3ODgw.html?f=20972771)
2. [Demo 1 演示视频](http://v.youku.com/v_show/id_XNjM5NTA4Mjk2.html?f=20972771)
3. [Demo 2 演示视频](http://v.youku.com/v_show/id_XNjM5NTA4NDY0.html?f=20972771)
