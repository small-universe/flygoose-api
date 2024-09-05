/*
 Navicat Premium Data Transfer

 Source Server         : hw-dev
 Source Server Type    : MySQL
 Source Server Version : 80019 (8.0.19)
 Source Host           : 192.168.168.166:3306
 Source Schema         : db_09

 Target Server Type    : MySQL
 Target Server Version : 80019 (8.0.19)
 File Encoding         : 65001

 Date: 21/08/2024 22:53:43
*/

DROP SCHEMA IF EXISTS `db_flygoose`;
CREATE SCHEMA `db_flygoose` COLLATE utf8mb4_0900_ai_ci;
USE `db_flygoose`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
                         `id` bigint NOT NULL AUTO_INCREMENT comment '管理员ID',
                         `phone` longtext comment '手机号',
                         `password` longtext comment '密码',
                         `nicker` longtext comment '昵称',
                         `avatar` longtext comment '头像地址',
                         `token` longtext comment '登录Token',
                         `create_time` datetime(3) DEFAULT NULL comment '创建时间',
                         `valid_time` datetime(3) DEFAULT NULL comment '有效时间',
                         `login_time` datetime(3) DEFAULT NULL comment '登录时间',
                         `status` bigint DEFAULT NULL comment '状态 0-无效 1-有效',
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci comment '管理员表';

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` (`id`, `phone`, `password`, `nicker`, `avatar`, `token`, `create_time`, `valid_time`, `login_time`, `status`) VALUES (1, '12345678901', 'e10adc3949ba59abbe56e057f20f883e', 'admin', 'https://img-hello-world.oss-cn-beijing.aliyuncs.com/imgs/b3e9e8fb50b3eba780178256a21234ec.jpg', '', '2024-07-19 23:03:49.563', '2024-07-19 23:03:49.563', '2024-07-19 23:03:49.563', 1);
COMMIT;

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
                          `id` bigint NOT NULL AUTO_INCREMENT comment  '轮播图ID',
                          `title` longtext comment '标题',
                          `url` longtext comment '图片地址',
                          `target_url` longtext comment '跳转到的目标地址',
                          `seq` bigint DEFAULT NULL comment '序号',
                          `create_time` datetime(3) DEFAULT NULL comment '创建时间',
                          `status` bigint DEFAULT NULL comment '状态 0-无效 1-有效',
                          PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci comment '轮播图表';

-- ----------------------------
-- Records of banner
-- ----------------------------
BEGIN;
INSERT INTO `banner` (`id`, `title`, `url`, `target_url`, `seq`, `create_time`, `status`) VALUES (1, '1', 'https://test-blog.helloworld.net/static/img/674393665395.webp', '', 2, '2024-08-16 06:49:25.045', 1);
INSERT INTO `banner` (`id`, `title`, `url`, `target_url`, `seq`, `create_time`, `status`) VALUES (2, '2', 'https://test-blog.helloworld.net/static/img/029171992223.jpeg', '', 1, '2024-08-16 06:49:30.329', 1);
INSERT INTO `banner` (`id`, `title`, `url`, `target_url`, `seq`, `create_time`, `status`) VALUES (3, '--', 'https://flygoose-admin.helloworld.net/static/img/291510643911.jpeg', '', 3, '2024-08-18 01:47:38.625', 0);
COMMIT;

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
                        `id` bigint NOT NULL AUTO_INCREMENT comment '博客ID',
                        `title` longtext comment '标题',
                        `intro` longtext comment '简介',
                        `cover` longtext comment '封面图地址',
                        `content` longtext comment '文章内容',
                        `html` longtext comment 'HTML内容',
                        `is_html` bigint DEFAULT NULL comment '是否是HTML',
                        `is_top` bigint DEFAULT NULL comment '是否置顶',
                        `read_count` bigint DEFAULT NULL comment '阅读量',
                        `create_time` datetime(3) DEFAULT NULL comment '创建时间',
                        `update_time` datetime(3) DEFAULT NULL comment '更新时间',
                        `publish_time` datetime(3) DEFAULT NULL comment '发布时间',
                        `thumbnail` longtext comment '缩略图',
                        `status` bigint DEFAULT NULL comment '状态 0-无效 1-有效',
                        `cate_id` bigint DEFAULT NULL comment '分类ID',
                        `tags` longtext comment '标签 以逗号分隔',
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci comment '博客表';

-- ----------------------------
-- Records of blog
-- ----------------------------
BEGIN;
INSERT INTO `blog` (`id`, `title`, `intro`, `content`, `html`, `is_html`, `is_top`, `read_count`, `create_time`, `update_time`, `publish_time`, `thumbnail`, `status`, `cate_id`, `tags`) VALUES (1, '测试测试', '测试测试', '测试测试', '', 0, 1, 0, '2024-08-10 02:03:13.449', '2024-08-16 08:11:52.416', '2024-08-10 02:03:13.449', 'https://test-blog.helloworld.net/static/img/413880491197.heic', 30, 1, '1,2,3,4');
INSERT INTO `blog` (`id`, `title`, `intro`, `content`, `html`, `is_html`, `is_top`, `read_count`, `create_time`, `update_time`, `publish_time`, `thumbnail`, `status`, `cate_id`, `tags`) VALUES (2, '1', '1', '1', '', 0, 0, 0, '2024-08-16 09:02:56.997', '2024-08-16 09:20:59.228', '2024-08-16 09:02:56.997', '', 30, 1, '');
INSERT INTO `blog` (`id`, `title`, `intro`, `content`, `html`, `is_html`, `is_top`, `read_count`, `create_time`, `update_time`, `publish_time`, `thumbnail`, `status`, `cate_id`, `tags`) VALUES (3, '2', '2', '2', '', 0, 0, 0, '2024-08-16 09:03:23.777', '2024-08-16 09:23:55.301', '2024-08-16 09:03:23.777', '', 30, 2, '');
INSERT INTO `blog` (`id`, `title`, `intro`, `content`, `html`, `is_html`, `is_top`, `read_count`, `create_time`, `update_time`, `publish_time`, `thumbnail`, `status`, `cate_id`, `tags`) VALUES (4, '3', '3', '3', '', 0, 1, 0, '2024-08-16 09:03:33.546', '2024-08-16 09:14:06.028', '2024-08-16 09:03:33.546', '', 20, 1, '');
INSERT INTO `blog` (`id`, `title`, `intro`, `content`, `html`, `is_html`, `is_top`, `read_count`, `create_time`, `update_time`, `publish_time`, `thumbnail`, `status`, `cate_id`, `tags`) VALUES (5, '4', '4', '4', '', 0, 1, 0, '2024-08-16 09:03:41.377', '2024-08-16 09:13:58.514', '2024-08-16 09:03:41.377', '', 20, 1, '');
INSERT INTO `blog` (`id`, `title`, `intro`, `content`, `html`, `is_html`, `is_top`, `read_count`, `create_time`, `update_time`, `publish_time`, `thumbnail`, `status`, `cate_id`, `tags`) VALUES (6, '5', '5', '5', '', 0, 1, 0, '2024-08-16 09:03:48.737', '2024-08-16 09:13:37.553', '2024-08-16 09:03:48.737', '', 20, 1, '');
INSERT INTO `blog` (`id`, `title`, `intro`, `content`, `html`, `is_html`, `is_top`, `read_count`, `create_time`, `update_time`, `publish_time`, `thumbnail`, `status`, `cate_id`, `tags`) VALUES (7, '6', '6', '6', '', 0, 1, 0, '2024-08-16 09:03:57.137', '2024-08-16 09:13:31.690', '2024-08-16 09:03:57.137', '', 20, 1, '');
INSERT INTO `blog` (`id`, `title`, `intro`, `content`, `html`, `is_html`, `is_top`, `read_count`, `create_time`, `update_time`, `publish_time`, `thumbnail`, `status`, `cate_id`, `tags`) VALUES (8, '7', '7', '7', '', 0, 0, 0, '2024-08-16 09:04:06.025', '2024-08-16 09:22:21.785', '2024-08-16 09:04:06.025', '', 10, 1, '');
INSERT INTO `blog` (`id`, `title`, `intro`, `content`, `html`, `is_html`, `is_top`, `read_count`, `create_time`, `update_time`, `publish_time`, `thumbnail`, `status`, `cate_id`, `tags`) VALUES (9, '8', '8', '8', '', 0, 1, 0, '2024-08-16 09:04:16.359', '2024-08-16 09:19:53.864', '2024-08-16 09:04:16.359', '', 20, 1, '');
INSERT INTO `blog` (`id`, `title`, `intro`, `content`, `html`, `is_html`, `is_top`, `read_count`, `create_time`, `update_time`, `publish_time`, `thumbnail`, `status`, `cate_id`, `tags`) VALUES (10, '9', '9', '9', '', 0, 1, 0, '2024-08-16 09:04:25.064', '2024-08-16 09:19:50.903', '2024-08-16 09:04:25.064', '', 20, 1, '');
INSERT INTO `blog` (`id`, `title`, `intro`, `content`, `html`, `is_html`, `is_top`, `read_count`, `create_time`, `update_time`, `publish_time`, `thumbnail`, `status`, `cate_id`, `tags`) VALUES (11, '00', '0', '00', '', 0, 1, 0, '2024-08-16 09:04:36.837', '2024-08-16 09:19:47.383', '2024-08-16 09:04:36.837', '', 20, 1, '');
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
                            `id` bigint NOT NULL AUTO_INCREMENT comment '分类ID',
                            `name` longtext comment '名称',
                            `seq` bigint DEFAULT NULL comment '序号',
                            `icon` longtext comment '图标',
                            `font` longtext comment '字体',
                            `color` longtext comment '颜色',
                            `create_time` datetime(3) DEFAULT NULL comment '创建时间',
                            `update_time` datetime(3) DEFAULT NULL comment '更新时间',
                            `status` bigint DEFAULT NULL comment '状态 0-无效 1-有效',
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci comment '分类表';

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` (`id`, `name`, `seq`, `icon`, `font`, `color`, `create_time`, `update_time`, `status`) VALUES (1, 'web前端', 0, '', '', 'red', '2024-08-10 02:02:52.081', '2024-08-10 02:02:52.081', 1);
INSERT INTO `category` (`id`, `name`, `seq`, `icon`, `font`, `color`, `create_time`, `update_time`, `status`) VALUES (2, 'H5', 2, '', '', 'red', '2024-08-16 09:02:43.388', '2024-08-16 09:02:43.388', 1);
COMMIT;

-- ----------------------------
-- Table structure for link
-- ----------------------------
DROP TABLE IF EXISTS `link`;
CREATE TABLE `link` (
                        `id` bigint NOT NULL AUTO_INCREMENT comment '友链ID',
                        `title` longtext comment '标题',
                        `url` longtext comment '链接地址',
                        `seq` bigint DEFAULT NULL comment '序号',
                        `create_time` datetime(3) DEFAULT NULL comment '创建时间',
                        `update_time` datetime(3) DEFAULT NULL comment '更新时间',
                        `valid_time` datetime(3) DEFAULT NULL comment '有效时间',
                        `remark` longtext comment '备注',
                        `status` bigint DEFAULT NULL comment '状态 0-无效 1-有效',
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci comment '友链表';

-- ----------------------------
-- Records of link
-- ----------------------------
BEGIN;
INSERT INTO `link` (`id`, `title`, `url`, `seq`, `create_time`, `update_time`, `valid_time`, `remark`, `status`) VALUES (1, '111', 'https://www.baidu.com/', 0, '2024-08-10 06:13:46.673', '2024-08-16 07:58:43.425', '2099-12-31 23:59:59.000', '', 1);
COMMIT;

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
                          `id` bigint NOT NULL AUTO_INCREMENT comment '公告ID',
                          `title` longtext comment '标题',
                          `content` longtext comment '内容',
                          `create_time` datetime(3) DEFAULT NULL comment '创建时间',
                          `update_time` datetime(3) DEFAULT NULL comment '更新时间',
                          `valid_time` datetime(3) DEFAULT NULL comment '有效时间',
                          `status` bigint DEFAULT NULL comment '状态 0-无效 1-有效',
                          PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci comment '公告表';

-- ----------------------------
-- Records of notice
-- ----------------------------
BEGIN;
INSERT INTO `notice` (`id`, `title`, `content`, `create_time`, `update_time`, `valid_time`, `status`) VALUES (1, '飞鹅博客开源了', '轻量化部署，快速搭建自己的专属博客', '2024-08-10 06:15:03.751', '2024-08-10 06:15:03.751', '2024-08-10 06:14:59.000', 1);
COMMIT;

-- ----------------------------
-- Table structure for section
-- ----------------------------
DROP TABLE IF EXISTS `section`;
CREATE TABLE `section` (
                           `id` bigint NOT NULL AUTO_INCREMENT comment '小节ID',
                           `title` longtext comment '标题',
                           `intro` longtext comment '简介',
                           `content` longtext comment '内容',
                           `html` longtext comment 'HTML内容',
                           `tags` longtext comment '标签',
                           `is_html` bigint DEFAULT NULL comment '是否是HTML',
                           `read_count` bigint DEFAULT NULL comment '阅读数',
                           `special_id` bigint DEFAULT NULL comment '专栏ID',
                           `seq` bigint DEFAULT NULL comment '序号',
                           `create_time` datetime(3) DEFAULT NULL comment '创建时间',
                           `update_time` datetime(3) DEFAULT NULL comment '更新时间',
                           `publish_time` datetime(3) DEFAULT NULL comment '发布时间',
                           `status` bigint DEFAULT NULL comment '小节状态 10-已创建；20-已下架；30-已发布',
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15739452 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci comment '专栏小节表';

-- ----------------------------
-- Records of section
-- ----------------------------
BEGIN;
INSERT INTO `section` (`id`, `title`, `intro`, `content`, `html`, `tags`, `is_html`, `read_count`, `special_id`, `seq`, `create_time`, `update_time`, `publish_time`, `status`) VALUES (3542419, '213', '', 'w\'q\'w\'e\'q', '', '', 0, 0, 50585244, 2, '2024-08-16 08:02:53.713', '2024-08-16 08:03:02.035', '2024-08-16 08:03:02.035', 30);
INSERT INTO `section` (`id`, `title`, `intro`, `content`, `html`, `tags`, `is_html`, `read_count`, `special_id`, `seq`, `create_time`, `update_time`, `publish_time`, `status`) VALUES (15739451, '测试小结1', '', '测试小结1测试小结1测试小结1测试小结1测试小结1测试小结1测试小结1测试小结1', '', '', 0, 0, 50585244, 1, '2024-08-16 07:56:06.646', '2024-08-16 07:56:23.648', '2024-08-16 07:56:23.648', 30);
COMMIT;

-- ----------------------------
-- Table structure for site
-- ----------------------------
DROP TABLE IF EXISTS `site`;
CREATE TABLE `site` (
                        `id` bigint NOT NULL AUTO_INCREMENT comment '站点ID',
                        `title` longtext comment '标题',
                        `intro` longtext comment '简介',
                        `slogan` longtext comment '个性签名',
                        `cover` longtext comment '封面图',
                        `copyright` longtext comment '版权信息',
                        `icp` longtext comment 'icp相关信息',
                        `update_time` datetime(3) DEFAULT NULL comment '更新时间',
                        `extra` longtext comment '额外的信息, json字符串',
                        `status` bigint DEFAULT NULL comment '网站信息状态: 0-未启用；1-已启用',
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci comment '站点信息表';

-- ----------------------------
-- Records of site
-- ----------------------------
BEGIN;
INSERT INTO `site` (`id`, `title`, `intro`, `slogan`, `cover`, `copyright`, `icp`, `update_time`, `extra`, `status`) VALUES (1, 'test', 'test', 'test', 'https://flygoose-admin.helloworld.net/static/img/909099273827.png', '1', '1', '2024-08-21 18:56:09.000', '1', 1);
COMMIT;

-- ----------------------------
-- Table structure for special
-- ----------------------------
DROP TABLE IF EXISTS `special`;
CREATE TABLE `special` (
                           `id` bigint NOT NULL AUTO_INCREMENT comment '专栏ID',
                           `title` longtext comment '专栏标题',
                           `intro` longtext comment '专栏简介',
                           `cover` longtext comment '专栏封面',
                           `create_time` datetime(3) DEFAULT NULL comment '创建时间',
                           `update_time` datetime(3) DEFAULT NULL comment '更新时间',
                           `publish_time` datetime(3) DEFAULT NULL comment '发布时间',
                           `status` bigint DEFAULT NULL comment '专栏状态 10-已创建；20-已下架；30-已发布',
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50585245 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci comment '专栏表';

-- ----------------------------
-- Records of special
-- ----------------------------
BEGIN;
INSERT INTO `special` (`id`, `title`, `intro`, `cover`, `create_time`, `update_time`, `publish_time`, `status`) VALUES (10315865, '测试专栏', '测试专栏', 'https://test-blog.helloworld.net/static/img/840803494584.heic', '2024-08-10 06:12:39.416', '2024-08-16 07:52:14.340', '2024-08-10 06:12:39.416', 30);
INSERT INTO `special` (`id`, `title`, `intro`, `cover`, `create_time`, `update_time`, `publish_time`, `status`) VALUES (50585244, '测试专栏', '测试专栏', 'https://test-blog.helloworld.net/static/img/281818326311.heic', '2024-08-16 07:51:14.189', '2024-08-16 07:52:09.015', '2024-08-16 07:51:14.189', 30);
COMMIT;

-- ----------------------------
-- Table structure for webmaster
-- ----------------------------
DROP TABLE IF EXISTS `webmaster`;
CREATE TABLE `webmaster` (
                             `id` bigint NOT NULL AUTO_INCREMENT comment '站长ID',
                             `intro` longtext comment '简介',
                             `slogan` longtext comment '站长个性签名',
                             `nicker` longtext comment '站长昵称',
                             `avatar` longtext comment '站长头像',
                             `job` longtext comment '站长职业',
                             `email` longtext comment '站长邮箱',
                             `qq` longtext comment '站长QQ号',
                             `wechat` longtext comment '站长微信二维码',
                             `reward_code` longtext comment '站长打赏二维码',
                             `status` bigint DEFAULT NULL comment '状态: 0-未启用；1-已启用',
                             `update_time` datetime(3) DEFAULT NULL comment '创建时间',
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci comment '站长信息表';

-- ----------------------------
-- Records of webmaster
-- ----------------------------
BEGIN;
INSERT INTO `webmaster` (`id`, `intro`, `slogan`, `nicker`, `avatar`, `job`, `email`, `qq`, `wechat`, `reward_code`, `status`, `update_time`) VALUES (1, '萌萌的博客', '做有价值的产品才是王道', '萌萌', 'https://test-blog.helloworld.net/static/img/435237564518.heic', '总裁', '123456@163.com', '1232132132', '12312312312', 'https://test-blog.helloworld.net/static/img/347000360279.heic', 1, '2024-08-16 09:08:26.662');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
