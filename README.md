# 飞鸽博客后端

## 1. 介绍

此博客后台基于[飞鸽博客 flygoose-api](https://github.com/helloworld-Co/flygoose-api) 进行二开

项目是基于 `Go` 语言开发的，需要安装 `Go` 语言环境，这里推荐一个SDK多版本管理工具 [vfox](https://vfox.lhan.me/zh-hans/)
，可以轻松切换 `Go` 版本

## 2. 本地项目运行

1. 克隆项目

```bash
git clone https://github.com/small-universe/flygoose-api.git
# 或
git clone https://gitee.com/small-universe/flygoose-api.git
```

2. 安装依赖

进入到根目录下执行如下命令

```bash
go mod tidy
```

3. 运行

本地IDE中运行，执行如下命令

```bash
go run main.go
```

## 3. Docker 部署

1. 构建 `Docker` 镜像

如有必要，可以重新修改一下 `scripts/build.sh` 中相关配置

```bash
#版本
version=XXX 
# 镜像名
image_name=XXX
```

```shell
cd ./scripts
sh build.sh
```

2. 启动 `Docker` 容器

如果想使用 `Docker` 中启动应用（须预先安装 `docker-desktop`），执行如下命令，这可以验证上一步构建的镜像是否可用

```bash
cd ./scripts
docker-compose up -d
```