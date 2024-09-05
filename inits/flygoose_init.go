package inits

import (
	"errors"
	"flygoose/configs"
	"flygoose/datasource"
	"flygoose/pkg/models"
	"flygoose/pkg/tlog"
	"flygoose/pkg/tools"
	"flygoose/web/controllers/admin"
	"flygoose/web/controllers/flygoose"
	"flygoose/web/daos"
	"fmt"
	"github.com/kataras/iris/v12"
	"github.com/kataras/iris/v12/middleware/cors"
	"github.com/kataras/iris/v12/mvc"
	"go.uber.org/zap"
	"os"
	"path/filepath"
	"time"
)

type FlygooseApp struct {
	Cfg    *configs.Config
	Engine *iris.Application
}

func NewFlygooseApp(cfg *configs.Config) *FlygooseApp {
	app := new(FlygooseApp)
	app.Cfg = cfg
	// app.Engine = iris.Default()
	app.Engine = iris.New()
	app.Engine.UseRouter(cors.New().
		ExtractOriginFunc(cors.DefaultOriginExtractor).
		ReferrerPolicy(cors.NoReferrerWhenDowngrade).
		AllowOriginFunc(cors.AllowAnyOrigin).
		AllowHeaders("token", "content-type", "Authorization", "X-Requested-With").
		ExposeHeaders("token", "content-type", "Authorization", "X-Requested-With").
		Handler())
	return app
}

func (m *FlygooseApp) Start() {
	m.InitDir()
	m.initLog()
	m.initDB()
	m.initRouter()
	m.run()
}

func (m *FlygooseApp) run() {
	err := m.Engine.Listen(fmt.Sprintf(":%d", m.Cfg.Server.Port), iris.WithoutBodyConsumptionOnUnmarshal, iris.WithOptimizations)
	if err != nil {
		tlog.Error2("FlygooseApp run 启动出错:", err)
		panic(err)
	}
}

func (m *FlygooseApp) InitDir() {
	// 初始化服务工作区
	if m.Cfg.FlyGooseCfg.WorkDir == "" {
		pwd, err := os.Getwd()
		if err != nil {
			panic(errors.New("初始化服务工作区出错"))
		}
		m.Cfg.FlyGooseCfg.WorkDir, _ = filepath.Abs(pwd)
	} else {
		workDir, err := filepath.Abs(m.Cfg.FlyGooseCfg.WorkDir)
		if err != nil {
			panic(err)
		}
		m.Cfg.FlyGooseCfg.WorkDir = workDir
	}

	m.Cfg.FlyGooseCfg.StaticDir = configs.StaticDir
	m.Cfg.FlyGooseCfg.StaticImgDir = configs.StaticImgDir

	// 创建相应的文件目录
	tools.CreateDir(filepath.Join(m.Cfg.FlyGooseCfg.WorkDir, m.Cfg.FlyGooseCfg.StaticDir))
	tools.CreateDir(filepath.Join(m.Cfg.FlyGooseCfg.WorkDir, m.Cfg.FlyGooseCfg.StaticImgDir))

	var abcStaticDir = filepath.Join(m.Cfg.FlyGooseCfg.WorkDir, m.Cfg.FlyGooseCfg.StaticDir)
	m.Engine.HandleDir("/static", abcStaticDir) // http://192.168.1.6:29090/static/img/aa.jpg
}

func (m *FlygooseApp) initLog() {
	tlog.InitLog()
}

func (m *FlygooseApp) initDB() {
	var cfg = m.Cfg
	switch m.Cfg.Database.Driver {
	case configs.DbDriverMySQL:
		datasource.InitMySQL(cfg)
		break
	case configs.DbDriverPostgreSQL:
		datasource.InitPostgreSQL(cfg)
		break
	case configs.DbDriverSQLite:
		datasource.InitSQLite(cfg)
		break
	default:
		panic(errors.New("数据库驱动不支持"))
	}

	// 自动迁移
	m.initAutoMigrate()

	ad := daos.NewAccessDao()
	cnt, err := ad.CountUsername(configs.FlyGooseAdminPhone)
	if err != nil {
		fmt.Printf("查询数据库中是否存在默认账户错误. err: %w\n", err)
		panic(errors.New("查询数据库中是否存在默认账户错误"))
	}

	if cnt == 0 {
		initAccountUser := models.Admin{
			Phone:      configs.FlyGooseAdminPhone,
			Password:   "e10adc3949ba59abbe56e057f20f883e",
			Nicker:     "admin",
			Avatar:     "https://img-hello-world.oss-cn-beijing.aliyuncs.com/imgs/b3e9e8fb50b3eba780178256a21234ec.jpg",
			CreateTime: time.Now(),
			ValidTime:  time.Now(),
			LoginTime:  time.Now(),
			Status:     models.AdminStatusNormal,
		}
		if ad.Create(&initAccountUser) != nil {
			fmt.Printf("创建数默认账户错误. err: %w\n", err)
			panic(errors.New("创建数默认账户错误"))
		}
	}
}

func (m *FlygooseApp) initAutoMigrate() {

	err := datasource.GetMasterDB().AutoMigrate(
		&models.Admin{},
		&models.Blog{},
		&models.Category{},
		&models.Link{},
		&models.Notice{},
		&models.Section{},
		&models.Site{},
		&models.Special{},
		&models.Webmaster{},
		&models.Banner{},
	)

	if err != nil {
		tlog.Error("映射models出错:", zap.Error(err))
	}
}

func (m *FlygooseApp) initRouter() {
	v1 := m.Engine.Party(configs.FlyGooseUrlPrefix)
	v1.RegisterDependency(m.Cfg) // 依赖注入
	{
		mvc.New(v1.Party("/site")).Handle(flygoose.NewSiteController())
		mvc.New(v1.Party("/blog")).Handle(flygoose.NewBlogController())
		mvc.New(v1.Party("/special")).Handle(flygoose.NewSpecialController())

		mvc.New(v1.Party("/health")).Handle(admin.NewHealthController())                 // 健康检查
		mvc.New(v1.Party("/admin/access")).Handle(admin.NewAccessController())           // 访问相关接口
		mvc.New(v1.Party("/admin/blog")).Handle(admin.NewBlogController())               // 博客相关接口
		mvc.New(v1.Party("/admin/link")).Handle(admin.NewLinkController())               // 友链相关接口
		mvc.New(v1.Party("/admin/site")).Handle(admin.NewSiteController())               // 网站信息相关接口
		mvc.New(v1.Party("/admin/category")).Handle(admin.NewCategoryController())       // 博客分类相关接口
		mvc.New(v1.Party("/admin/notice")).Handle(admin.NewNoticeController())           // 公告分类相关接口
		mvc.New(v1.Party("/admin/special")).Handle(admin.NewSpecialController())         // 专栏相关接口
		mvc.New(v1.Party("/admin/file")).Handle(admin.NewFileController())               // 文件相关接口
		mvc.New(v1.Party("/admin/banner")).Handle(admin.NewBannerController())           // 轮播图相关接口
		mvc.New(v1.Party("/admin/workStation")).Handle(admin.NewWorkStationController()) // 统计数据
	}
}
