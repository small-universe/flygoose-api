package datasource

import (
	"flygoose/configs"
	"fmt"
	"gorm.io/driver/sqlite"
	"path/filepath"
	"strings"

	"gorm.io/driver/mysql"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/schema"
)

var (
	masterDB *gorm.DB
)

func GetMasterDB() *gorm.DB {
	return masterDB
}

// InitMySQL 初始化MySQL
func InitMySQL(cfg *configs.Config) {

	dsn := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?charset=utf8mb4&parseTime=True&loc=Local", cfg.Database.User, cfg.Database.Password, cfg.Database.Host, cfg.Database.Port, cfg.Database.Name)
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{
		NamingStrategy: schema.NamingStrategy{
			TablePrefix:   "",
			SingularTable: true,
		},
	})
	if err != nil {
		if strings.Contains(err.Error(), "Unknown database") {
			// 如果没有db 创建db
			dsn = fmt.Sprintf("%s:%s@tcp(%s:%d)/", cfg.Database.User, cfg.Database.Password, cfg.Database.Host, cfg.Database.Port)
			db, err = gorm.Open(mysql.Open(dsn), &gorm.Config{
				NamingStrategy: schema.NamingStrategy{
					TablePrefix:   "",
					SingularTable: true,
				},
			})
			if err != nil {
				panic(err)
			}
			createDatabaseSql := fmt.Sprintf("CREATE DATABASE IF NOT EXISTS `%s` DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci", cfg.Database.Name)
			tx := db.Exec(createDatabaseSql)
			if tx.Error != nil {
				panic(tx.Error)
			}
			// 创建完成后再重新连接一次
			dsn = fmt.Sprintf("%s:%s@tcp(%s:%d)/%s", cfg.Database.User, cfg.Database.Password, cfg.Database.Host, cfg.Database.Port, cfg.Database.Name)
			db, err = gorm.Open(mysql.Open(dsn), &gorm.Config{
				NamingStrategy: schema.NamingStrategy{
					TablePrefix:   "",
					SingularTable: true,
				},
			})
			if err != nil {
				panic(err)
			}
		} else {
			panic(err)
		}

	}

	masterDB = db
}

// InitPostgreSQL 初始化PostgreSQL
func InitPostgreSQL(cfg *configs.Config) {
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%d sslmode=disable TimeZone=Asia/Shanghai", cfg.Database.Host, cfg.Database.User, cfg.Database.Password, cfg.Database.Name, cfg.Database.Port)
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{
		NamingStrategy: schema.NamingStrategy{
			TablePrefix:   "",
			SingularTable: true,
		},
	})
	if err != nil {
		panic(err)
	}

	masterDB = db
}

// InitSQLite 初始化SQLite
func InitSQLite(cfg *configs.Config) {
	dsn := filepath.Join(cfg.FlyGooseCfg.WorkDir, "flygoose.db")
	db, err := gorm.Open(sqlite.Open(dsn), &gorm.Config{
		NamingStrategy: schema.NamingStrategy{
			TablePrefix:   "",
			SingularTable: true,
		},
	})
	if err != nil {
		panic(err)
	}

	masterDB = db
}
