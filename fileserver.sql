-- Description: fileserver数据库初始化脚本
-- 创建数据库
CREATE DATABASE IF NOT EXISTS fileserver DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

-- 使用数据库
USE fileserver;

-- 创建文件表
CREATE TABLE IF NOT EXISTS `tbl_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件hash',
  `file_name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `file_size` bigint(20) DEFAULT '0' COMMENT '文件大小',
  `file_addr` varchar(1024) NOT NULL DEFAULT '' COMMENT '文件存储地址',
  `create_at` datetime DEFAULT NOW() COMMENT '创建时间',
  `update_at` datetime DEFAULT NOW() on update current_timestamp() COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '文件状态(可用/禁用/已删除)',
  `ext1` int(11) DEFAULT '0' COMMENT '扩展字段1',
  `ext2` text COMMENT '扩展字段2',
  PRIMARY KEY (`id`) COMMENT '主键',
  UNIQUE KEY `idx_file_sha1` (`file_sha1`) COMMENT '唯一索引',
  KEY `idx_status` (`status`)  COMMENT '状态索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 创建用户表
CREATE TABLE IF NOT EXISTS `tbl_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pwd` varchar(255) NOT NULL DEFAULT '' COMMENT '用户encode密码',
  `email` varchar(64) DEFAULT '' COMMENT '用户邮箱',
  `phone` varchar(128) DEFAULT '' COMMENT '用户手机号',
  `email_validated` tinyint(1) DEFAULT 0 COMMENT '邮箱是否验证',
  `phone_validated` tinyint(1) DEFAULT 0 COMMENT '手机是否验证',
  `signup_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '注册日期',
  `last_active` datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT '最后活跃时间戳',
  `profile` text COMMENT '用户属性',
  `status` tinyint(11) NOT NULL DEFAULT '0' COMMENT '用户状态(启用/禁用/锁定/标记删除)', 
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_name` (`user_name`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 创建用户token表
CREATE TABLE IF NOT EXISTS `tbl_user_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
  `user_token` varchar(40) NOT NULL DEFAULT '' COMMENT '用户token',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 创建用户文件表
CREATE TABLE IF NOT EXISTS `tbl_user_file`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
  `file_sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件hash',
  `file_size` bigint(20) DEFAULT '0' COMMENT '文件大小',
  `file_name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `upload_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `last_update` datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '文件状态(0可用/1已删除/2禁用)',
  PRIMARY KEY (`id`) COMMENT '主键',
  UNIQUE KEY `idx_user_file` (`user_name`, `file_sha1`) COMMENT '唯一索引',
  KEY `idx_status` (`status`)  COMMENT '状态索引',
  KEY `idx_user_id` (`user_name`)  COMMENT '用户索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;