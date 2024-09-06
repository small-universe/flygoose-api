package main

import (
	"flygoose/configs"
	"flygoose/inits"
)

func main() {
	// 根据启动指定的配置文件生成对应的 struct
	cfg := configs.NewConfig()

	// 生成应用程序
	flygoose := inits.NewFlygooseApp(cfg)
	flygoose.Start()
}
