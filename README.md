# cicr [![Build Status](https://github-ci.bluerain.io/api/badges/Hentioe/cicr/status.svg)](https://github-ci.bluerain.io/Hentioe/cicr)

内置常用函数的图片托管服务器

## 使用

* 通过 `resize` 函数指定图片的高度和宽度(150x150)

  `https://cicr.bluerain.io/display/demo.jpg?processes=resize.w_150,h_150`

* 保留纵横比例缩放图片(限制宽度为 150， 高度自适应)

  `https://cicr.bluerain.io/display/demo.jpg?processes=resize.w_150`

* 通过 `blur` 函数模糊图片(Sigma: 1)

  `https://cicr.bluerain.io/display/demo.jpg?processes=blur.s_1`

* 通过 `crop` 函数剪裁图片(垂直高度: 100, 水平宽度: 100, 纵坐标: 50, 横坐标: 50)

  `https://cicr.bluerain.io/display/demo.jpg?processes=crop.h_100,w_100,y_50,x_50`

* 使用管道 `|` 组合函数

  `https://cicr.bluerain.io/display/demo.jpg?processes=crop.y_50,w_200,h_150,h_150|blur.s_3.5|resize.w_100`

## TODO

* [ ] 实现主从进程的 processing 状态锁定
* [ ] 实现后台任务，立即响应等待图片
* [ ] 增加 `ascii` 函数将图片转换为文本字符
