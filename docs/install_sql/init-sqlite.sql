BEGIN TRANSACTION;
-- 创建 admin 表
DROP TABLE IF EXISTS admin;
CREATE TABLE admin
(
    id          INTEGER PRIMARY KEY AUTOINCREMENT, -- 管理员 ID
    phone       TEXT,                              -- 手机号
    password    TEXT,                              -- 密码
    nicker      TEXT,                              -- 昵称
    avatar      TEXT,                              -- 头像地址
    token       TEXT,                              -- 登录 Token
    create_time DATETIME,                          -- 创建时间
    valid_time  DATETIME,                          -- 有效时间
    login_time  DATETIME,                          -- 登录时间
    status      INTEGER                            -- 状态 0-无效 1-有效
);

INSERT INTO admin (phone, password, nicker, avatar, token, create_time, valid_time, login_time, status)
VALUES ('12345678901', 'e10adc3949ba59abbe56e057f20f883e', 'admin', 'https://img-hello-world.oss-cn-beijing.aliyuncs.com/imgs/b3e9e8fb50b3eba780178256a21234ec.jpg', '', '2024-07-19 23:03:49.563', '2024-07-19 23:03:49.563', '2024-07-19 23:03:49.563', 1);

-- 创建 banner 表
DROP TABLE IF EXISTS banner;
CREATE TABLE banner
(
    id          INTEGER PRIMARY KEY AUTOINCREMENT, -- 轮播图 ID
    title       TEXT,                              -- 标题
    url         TEXT,                              -- 图片地址
    target_url  TEXT,                              -- 跳转到的目标地址
    seq         INTEGER,                           -- 序号
    create_time DATETIME,                          -- 创建时间
    status      INTEGER                            -- 状态 0-无效 1-有效
);

INSERT INTO banner (title, url, target_url, seq, create_time, status) VALUES ('1', 'https://test-blog.helloworld.net/static/img/674393665395.webp', '', 2, '2024-08-16 06:49:25.045', 1);
INSERT INTO banner (title, url, target_url, seq, create_time, status) VALUES ('2', 'https://test-blog.helloworld.net/static/img/029171992223.jpeg', '', 1, '2024-08-16 06:49:30.329', 1);
INSERT INTO banner (title, url, target_url, seq, create_time, status) VALUES ('--', 'https://flygoose-admin.helloworld.net/static/img/291510643911.jpeg', '', 3, '2024-08-18 01:47:38.625', 0);

-- 创建 blog 表
DROP TABLE IF EXISTS blog;
CREATE TABLE blog
(
    id           INTEGER PRIMARY KEY AUTOINCREMENT, -- 博客 ID
    title        TEXT,                              -- 标题
    intro        TEXT,                              -- 简介
    cover        TEXT,                              -- 封面图地址
    content      TEXT,                              -- 文章内容
    html         TEXT,                              -- HTML 内容
    is_html      INTEGER,                           -- 是否是 HTML
    is_top       INTEGER,                           -- 是否置顶
    read_count   INTEGER,                           -- 阅读量
    create_time  DATETIME,                          -- 创建时间
    update_time  DATETIME,                          -- 更新时间
    publish_time DATETIME,                          -- 发布时间
    thumbnail    TEXT,                              -- 缩略图
    status       INTEGER,                           -- 状态 0-无效 1-有效
    cate_id      INTEGER,                           -- 分类 ID
    tags         TEXT                               -- 标签 以逗号分隔
);
INSERT INTO blog (title, intro, content, html, is_html, is_top, read_count, create_time, update_time, publish_time, thumbnail, status, cate_id, tags) VALUES ('测试测试', '测试测试', '测试测试', '', 0, 1, 0, '2024-08-10 02:03:13.449', '2024-08-16 08:11:52.416', '2024-08-10 02:03:13.449', 'https://test-blog.helloworld.net/static/img/413880491197.heic', 30, 1, '1,2,3,4');
INSERT INTO blog (title, intro, content, html, is_html, is_top, read_count, create_time, update_time, publish_time, thumbnail, status, cate_id, tags) VALUES ('1', '1', '1', '', 0, 0, 0, '2024-08-16 09:02:56.997', '2024-08-16 09:20:59.228', '2024-08-16 09:02:56.997', '', 30, 1, '');
INSERT INTO blog (title, intro, content, html, is_html, is_top, read_count, create_time, update_time, publish_time, thumbnail, status, cate_id, tags) VALUES ('2', '2', '2', '', 0, 0, 0, '2024-08-16 09:03:23.777', '2024-08-16 09:23:55.301', '2024-08-16 09:03:23.777', '', 30, 2, '');
INSERT INTO blog (title, intro, content, html, is_html, is_top, read_count, create_time, update_time, publish_time, thumbnail, status, cate_id, tags) VALUES ('3', '3', '3', '', 0, 1, 0, '2024-08-16 09:03:33.546', '2024-08-16 09:14:06.028', '2024-08-16 09:03:33.546', '', 20, 1, '');
INSERT INTO blog (title, intro, content, html, is_html, is_top, read_count, create_time, update_time, publish_time, thumbnail, status, cate_id, tags) VALUES ('4', '4', '4', '', 0, 1, 0, '2024-08-16 09:03:41.377', '2024-08-16 09:13:58.514', '2024-08-16 09:03:41.377', '', 20, 1, '');
INSERT INTO blog (title, intro, content, html, is_html, is_top, read_count, create_time, update_time, publish_time, thumbnail, status, cate_id, tags) VALUES ('5', '5', '5', '', 0, 1, 0, '2024-08-16 09:03:48.737', '2024-08-16 09:13:37.553', '2024-08-16 09:03:48.737', '', 20, 1, '');
INSERT INTO blog (title, intro, content, html, is_html, is_top, read_count, create_time, update_time, publish_time, thumbnail, status, cate_id, tags) VALUES ('6', '6', '6', '', 0, 1, 0, '2024-08-16 09:03:57.137', '2024-08-16 09:13:31.690', '2024-08-16 09:03:57.137', '', 20, 1, '');
INSERT INTO blog (title, intro, content, html, is_html, is_top, read_count, create_time, update_time, publish_time, thumbnail, status, cate_id, tags) VALUES ('7', '7', '7', '', 0, 0, 0, '2024-08-16 09:04:06.025', '2024-08-16 09:22:21.785', '2024-08-16 09:04:06.025', '', 10, 1, '');
INSERT INTO blog (title, intro, content, html, is_html, is_top, read_count, create_time, update_time, publish_time, thumbnail, status, cate_id, tags) VALUES ('8', '8', '8', '', 0, 1, 0, '2024-08-16 09:04:16.359', '2024-08-16 09:19:53.864', '2024-08-16 09:04:16.359', '', 20, 1, '');
INSERT INTO blog (title, intro, content, html, is_html, is_top, read_count, create_time, update_time, publish_time, thumbnail, status, cate_id, tags) VALUES ('9', '9', '9', '', 0, 1, 0, '2024-08-16 09:04:25.064', '2024-08-16 09:19:50.903', '2024-08-16 09:04:25.064', '', 20, 1, '');
INSERT INTO blog (title, intro, content, html, is_html, is_top, read_count, create_time, update_time, publish_time, thumbnail, status, cate_id, tags) VALUES ('00', '0', '00', '', 0, 1, 0, '2024-08-16 09:04:36.837', '2024-08-16 09:19:47.383', '2024-08-16 09:04:36.837', '', 20, 1, '');

-- 创建 category 表
DROP TABLE IF EXISTS category;
CREATE TABLE category
(
    id          INTEGER PRIMARY KEY AUTOINCREMENT, -- 分类 ID
    name        TEXT,                              -- 名称
    seq         INTEGER,                           -- 序号
    icon        TEXT,                              -- 图标
    font        TEXT,                              -- 字体
    color       TEXT,                              -- 颜色
    create_time DATETIME,                          -- 创建时间
    update_time DATETIME,                          -- 更新时间
    status      INTEGER                            -- 状态 0-无效 1-有效
);
INSERT INTO category (name, seq, icon, font, color, create_time, update_time, status) VALUES ('web前端', 0, '', '', 'red', '2024-08-10 02:02:52.081', '2024-08-10 02:02:52.081', 1);
INSERT INTO category (name, seq, icon, font, color, create_time, update_time, status) VALUES ('H5', 2, '', '', 'red', '2024-08-16 09:02:43.388', '2024-08-16 09:02:43.388', 1);

-- 创建 link 表
DROP TABLE IF EXISTS link;
CREATE TABLE link
(
    id          INTEGER PRIMARY KEY AUTOINCREMENT, -- 友链 ID
    title       TEXT,                              -- 标题
    url         TEXT,                              -- 链接地址
    seq         INTEGER,                           -- 序号
    create_time DATETIME,                          -- 创建时间
    update_time DATETIME,                          -- 更新时间
    valid_time  DATETIME,                          -- 有效时间
    remark      TEXT,                              -- 备注
    status      INTEGER                            -- 状态 0-无效 1-有效
);
INSERT INTO link (title, url, seq, create_time, update_time, valid_time, remark, status) VALUES ('111', 'https://www.baidu.com/', 0, '2024-08-10 06:13:46.673', '2024-08-16 07:58:43.425', '2099-12-31 23:59:59.000', '', 1);

-- 创建 notice 表
DROP TABLE IF EXISTS notice;
CREATE TABLE notice
(
    id          INTEGER PRIMARY KEY AUTOINCREMENT, -- 公告 ID
    title       TEXT,                              -- 标题
    content     TEXT,                              -- 内容
    create_time DATETIME,                          -- 创建时间
    update_time DATETIME,                          -- 更新时间
    valid_time  DATETIME,                          -- 有效时间
    status      INTEGER                            -- 状态 0-无效 1-有效
);
INSERT INTO notice (title, content, create_time, update_time, valid_time, status) VALUES ('飞鹅博客开源了', '轻量化部署，快速搭建自己的专属博客', '2024-08-10 06:15:03.751', '2024-08-10 06:15:03.751', '2024-08-10 06:14:59.000', 1);

-- 创建 special 表
DROP TABLE IF EXISTS special;
CREATE TABLE special
(
    id           INTEGER PRIMARY KEY AUTOINCREMENT, -- 专栏 ID
    title        TEXT,                              -- 专栏标题
    intro        TEXT,                              -- 专栏简介
    cover        TEXT,                              -- 专栏封面
    create_time  DATETIME,                          -- 创建时间
    update_time  DATETIME,                          -- 更新时间
    publish_time DATETIME,                          -- 发布时间
    status       INTEGER                            -- 专栏状态 10-已创建；20-已下架；30-已发布
);
INSERT INTO special (title, intro, cover, create_time, update_time, publish_time, status) VALUES ('测试专栏', '测试专栏', 'https://test-blog.helloworld.net/static/img/840803494584.heic', '2024-08-10 06:12:39.416', '2024-08-16 07:52:14.340', '2024-08-10 06:12:39.416', 30);
INSERT INTO special (title, intro, cover, create_time, update_time, publish_time, status) VALUES ('测试专栏', '测试专栏', 'https://test-blog.helloworld.net/static/img/281818326311.heic', '2024-08-16 07:51:14.189', '2024-08-16 07:52:09.015', '2024-08-16 07:51:14.189', 30);

-- 创建 section 表
DROP TABLE IF EXISTS section;
CREATE TABLE section
(
    id           INTEGER PRIMARY KEY AUTOINCREMENT, -- 小节 ID
    title        TEXT,                              -- 标题
    intro        TEXT,                              -- 简介
    content      TEXT,                              -- 内容
    html         TEXT,                              -- HTML 内容
    tags         TEXT,                              -- 标签
    is_html      INTEGER,                           -- 是否是 HTML
    read_count   INTEGER,                           -- 阅读数
    special_id   INTEGER,                           -- 专栏 ID
    seq          INTEGER,                           -- 序号
    create_time  DATETIME,                          -- 创建时间
    update_time  DATETIME,                          -- 更新时间
    publish_time DATETIME,                          -- 发布时间
    status       INTEGER                            -- 小节状态 10-已创建；20-已下架；30-已发布
);
INSERT INTO section (title, intro, content, html, tags, is_html, read_count, special_id, seq, create_time, update_time, publish_time, status) VALUES ('213', '', 'w''q''w''e''q', '', '', 0, 0, 50585244, 2, '2024-08-16 08:02:53.713', '2024-08-16 08:03:02.035', '2024-08-16 08:03:02.035', 30);
INSERT INTO section (title, intro, content, html, tags, is_html, read_count, special_id, seq, create_time, update_time, publish_time, status) VALUES ('测试小结1', '', '测试小结1测试小结1测试小结1测试小结1测试小结1测试小结1测试小结1测试小结1', '', '', 0, 0, 50585244, 1, '2024-08-16 07:56:06.646', '2024-08-16 07:56:23.648', '2024-08-16 07:56:23.648', 30);

-- 创建 site 表
DROP TABLE IF EXISTS site;
CREATE TABLE site
(
    id          INTEGER PRIMARY KEY AUTOINCREMENT, -- 站点 ID
    title       TEXT,                              -- 标题
    intro       TEXT,                              -- 简介
    slogan      TEXT,                              -- 个性签名
    cover       TEXT,                              -- 封面图
    copyright   TEXT,                              -- 版权信息
    icp         TEXT,                              -- icp 相关信息
    update_time DATETIME,                          -- 更新时间
    extra       TEXT,                              -- 额外的信息, json 字符串
    status      INTEGER                            -- 网站信息状态: 0-未启用；1-已启用
);
INSERT INTO site (title, intro, slogan, cover, copyright, icp, update_time, extra, status) VALUES ('test', 'test', 'test', 'https://flygoose-admin.helloworld.net/static/img/909099273827.png', '1', '1', '2024-08-21 18:56:09.000', '1', 1);

-- 创建 webmaster 表
DROP TABLE IF EXISTS webmaster;
CREATE TABLE webmaster
(
    id          INTEGER PRIMARY KEY AUTOINCREMENT, -- 站长 ID
    intro       TEXT,                              -- 简介
    slogan      TEXT,                              -- 站长个性签名
    nicker      TEXT,                              -- 站长昵称
    avatar      TEXT,                              -- 站长头像
    job         TEXT,                              -- 站长职业
    email       TEXT,                              -- 站长邮箱
    qq          TEXT,                              -- 站长 QQ 号
    wechat      TEXT,                              -- 站长微信二维码
    reward_code TEXT,                              -- 站长打赏二维码
    status      INTEGER,                           -- 状态: 0-未启用；1-已启用
    update_time DATETIME                           -- 创建时间
);
INSERT INTO webmaster (intro, slogan, nicker, avatar, job, email, qq, wechat, reward_code, status, update_time) VALUES ('萌萌的博客', '做有价值的产品才是王道', '萌萌', 'https://test-blog.helloworld.net/static/img/435237564518.heic', '总裁', '123456@163.com', '1232132132', '12312312312', 'https://test-blog.helloworld.net/static/img/347000360279.heic', 1, '2024-08-16 09:08:26.662');
COMMIT;