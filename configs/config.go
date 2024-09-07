package configs

import (
	"errors"
	"fmt"
	"github.com/fsnotify/fsnotify"
	"github.com/spf13/pflag"
	"github.com/spf13/viper"
	"reflect"
)

type Config struct {
	Server      ServerCfg   `yaml:"server"`
	Database    DatabaseCfg `yaml:"database"`
	FlyGooseCfg FlyGooseCfg `yaml:"flygoose"`
}

type ServerCfg struct {
	Port   int    `yaml:"port"`
	Active string `yaml:"active"`
}

type FlyGooseCfg struct {
	WorkDir      string `yaml:"work_dir"`
	LogDir       string `yaml:"log_dir"`
	StaticDir    string
	StaticImgDir string
}

type DatabaseCfg struct {
	Driver   DbDriverType `yaml:"driver"`
	Host     string       `yaml:"host"`
	Name     string       `yaml:"name"`
	Port     int          `yaml:"port"`
	User     string       `yaml:"user"`
	Password string       `yaml:"password"`
}

// DbDriverType 数据库类型
type DbDriverType string

const (
	DbDriverMySQL      DbDriverType = "mysql"
	DbDriverPostgreSQL DbDriverType = "postgresql"
	DbDriverSQLite     DbDriverType = "sqlite"
)

// EnvModeType 环境
type EnvModeType string

// const (
//	EnvModeTypeDevelop EnvModeType = "develop" //开发环境
//	EnvModeTypeProd    EnvModeType = "product" //正式环境
// )

const (
	StaticDir          = "/static"
	StaticImgDir       = "/static/img"
	FlyGooseUrlPrefix  = "/api"
	FlyGooseAdminPhone = "12345678901"
)

// NewConfig 创建配置文件
func NewConfig() *Config {
	// 读取环境变量
	viper.AutomaticEnv()

	// 解析命令行参数
	pflag.String("c", "", "指定配置文件路径")
	pflag.String("e", "", "指定配置环境")
	pflag.Parse()
	_ = viper.BindPFlags(pflag.CommandLine)
	configFilePath := viper.GetString("c")
	// 命令行参数配置优先级大于环境变量配置
	mode := viper.GetString("e")

	var cfg Config
	defaultViper := viper.New()
	modeViper := viper.New()
	if configFilePath != "" {
		defaultViper.SetConfigFile(configFilePath)
		parseConf(defaultViper, &cfg)
	} else {
		// 先默认读取config.yaml
		parseConf(defaultViper, &cfg)

		// 再根据环境读取指定配置，覆盖掉默认配置
		if mode == "" {
			// 命令行参数配置优先级大于文件配置
			mode = cfg.Server.Active
		} else {
			cfg.Server.Active = mode
		}

		if mode != "" {
			modeViper.SetConfigName("config." + mode)
			parseConf(modeViper, &cfg)

			modeViper.WatchConfig()
			modeViper.OnConfigChange(func(e fsnotify.Event) {
				fmt.Println("Config file changed:", e.Name)
				_ = modeViper.Unmarshal(&cfg)
			})
		}
	}

	defaultViper.WatchConfig()
	defaultViper.OnConfigChange(func(e fsnotify.Event) {
		// 配置文件发生变更之后会调用的回调函数
		fmt.Println("Config file changed:", e.Name)
		_ = defaultViper.Unmarshal(&cfg)
		if len(modeViper.AllSettings()) != 0 {
			_ = modeViper.Unmarshal(&cfg)
		}
	})

	// if err = CheckZeroValue(cfg); err != nil {
	//	return nil, fmt.Errorf("检查配置文件错误. env: %s err: %s", configFilePath, err.Error())
	// }

	return &cfg
}

// parseConf 解析配置文件
func parseConf(v *viper.Viper, cfg *Config) *Config {
	v.SetConfigType("yaml")
	v.AddConfigPath("./")
	v.AddConfigPath("./conf/")

	// 读取配置文件
	err := v.ReadInConfig()
	if err != nil {
		panic(fmt.Errorf("读取配置文件错误. err: %w", err))
	}

	// 解析配置文件到结构体
	err = v.Unmarshal(cfg)
	if err != nil {
		panic(fmt.Errorf("解析配置文件错误. err: %w", err))
	}
	return cfg
}

// CheckZeroValue 检验配置文件各个字段不能为空. str必须为一个结构体类型.
func CheckZeroValue(str interface{}) error {
	t := reflect.TypeOf(str)
	if t.Kind() != reflect.Struct {
		return errors.New("non-struct type:" + t.String())
	}
	v := reflect.ValueOf(str)
	for k := 0; k < t.NumField(); k++ {
		fieldType := v.Field(k).Kind()
		if fieldType == reflect.Struct {
			if err := CheckZeroValue(v.Field(k).Interface()); err != nil {
				return err
			}
		}
		if v.Field(k).IsZero() {
			required := t.Field(k).Tag.Get("required")
			if required == "false" {
				fmt.Errorf("%+v %+v is zero, 但根据校验规则，required为false.跳过检查.\n", t, t.Field(k).Name)
				continue
			}
			return fmt.Errorf("%+v %+v can not be zero", t, t.Field(k).Name)
		}
	}
	return nil
}
