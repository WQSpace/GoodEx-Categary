Content-Type: multipart/form-data; boundary(分隔线)=(可以随便写，ASCII，字母和数字)

## 注释

* userfile => 负责上传文件脚本中的 字段名，开发的时候，可以咨询后端程序员
* filename => 将文件保存在服务器上的文件名称
* Content-Type: 客户端告诉服务器上传文件的文件类型
    - 大类型/小类型
    - text/plain
    - image/jpg
    - image/png
    - image/gif
    - text/html
    - application/json

    - application/octet-stream(8进制流)，如果不想告诉服务器具体的文件类型，可以使用这个 Content-Type

* 注意：每一行末尾需要有一定的 \r\n
* 提示：有些服务器可以直接使用 \n，但是新浪微博如果使用 \n 上传文件，服务器会返回“没有权限”的错误！

## 上传单个文件

--boundary\r\n
Content-Disposition: form-data; name="userfile"; filename="aaa.txt"\r\n
Content-Type: application/octet-stream\r\n\r\n

要上传文件的二进制数据

\r\n--boundary--


## 上传多个文件

* 有些服务器可以在上传文件的同时，提交一些文本内容给服务器
* 典型应用：新浪微博，上传图片的同时，发送一个微博！


Content-Type: multipart/form-data; boundary=boundary

// ------ 以下内容，是提价给服务器的二进制数据格式
--boundary\r\n
Content-Disposition: form-data; name="userfile[]"; filename="aaa.txt"\r\n
Content-Type: application/octet-stream\r\n\r\n

二进制数据
\r\n
--boundary\r\n
Content-Disposition: form-data; name="userfile[]"; filename="aaa副本.txt"\r\n
Content-Type: application/octet-stream\r\n\r\n

二进制数据
\r\n
--boundary\r\n
// status 是脚本文件接收参数的名称
Content-Disposition: form-data; name="status"\r\n\r\n

二进制数据
\r\n
--boundary--
// ------

以上部分，是发送给服务器的二进制数据的组成格式(示例)

如果在 iOS 中，要实现POST上传文件，需要按照上述格式，拼接数据！

因为：格式是 W3C 指定的标准格式，苹果没有做任何封装！其他语言，都做了封装！

以上格式是必须要了解的！

## 关于第三方框架

- AFN 能够同时实现上传"一个文件"，有些格式的文件，用 AFN 无法上传！
- ASI 能够同时实现上传多个文件，MRC的，2012年就停止更新了，设计的目标平台， iOS 2.0/iOS 3.0 的

为什么要同时上传多个文件：

- 以前很多服务器对上传文件的大小有限制，PHP 限制是 2M
- 目前很多服务器不仅不限制大小，而且鼓励上传多个文件！
	- 云服务器的普及！
	- 软件商希望获得更多的用户数据！

	- UGC （用户生成内容）
