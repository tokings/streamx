SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_app_backup
-- ----------------------------
DROP TABLE IF EXISTS `t_app_backup`;
CREATE TABLE `t_app_backup` (
`ID` bigint(20) NOT NULL AUTO_INCREMENT,
`APP_ID` bigint(20) DEFAULT NULL,
`SQL_ID` bigint(20) DEFAULT NULL,
`CONFIG_ID` bigint(20) DEFAULT NULL,
`PATH` varchar(255) DEFAULT NULL,
`DESCRIPTION` varchar(255) DEFAULT NULL,
`CREATE_TIME` datetime DEFAULT NULL,
PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_flame_graph
-- ----------------------------
DROP TABLE IF EXISTS `t_flame_graph`;
CREATE TABLE `t_flame_graph` (
`ID` bigint(20) NOT NULL AUTO_INCREMENT,
`APP_ID` bigint(20) DEFAULT NULL,
`PROFILER` varchar(255) DEFAULT NULL,
`TIMELINE` datetime DEFAULT NULL,
`CONTENT` varchar(2000) DEFAULT NULL,
PRIMARY KEY (`ID`) USING BTREE,
KEY `INX_TIME` (`TIMELINE`) USING HASH,
KEY `INX_APPID` (`APP_ID`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_flink_app
-- ----------------------------
DROP TABLE IF EXISTS `t_flink_app`;

CREATE TABLE `t_flink_app` (
`ID` bigint(20) NOT NULL AUTO_INCREMENT,
`JOB_TYPE` int(1) DEFAULT NULL,
`EXECUTION_MODE` int(10) DEFAULT NULL,
`PROJECT_ID` varchar(64) DEFAULT NULL,
`JOB_NAME` varchar(255) DEFAULT NULL,
`MODULE` varchar(255) DEFAULT NULL,
`JAR` varchar(255) DEFAULT NULL,
`MAIN_CLASS` varchar(255) DEFAULT NULL,
`ARGS` varchar(255) DEFAULT NULL,
`OPTIONS` text,
`USER_ID` int(25) DEFAULT NULL,
`APP_ID` varchar(255) DEFAULT NULL,
`APP_TYPE` int(1) DEFAULT NULL,
`DURATION` bigint(20) DEFAULT NULL,
`JOB_ID` varchar(64) DEFAULT NULL,
`STATE` varchar(50) DEFAULT NULL,
`RESTART_SIZE` int(10) DEFAULT NULL,
`RESTART_COUNT` int(10) DEFAULT NULL,
`CP_THRESHOLD` int(10) DEFAULT NULL,
`DYNAMIC_OPTIONS` text,
`DESCRIPTION` varchar(255) DEFAULT NULL,
`RESOLVE_ORDER` smallint(1) DEFAULT NULL,
`FLAME_GRAPH` tinyint(1) DEFAULT '0',
`JM_MEMORY` int(10) DEFAULT NULL,
`TM_MEMORY` int(255) DEFAULT NULL,
`TOTAL_TASK` int(10) DEFAULT NULL,
`TOTAL_TM` int(10) DEFAULT NULL,
`TOTAL_SLOT` int(10) DEFAULT NULL,
`AVAILABLE_SLOT` int(10) DEFAULT NULL,
`OPTION_STATE` int(11) DEFAULT NULL,
`TRACKING` int(1) DEFAULT NULL,
`CREATE_TIME` datetime DEFAULT NULL,
`DEPLOY` int(1) DEFAULT '0',
`START_TIME` datetime DEFAULT NULL,
`END_TIME` datetime DEFAULT NULL,
`ALERT_EMAIL` varchar(255) DEFAULT NULL,
PRIMARY KEY (`ID`) USING BTREE,
KEY `INX_STATE` (`STATE`) USING BTREE,
KEY `INX_JOB_TYPE` (`JOB_TYPE`) USING BTREE,
KEY `INX_TRACK` (`TRACKING`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_flink_config
-- ----------------------------
DROP TABLE IF EXISTS `t_flink_config`;
CREATE TABLE `t_flink_config` (
`ID` bigint(20) NOT NULL AUTO_INCREMENT,
`APP_ID` bigint(20) NOT NULL,
`FORMAT` tinyint(1) NOT NULL DEFAULT '0',
`VERSION` int(10) NOT NULL,
`LATEST` tinyint(1) NOT NULL DEFAULT '0',
`CONTENT` text NOT NULL,
`CREATE_TIME` datetime DEFAULT NULL,
PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_flink_effective
-- ----------------------------
DROP TABLE IF EXISTS `t_flink_effective`;
CREATE TABLE `t_flink_effective` (
`ID` bigint(20) NOT NULL AUTO_INCREMENT,
`APP_ID` bigint(20) NOT NULL,
`TARGET_TYPE` int(1) NOT NULL COMMENT '1) config 2) flink sql',
`TARGET_ID` bigint(20) NOT NULL COMMENT 'configId or sqlId',
`CREATE_TIME` datetime DEFAULT NULL,
PRIMARY KEY (`ID`) USING BTREE,
UNIQUE KEY `UN_INX` (`APP_ID`,`TARGET_TYPE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_flink_log
-- ----------------------------
DROP TABLE IF EXISTS `t_flink_log`;
CREATE TABLE `t_flink_log` (
`ID` bigint(20) NOT NULL AUTO_INCREMENT,
`APP_ID` bigint(20) DEFAULT NULL,
`YARN_APP_ID` varchar(50) DEFAULT NULL,
`SUCCESS` tinyint(1) DEFAULT NULL,
`EXCEPTION` text,
`START_TIME` datetime DEFAULT NULL,
PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_flink_project
-- ----------------------------
DROP TABLE IF EXISTS `t_flink_project`;
CREATE TABLE `t_flink_project` (
`ID` bigint(64) NOT NULL AUTO_INCREMENT,
`NAME` varchar(255) DEFAULT NULL,
`URL` varchar(1000) DEFAULT NULL,
`BRANCHES` varchar(1000) DEFAULT NULL,
`USERNAME` varchar(255) DEFAULT NULL,
`PASSWORD` varchar(255) DEFAULT NULL,
`POM` varchar(255) DEFAULT NULL,
`TYPE` int(1) DEFAULT NULL,
`REPOSITORY` int(1) DEFAULT NULL,
`DATE` datetime DEFAULT NULL,
`LASTBUILD` datetime DEFAULT NULL,
`DESCRIPTION` varchar(255) DEFAULT NULL,
`BUILDSTATE` int(1) DEFAULT '-1',
PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_flink_savepoint
-- ----------------------------
DROP TABLE IF EXISTS `t_flink_savepoint`;
CREATE TABLE `t_flink_savepoint` (
`ID` bigint(50) NOT NULL AUTO_INCREMENT,
`APP_ID` bigint(50) NOT NULL,
`TYPE` int(2) DEFAULT NULL,
`PATH` varchar(255) DEFAULT NULL,
`LATEST` tinyint(4) NOT NULL,
`TRIGGER_TIME` datetime DEFAULT NULL,
`CREATE_TIME` datetime DEFAULT NULL,
PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_flink_sql
-- ----------------------------
DROP TABLE IF EXISTS `t_flink_sql`;
CREATE TABLE `t_flink_sql` (
`ID` bigint(20) NOT NULL,
`APP_ID` bigint(20) DEFAULT NULL,
`SQL` text,
`DEPENDENCY` text,
`VERSION` int(20) DEFAULT NULL,
`CANDIDATE` tinyint(1) NOT NULL DEFAULT '0',
`CREATE_TIME` datetime DEFAULT NULL,
PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_flink_tutorial
-- ----------------------------
DROP TABLE IF EXISTS `t_flink_tutorial`;
CREATE TABLE `t_flink_tutorial` (
`ID` int(11) NOT NULL AUTO_INCREMENT,
`TYPE` int(11) DEFAULT NULL,
`NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
`CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
`CREATE_TIME` date DEFAULT NULL,
PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu` (
`MENU_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单/按钮ID',
`PARENT_ID` bigint(20) NOT NULL COMMENT '上级菜单ID',
`MENU_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单/按钮名称',
`PATH` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '对应路由path',
`COMPONENT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '对应路由组件component',
`PERMS` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '权限标识',
`ICON` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图标',
`TYPE` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型 0菜单 1按钮',
`DISPLAY` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '菜单是否显示',
`ORDER_NUM` double(20,0) DEFAULT NULL COMMENT '排序',
`CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
`MODIFY_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`MENU_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
`ROLE_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
`ROLE_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
`REMARK` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色描述',
`CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
`MODIFY_TIME` datetime DEFAULT NULL COMMENT '修改时间',
`ROLE_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色标识',
PRIMARY KEY (`ROLE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu` (
`ROLE_ID` bigint(20) NOT NULL,
`MENU_ID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_setting
-- ----------------------------
DROP TABLE IF EXISTS `t_setting`;
CREATE TABLE `t_setting` (
`NUM` int(10) DEFAULT NULL,
`KEY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
`VALUE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
`TITLE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
`DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
PRIMARY KEY (`KEY`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
`USER_ID` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
`USERNAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录用户名',
`NICK_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
`SALT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码加盐',
`PASSWORD` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
`DEPT_ID` bigint(20) DEFAULT NULL COMMENT '部门ID',
`EMAIL` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
`MOBILE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系电话',
`STATUS` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态 0锁定 1有效',
`CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
`MODIFY_TIME` datetime DEFAULT NULL COMMENT '修改时间',
`LAST_LOGIN_TIME` datetime DEFAULT NULL COMMENT '最近访问时间',
`SEX` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '性别 0男 1女 2保密',
`DESCRIPTION` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
`AVATAR` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户头像',
`USER_TYPE` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2' COMMENT '用户类型 1内部用户 2外部用户',
PRIMARY KEY (`USER_ID`) USING BTREE,
UNIQUE KEY `UN_USERNAME` (`NICK_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
`USER_ID` bigint(20) DEFAULT NULL COMMENT '用户ID',
`ROLE_ID` bigint(20) DEFAULT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET FOREIGN_KEY_CHECKS = 1;

COMMIT
