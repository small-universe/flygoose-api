package daos

import (
	"flygoose/datasource"
	"flygoose/pkg/models"
	"flygoose/pkg/tlog"
	"gorm.io/gorm"
)

type CategoryDao struct {
	db *gorm.DB
}

func NewCategoryDao() *CategoryDao {
	return &CategoryDao{db: datasource.GetMasterDB()}
}

func (dao *CategoryDao) GetById(cateId int64) *models.Category {
	var m models.Category
	result := dao.db.Where("id=?", cateId).First(&m)
	if result.Error != nil {
		tlog.Error2("CategoryDao:GetById 出错", result.Error)
		return nil
	}
	return &m
}

func (dao *CategoryDao) Create(m *models.Category) error {
	result := dao.db.Create(m)
	if result.Error != nil {
		tlog.Error2("CategoryDao:Create 出错", result.Error)
	}
	return result.Error
}

func (dao *CategoryDao) Update(id int64, fields []string, m *models.Category) error {
	result := dao.db.Model(&models.Category{}).Select(fields).Where("id=?", id).Updates(m)
	if result.Error != nil {
		tlog.Error2("CategoryDao:Update 出错", result.Error)
	}
	return result.Error
}

func (dao *CategoryDao) GetAllCategoryList() []models.Category {
	var list []models.Category
	result := dao.db.Model(&models.Category{}).Order("seq").Find(&list)
	if result.Error != nil {
		tlog.Error2("CategoryDao:GetAllCategoryList 出错", result.Error)
		return nil
	}
	return list
}

func (dao *CategoryDao) GetCategoryListByStatus(status int) []models.Category {
	var list []models.Category
	result := dao.db.Model(&models.Category{}).Where("status=?", status).Order("seq").Find(&list)
	if result.Error != nil {
		tlog.Error2("CategoryDao:GetCategoryListByStatus 出错", result.Error)
		return nil
	}
	return list
}

func (dao *CategoryDao) PageQuery(pageNum int, pageSize int) ([]models.Category, int64) {
	var list []models.Category
	var count int64
	result := dao.db.Model(&models.Category{}).Limit(pageSize).Offset((pageNum - 1) * pageSize).Order("seq").Find(&list)
	if result.Error != nil {
		tlog.Error2("CategoryDao:PageQuery Find 出错", result.Error)
		return nil, 0
	}

	result = dao.db.Model(&models.Category{}).Count(&count)
	if result.Error != nil {
		tlog.Error2("CategoryDao:PageQuery Count 出错", result.Error)
		return nil, 0
	}

	return list, count
}

func (dao *CategoryDao) PageQueryByStatus(status int, pageNum int, pageSize int) ([]models.Category, int64) {
	var list []models.Category
	var count int64
	result := dao.db.Model(&models.Category{}).Where("status=?", status).Limit(pageSize).Offset((pageNum - 1) * pageSize).Order("seq").Find(&list)
	if result.Error != nil {
		tlog.Error2("CategoryDao:PageQueryByStatus Find 出错", result.Error)
		return nil, 0
	}

	result = dao.db.Model(&models.Category{}).Count(&count)
	if result.Error != nil {
		tlog.Error2("CategoryDao:PageQueryByStatus Count 出错", result.Error)
		return nil, 0
	}

	return list, count
}
