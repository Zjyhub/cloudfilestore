IF NOT EXISTS TABLE `tbl_file`;
CREATE TABLE `tbl_file` (
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

IF NOT EXISTS TABLE `tbl_user`;
CREATE TABLE `tbl_user` (
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
  UNIQUE KEY `idx_phone` (`phone`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
