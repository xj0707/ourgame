/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : na_gameplaza

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-06-22 18:56:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for na_admin
-- ----------------------------
DROP TABLE IF EXISTS `na_admin`;
CREATE TABLE `na_admin` (
  `id` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `encrypt` varchar(6) NOT NULL DEFAULT '',
  `lastloginip` int(10) NOT NULL DEFAULT '0',
  `lastlogintime` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(40) NOT NULL DEFAULT '',
  `mobile` varchar(11) NOT NULL DEFAULT '',
  `realname` varchar(50) NOT NULL DEFAULT '',
  `openid` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(2:无效,1:有效)',
  `updatetime` int(10) NOT NULL DEFAULT '0',
  `merchantId` int(3) DEFAULT '0',
  `parentId` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of na_admin
-- ----------------------------
INSERT INTO `na_admin` VALUES ('1', 'supadminxj', 'b65f703bcb8dc7cae8d22abfb8895d21', '', '-1411541392', '1498112730', '5552123@qq.com', '18888873646', '阿杜', '', '1', '1477623198', '0', '0');
INSERT INTO `na_admin` VALUES ('19', 'sl-mch-1497491181290', 'e68aae7b1037fb229c080e3fec01bcb5', '', '-1062730868', '1497492845', 'sl@qq.com', '', '', '', '1', '0', '156', '0');
INSERT INTO `na_admin` VALUES ('20', 'abc-mch-1498056240616', 'b0e0f4120e5af2bbc743c0c50e63f693', '', '0', '0', '', '', '', '', '1', '0', '457', '0');
INSERT INTO `na_admin` VALUES ('21', 'aaa-mch-1498056410866', 'b0e0f4120e5af2bbc743c0c50e63f693', '', '0', '0', '', '', '', '', '1', '0', '986', '0');
INSERT INTO `na_admin` VALUES ('22', 'ad-mch-1498057542675', 'b0e0f4120e5af2bbc743c0c50e63f693', '', '791957031', '1498061063', '', '', '', '', '1', '0', '279', '0');
INSERT INTO `na_admin` VALUES ('23', 'Tang-mch-1498095396541', 'b0e0f4120e5af2bbc743c0c50e63f693', '', '0', '0', '', '', '', '', '1', '0', '805', '0');
INSERT INTO `na_admin` VALUES ('24', 'tang-mch-1498095492802', 'b0e0f4120e5af2bbc743c0c50e63f693', '', '0', '0', '', '', '', '', '1', '0', '108', '0');

-- ----------------------------
-- Table structure for na_admingroup
-- ----------------------------
DROP TABLE IF EXISTS `na_admingroup`;
CREATE TABLE `na_admingroup` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `description` text COMMENT '权限的描述',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '角色拥有的权限id，多个权限 , 隔开',
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `updatetime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of na_admingroup
-- ----------------------------
INSERT INTO `na_admingroup` VALUES ('1', '推锅游戏', '可以操作推锅游戏的所有功能', '87,88,122,123,125,142,143,92,93,94,95,126,127,96,150,98', '0', '1493354501');
INSERT INTO `na_admingroup` VALUES ('2', '推筒子', '可以操作所有推筒子的权限', '100,104,137,138,139,140,141,105,144,145,146,147,148,106,149,107', '0', '1493354490');
INSERT INTO `na_admingroup` VALUES ('3', '牌九', '可以操作所有的牌九的功能', '101,108,109,110,111', '0', '1493090781');
INSERT INTO `na_admingroup` VALUES ('4', '后台公告', '管理公告，邮件，玩家反馈', '66,71,79,67,74,91,75,81,68,80,90,69,82,83', '0', '1493090821');
INSERT INTO `na_admingroup` VALUES ('5', '玩家管理', '管理玩家功能', '32,70,86,113,114,115,116,117,118,119,120,121,151,152', '0', '1493621113');
INSERT INTO `na_admingroup` VALUES ('6', '系统设置', '房卡商店配置', '102,103,128', '0', '1493090965');
INSERT INTO `na_admingroup` VALUES ('8', '子管理员配置', '添加管理员等功能', '131,132,133,134,135,136', '0', '1493091056');
INSERT INTO `na_admingroup` VALUES ('9', '玩家购买房卡日志', '可以查看玩家购买房卡的记录', '153,154,155,156', '0', '1497858516');

-- ----------------------------
-- Table structure for na_admingroupaccess
-- ----------------------------
DROP TABLE IF EXISTS `na_admingroupaccess`;
CREATE TABLE `na_admingroupaccess` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of na_admingroupaccess
-- ----------------------------
INSERT INTO `na_admingroupaccess` VALUES ('19', '1');
INSERT INTO `na_admingroupaccess` VALUES ('20', '1');
INSERT INTO `na_admingroupaccess` VALUES ('21', '1');
INSERT INTO `na_admingroupaccess` VALUES ('22', '1');
INSERT INTO `na_admingroupaccess` VALUES ('23', '1');
INSERT INTO `na_admingroupaccess` VALUES ('24', '1');
INSERT INTO `na_admingroupaccess` VALUES ('19', '2');
INSERT INTO `na_admingroupaccess` VALUES ('20', '2');
INSERT INTO `na_admingroupaccess` VALUES ('21', '2');
INSERT INTO `na_admingroupaccess` VALUES ('22', '2');
INSERT INTO `na_admingroupaccess` VALUES ('23', '2');
INSERT INTO `na_admingroupaccess` VALUES ('24', '2');
INSERT INTO `na_admingroupaccess` VALUES ('19', '4');
INSERT INTO `na_admingroupaccess` VALUES ('20', '4');
INSERT INTO `na_admingroupaccess` VALUES ('21', '4');
INSERT INTO `na_admingroupaccess` VALUES ('22', '4');
INSERT INTO `na_admingroupaccess` VALUES ('23', '4');
INSERT INTO `na_admingroupaccess` VALUES ('24', '4');
INSERT INTO `na_admingroupaccess` VALUES ('19', '5');
INSERT INTO `na_admingroupaccess` VALUES ('20', '5');
INSERT INTO `na_admingroupaccess` VALUES ('21', '5');
INSERT INTO `na_admingroupaccess` VALUES ('22', '5');
INSERT INTO `na_admingroupaccess` VALUES ('23', '5');
INSERT INTO `na_admingroupaccess` VALUES ('24', '5');
INSERT INTO `na_admingroupaccess` VALUES ('19', '6');
INSERT INTO `na_admingroupaccess` VALUES ('19', '8');
INSERT INTO `na_admingroupaccess` VALUES ('20', '8');
INSERT INTO `na_admingroupaccess` VALUES ('21', '8');
INSERT INTO `na_admingroupaccess` VALUES ('22', '8');
INSERT INTO `na_admingroupaccess` VALUES ('23', '8');
INSERT INTO `na_admingroupaccess` VALUES ('24', '8');
INSERT INTO `na_admingroupaccess` VALUES ('20', '9');
INSERT INTO `na_admingroupaccess` VALUES ('21', '9');
INSERT INTO `na_admingroupaccess` VALUES ('22', '9');
INSERT INTO `na_admingroupaccess` VALUES ('23', '9');
INSERT INTO `na_admingroupaccess` VALUES ('24', '9');

-- ----------------------------
-- Table structure for na_adminlog
-- ----------------------------
DROP TABLE IF EXISTS `na_adminlog`;
CREATE TABLE `na_adminlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `m` varchar(15) NOT NULL,
  `c` varchar(20) NOT NULL,
  `a` varchar(20) NOT NULL,
  `querystring` varchar(255) NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `username` varchar(20) NOT NULL,
  `ip` int(10) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of na_adminlog
-- ----------------------------

-- ----------------------------
-- Table structure for na_broadcast
-- ----------------------------
DROP TABLE IF EXISTS `na_broadcast`;
CREATE TABLE `na_broadcast` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公告内容',
  `time` int(11) DEFAULT NULL,
  `un32HallID` int(11) DEFAULT '0' COMMENT '游戏类别 0 为广场 其他为游戏的ID',
  `start_time` int(11) DEFAULT NULL,
  `end_time` int(11) DEFAULT NULL,
  `interval` int(10) unsigned zerofill DEFAULT '0000000000' COMMENT '时间间隔秒数',
  `merchantId` int(3) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='公告';

-- ----------------------------
-- Records of na_broadcast
-- ----------------------------

-- ----------------------------
-- Table structure for na_buylog
-- ----------------------------
DROP TABLE IF EXISTS `na_buylog`;
CREATE TABLE `na_buylog` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL COMMENT '管理员的ID',
  `user_id` int(11) NOT NULL COMMENT '玩家ID',
  `user_name` varchar(128) DEFAULT NULL,
  `gem_number` int(11) NOT NULL COMMENT '购买房卡数量',
  `coins_number` double(10,2) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `merchantId` int(3) DEFAULT '0',
  `user_account` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购买日志';

-- ----------------------------
-- Records of na_buylog
-- ----------------------------

-- ----------------------------
-- Table structure for na_gamemail
-- ----------------------------
DROP TABLE IF EXISTS `na_gamemail`;
CREATE TABLE `na_gamemail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `time` int(11) DEFAULT '0',
  `from` varchar(255) DEFAULT NULL COMMENT '来源于谁发送的',
  `fromto` int(11) DEFAULT NULL COMMENT '发送给那个玩家ID',
  `merchantId` int(3) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of na_gamemail
-- ----------------------------

-- ----------------------------
-- Table structure for na_gameroomtemplate_tuiguo
-- ----------------------------
DROP TABLE IF EXISTS `na_gameroomtemplate_tuiguo`;
CREATE TABLE `na_gameroomtemplate_tuiguo` (
  `un32ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `szName` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '模板名字',
  `un32UserID` int(11) NOT NULL DEFAULT '0' COMMENT '0为系统模版',
  `bIfTax` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否抽水',
  `fWinTaxRate` int(2) NOT NULL DEFAULT '0' COMMENT '抽水比率（赢）',
  `fLoseTaxRate` int(2) NOT NULL DEFAULT '0' COMMENT '抽水比率（输）',
  `un32TotalAnte` int(11) NOT NULL DEFAULT '0' COMMENT '锅底大小',
  `un32RoomLiveSecond` int(11) NOT NULL DEFAULT '0' COMMENT '房间时间',
  `bIfLookOn` tinyint(1) NOT NULL DEFAULT '0' COMMENT '允许旁观',
  `un32OnLookerNum` int(11) NOT NULL DEFAULT '0' COMMENT '旁观者数量',
  `un32InitScore` int(11) NOT NULL DEFAULT '0' COMMENT '初始积分',
  `eForbidChat` int(1) NOT NULL DEFAULT '0' COMMENT '禁止聊天',
  `un32SingleScore` int(11) NOT NULL DEFAULT '0' COMMENT '单注积分',
  `un32IfActive` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否应用',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '模板备注',
  `merchantId` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`un32ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_gameroomtemplate_tuiguo
-- ----------------------------
INSERT INTO `na_gameroomtemplate_tuiguo` VALUES ('1', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '0');
INSERT INTO `na_gameroomtemplate_tuiguo` VALUES ('2', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '457');
INSERT INTO `na_gameroomtemplate_tuiguo` VALUES ('3', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '986');
INSERT INTO `na_gameroomtemplate_tuiguo` VALUES ('4', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '279');
INSERT INTO `na_gameroomtemplate_tuiguo` VALUES ('5', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '805');
INSERT INTO `na_gameroomtemplate_tuiguo` VALUES ('6', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '108');

-- ----------------------------
-- Table structure for na_gameroomtemplate_tuitongzi
-- ----------------------------
DROP TABLE IF EXISTS `na_gameroomtemplate_tuitongzi`;
CREATE TABLE `na_gameroomtemplate_tuitongzi` (
  `un32ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `szName` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '模板名字',
  `un32UserID` int(11) NOT NULL DEFAULT '0' COMMENT '0为系统模版',
  `bIfTax` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否抽水',
  `fWinTaxRate` int(2) NOT NULL DEFAULT '0' COMMENT '抽水比率（赢）',
  `fLoseTaxRate` int(2) NOT NULL DEFAULT '0' COMMENT '抽水比率（输）',
  `un32TotalAnte` int(11) NOT NULL DEFAULT '0' COMMENT '锅底大小',
  `un32RoomLiveSecond` int(11) NOT NULL DEFAULT '0' COMMENT '房间时间',
  `bIfLookOn` tinyint(1) NOT NULL DEFAULT '0' COMMENT '允许旁观',
  `un32OnLookerNum` int(11) NOT NULL DEFAULT '0' COMMENT '旁观者数量',
  `un32InitScore` int(11) NOT NULL DEFAULT '0' COMMENT '初始积分',
  `eForbidChat` int(1) NOT NULL DEFAULT '0' COMMENT '禁止聊天',
  `un32SingleScore` int(11) NOT NULL DEFAULT '0' COMMENT '单注积分',
  `un32IfActive` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否应用',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '模板备注',
  `merchantId` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`un32ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_gameroomtemplate_tuitongzi
-- ----------------------------
INSERT INTO `na_gameroomtemplate_tuitongzi` VALUES ('1', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '0');
INSERT INTO `na_gameroomtemplate_tuitongzi` VALUES ('2', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '457');
INSERT INTO `na_gameroomtemplate_tuitongzi` VALUES ('3', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '986');
INSERT INTO `na_gameroomtemplate_tuitongzi` VALUES ('4', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '279');
INSERT INTO `na_gameroomtemplate_tuitongzi` VALUES ('5', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '805');
INSERT INTO `na_gameroomtemplate_tuitongzi` VALUES ('6', '系统模板', '0', '1', '10', '5', '5000', '0', '1', '10', '10000', '0', '500', '1', null, '108');
INSERT INTO `na_gameroomtemplate_tuitongzi` VALUES ('7', 'tg', '976460', '1', '50', '50', '500', '1800', '0', '0', '5000', '0', '5', '1', null, '0');

-- ----------------------------
-- Table structure for na_gameserver
-- ----------------------------
DROP TABLE IF EXISTS `na_gameserver`;
CREATE TABLE `na_gameserver` (
  `un32GameServerID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '大厅ID',
  `un32GameKindID` int(11) NOT NULL DEFAULT '0' COMMENT '类型ID',
  `szGameServerName` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '大厅名称',
  `szGameServerPwd` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '大厅密码',
  PRIMARY KEY (`un32GameServerID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_gameserver
-- ----------------------------
INSERT INTO `na_gameserver` VALUES ('6', '10000', '推锅大厅一', 'abc123');
INSERT INTO `na_gameserver` VALUES ('7', '10001', '推筒子大厅一', 'abc123');
INSERT INTO `na_gameserver` VALUES ('10', '20000', '四川麻将', 'abc123');
INSERT INTO `na_gameserver` VALUES ('11', '0', '广场', '0');

-- ----------------------------
-- Table structure for na_gameuser
-- ----------------------------
DROP TABLE IF EXISTS `na_gameuser`;
CREATE TABLE `na_gameuser` (
  `un32UserID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `eUserCate` int(11) unsigned zerofill NOT NULL COMMENT '0:无;1:普通玩家',
  `szUserName` char(30) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `password` char(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '登录密码',
  `szNickName` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '昵称',
  `n64Score` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分',
  `dGold` double(20,6) NOT NULL DEFAULT '0.000000' COMMENT '金币',
  `n64RoomCardNum` bigint(20) NOT NULL DEFAULT '0' COMMENT '房卡数量',
  `tRegisteUTCMilsec` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `tLastLoginUTCMilsec` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后一次登录时间',
  `bSex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别',
  `status` tinyint(1) DEFAULT '1' COMMENT '1为正常0为禁用',
  `islogin` tinyint(1) DEFAULT '0' COMMENT '0为未在线1为在线',
  `userPicture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '头像图片url',
  `userAge` int(11) DEFAULT NULL COMMENT '用户年龄',
  `userPhone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户电话号码',
  `userQQ` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户QQ号',
  `userWeiXin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户微信号',
  `un8HeadImage` tinyint(1) NOT NULL DEFAULT '0' COMMENT '头像编号',
  `merchantId` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`un32UserID`),
  UNIQUE KEY `szUserName` (`szUserName`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=889739 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of na_gameuser
-- ----------------------------
INSERT INTO `na_gameuser` VALUES ('220453', '00000000000', 'slplayer001', '96e79218965eb72c92a549dd5a330112', 'slplayer001', '0', '109128.000000', '1506', '0', '1498117849', '0', '1', '0', null, null, null, null, null, '6', '156');
INSERT INTO `na_gameuser` VALUES ('290292', '00000000000', 'slplayer003', '96e79218965eb72c92a549dd5a330112', 'slplayer003', '0', '908.000000', '184', '0', '1498019548', '1', '1', '0', null, null, null, null, null, '18', '156');
INSERT INTO `na_gameuser` VALUES ('373018', '00000000000', 'player12', '96e79218965eb72c92a549dd5a330112', 'player12', '0', '9246.000000', '2366', '0', '1498058446', '0', '1', '0', null, null, null, null, null, '21', '111');
INSERT INTO `na_gameuser` VALUES ('559690', '00000000000', 'slplayer007', '96e79218965eb72c92a549dd5a330112', 'slplayer007', '0', '527.000000', '0', '0', '1498012849', '0', '1', '0', null, null, null, null, null, '27', '156');
INSERT INTO `na_gameuser` VALUES ('889738', '00000000000', 'szs001', '96e79218965eb72c92a549dd5a330112', 'szs001', '0', '9736.000000', '0', '0', '1498018787', '0', '1', '0', null, null, null, null, null, '9', '156');

-- ----------------------------
-- Table structure for na_help
-- ----------------------------
DROP TABLE IF EXISTS `na_help`;
CREATE TABLE `na_help` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `content` varchar(1024) COLLATE utf8_bin DEFAULT NULL COMMENT '帮助手册内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='帮助手册';

-- ----------------------------
-- Records of na_help
-- ----------------------------

-- ----------------------------
-- Table structure for na_mailoperation
-- ----------------------------
DROP TABLE IF EXISTS `na_mailoperation`;
CREATE TABLE `na_mailoperation` (
  `un32ID` int(11) NOT NULL AUTO_INCREMENT,
  `un32MailID` int(11) NOT NULL DEFAULT '0',
  `un32UserID` int(11) NOT NULL DEFAULT '0',
  `bIfReaded` tinyint(1) NOT NULL DEFAULT '0',
  `bIfDeleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`un32ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_mailoperation
-- ----------------------------

-- ----------------------------
-- Table structure for na_menu
-- ----------------------------
DROP TABLE IF EXISTS `na_menu`;
CREATE TABLE `na_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT COMMENT '菜单栏id',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `parentid` smallint(6) DEFAULT '0' COMMENT '父级id',
  `icon` varchar(20) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `c` varchar(20) DEFAULT NULL COMMENT '控制器名称',
  `a` varchar(20) DEFAULT NULL COMMENT '方法名称',
  `data` varchar(50) NOT NULL DEFAULT '',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '999' COMMENT '排序',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示(1:显示,2:不显示)',
  `updatetime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`),
  KEY `parentid` (`parentid`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8 COMMENT='后台管理菜单栏';

-- ----------------------------
-- Records of na_menu
-- ----------------------------
INSERT INTO `na_menu` VALUES ('1', '管理员设置', '0', 'fa-users', 'Admin', 'index', '', '', '', '1', '1', '1497858304');
INSERT INTO `na_menu` VALUES ('31', '系统首页', '0', 'fa-bank', 'Index', 'index', '', '', '', '0', '2', '1497858303');
INSERT INTO `na_menu` VALUES ('32', '玩家管理', '0', 'fa-child', 'User', 'index', '', '', '', '2', '1', '1497858304');
INSERT INTO `na_menu` VALUES ('42', '菜单管理', '0', 'fa-cogs', 'Menu', 'index', '', '', '', '11', '1', '1497858310');
INSERT INTO `na_menu` VALUES ('43', '查看管理员', '43', '', 'Admin', 'index', '', '', '', '999', '2', '1482306721');
INSERT INTO `na_menu` VALUES ('44', '添加管理员', '72', '', 'Admin', 'add', '', '', '', '999', '2', '1497858304');
INSERT INTO `na_menu` VALUES ('45', '修改管理员', '72', '', 'Admin', 'edit', '', '', '', '999', '2', '1497858304');
INSERT INTO `na_menu` VALUES ('46', '删除管理员', '72', '', 'Admin', 'del', '', '', '', '999', '2', '1497858304');
INSERT INTO `na_menu` VALUES ('47', '角色管理', '0', ' fa-user', 'Group', 'index', '', '', '', '10', '1', '1497858419');
INSERT INTO `na_menu` VALUES ('48', '查看角色', '47', '', 'Group', 'index', '', '', '', '777', '1', '1497858310');
INSERT INTO `na_menu` VALUES ('49', '添加角色', '62', '', 'Group', 'add', '', '', '', '999', '2', '1497858310');
INSERT INTO `na_menu` VALUES ('50', '修改角色', '62', '', 'Group', 'edit', '', '', '', '999', '2', '1497858310');
INSERT INTO `na_menu` VALUES ('51', '删除角色', '62', '', 'Group', 'del', '', '', '', '999', '2', '1497858310');
INSERT INTO `na_menu` VALUES ('53', '查看管理员', '1', '', 'Admin', 'index', '', '', '', '777', '1', '1497858304');
INSERT INTO `na_menu` VALUES ('55', '查看权限', '48', '', 'Group', 'rule', '', '', '', '999', '2', '1497858310');
INSERT INTO `na_menu` VALUES ('56', '查看菜单', '42', '', 'Menu', 'index', '', '', '', '888', '1', '1497858310');
INSERT INTO `na_menu` VALUES ('58', '修改菜单', '64', '', 'Menu', 'edit', '', '', '', '999', '2', '1497858310');
INSERT INTO `na_menu` VALUES ('59', '删除菜单', '64', '', 'Menu', 'del', '', '', '', '999', '2', '1497858311');
INSERT INTO `na_menu` VALUES ('60', '日志管理', '0', ' fa-list-ul', 'Log', 'index', '', '', '', '12', '2', '1497858311');
INSERT INTO `na_menu` VALUES ('62', '角色操作', '47', '', 'Group', 'info', '', '', '', '888', '2', '1497858310');
INSERT INTO `na_menu` VALUES ('63', '修改权限', '48', '', 'Group', 'editRule', '', '', '', '999', '2', '1497858310');
INSERT INTO `na_menu` VALUES ('64', '菜单操作', '42', '', 'Menu', 'info', '', '', '', '888', '2', '1497858310');
INSERT INTO `na_menu` VALUES ('65', '添加菜单', '64', '', 'Menu', 'add', '', '', '', '888', '2', '1497858310');
INSERT INTO `na_menu` VALUES ('66', '后台公告', '0', ' fa-bullhorn', 'System', 'index', '', '', '', '3', '1', '1497858305');
INSERT INTO `na_menu` VALUES ('67', '发布公告', '71', '', 'System', 'announce', '', '', '', '999', '2', '1497858305');
INSERT INTO `na_menu` VALUES ('68', '发布邮件', '75', '', 'System', 'sendmail', '', '', '', '999', '2', '1497858306');
INSERT INTO `na_menu` VALUES ('69', '玩家反馈', '66', '', 'System', 'propose', '', '', '', '999', '1', '1497858306');
INSERT INTO `na_menu` VALUES ('70', '所有玩家', '32', '', 'User', 'index', '', '', '', '999', '1', '1497858304');
INSERT INTO `na_menu` VALUES ('71', '查看公告', '66', '', 'System', 'index', '', '', '', '888', '1', '1497858305');
INSERT INTO `na_menu` VALUES ('72', '管理员操作', '1', '', 'Admin', 'info', '', '', '', '999', '2', '1497858304');
INSERT INTO `na_menu` VALUES ('74', '删除公告', '71', '', 'System', 'del', '', '', '', '999', '2', '1497858306');
INSERT INTO `na_menu` VALUES ('75', '查看邮件', '66', '', 'System', 'showmail', '', '', '', '888', '1', '1497858306');
INSERT INTO `na_menu` VALUES ('77', '添加帮助手册', '76', '', 'System', 'addhelp', '', '', '', '999', '2', '1482805694');
INSERT INTO `na_menu` VALUES ('78', '修改帮助手册', '76', '', 'System', 'edithelp', '', '', '', '999', '2', '1482805694');
INSERT INTO `na_menu` VALUES ('79', '公告详情', '71', '', 'System', 'show', '', '', '', '888', '2', '1497858305');
INSERT INTO `na_menu` VALUES ('80', '删除邮件', '75', '', 'System', 'delmail', '', '', '', '999', '2', '1497858306');
INSERT INTO `na_menu` VALUES ('81', '邮件详情', '75', '', 'System', 'showinfo', '', '', '', '888', '2', '1497858306');
INSERT INTO `na_menu` VALUES ('82', '反馈详情', '69', '', 'System', 'showpro', '', '', '', '999', '2', '1497858306');
INSERT INTO `na_menu` VALUES ('83', '删除反馈', '69', '', 'System', 'delpro', '', '', '', '999', '2', '1497858306');
INSERT INTO `na_menu` VALUES ('84', '删除手册', '76', '', 'System', 'del', '', '', '', '999', '2', '1482805694');
INSERT INTO `na_menu` VALUES ('85', '帮助手册详情', '76', '', 'System', 'show', '', '', '', '888', '2', '1482805694');
INSERT INTO `na_menu` VALUES ('86', 'id查询', '70', '', 'User', 'likeid', '', '', '', '999', '2', '1497858304');
INSERT INTO `na_menu` VALUES ('87', '推锅游戏', '0', ' fa-gamepad', 'Game', 'index', '', '', '', '4', '1', '1497858306');
INSERT INTO `na_menu` VALUES ('88', '推锅游戏房间', '87', '', 'GameTuiGuo', 'show', '', '', '', '999', '1', '1497858306');
INSERT INTO `na_menu` VALUES ('90', '修改邮件', '75', '', 'System', 'editmail', '', '', '', '999', '2', '1497858306');
INSERT INTO `na_menu` VALUES ('91', '修改公告', '71', '', 'System', 'editbc', '', '', '', '999', '2', '1497858306');
INSERT INTO `na_menu` VALUES ('92', '推锅游戏系统推荐模板', '87', '', 'System', 'template', '', '', '', '999', '1', '1497858307');
INSERT INTO `na_menu` VALUES ('93', '添加模板', '92', '', 'System', 'addtemplate', '', '', '', '999', '2', '1497858307');
INSERT INTO `na_menu` VALUES ('94', '修改模板', '92', '', 'System', 'edittem', '', '', '', '999', '2', '1497858307');
INSERT INTO `na_menu` VALUES ('95', '删除模板', '92', '', 'System', 'deltem', '', '', '', '999', '2', '1497858307');
INSERT INTO `na_menu` VALUES ('96', '推锅游戏玩家自定义模板', '87', '', 'System', 'gameusertel', '', '', '', '999', '1', '1497858307');
INSERT INTO `na_menu` VALUES ('97', '添加金币和房卡日志', '0', 'fa-shopping-cart ', 'BuyLog', 'index', '', '', '', '999', '2', '1497858311');
INSERT INTO `na_menu` VALUES ('98', '下注搓牌时间配置', '87', '', 'System', 'time', '', '', '', '999', '1', '1497858308');
INSERT INTO `na_menu` VALUES ('100', '推筒子', '0', ' fa-gamepad', 'GameTuiTong', 'index', '', '', '', '5', '1', '1497858308');
INSERT INTO `na_menu` VALUES ('101', '牌九', '0', ' fa-gamepad', 'GamePaiJiu', 'index', '', '', '', '6', '2', '1497858309');
INSERT INTO `na_menu` VALUES ('102', '系统设置', '0', 'fa-cog ', 'System', 'index', '', '', '', '7', '1', '1497858309');
INSERT INTO `na_menu` VALUES ('103', '房卡商店', '102', '', 'System', 'roomcard', '', '', '', '999', '1', '1497858309');
INSERT INTO `na_menu` VALUES ('104', '推筒子游戏房间', '100', '', 'GameTuiTong', 'show', '', '', '', '999', '1', '1497858308');
INSERT INTO `na_menu` VALUES ('105', '推筒子系统推荐模板', '100', '', 'GameTuiTong', 'template', '', '', '', '999', '1', '1497858308');
INSERT INTO `na_menu` VALUES ('106', '推筒子玩家自定义模板', '100', '', 'GameTuiTong', 'gameusertel', '', '', '', '999', '1', '1497858309');
INSERT INTO `na_menu` VALUES ('107', '下注搓牌时间配置', '100', '', 'GameTuiTong', 'time', '', '', '', '999', '1', '1497858309');
INSERT INTO `na_menu` VALUES ('108', '游戏房间', '101', '', 'GamePaiJiu', 'show', '', '', '', '999', '1', '1497858309');
INSERT INTO `na_menu` VALUES ('109', '系统模板', '101', '', 'GamePaiJiu', 'template', '', '', '', '999', '1', '1497858309');
INSERT INTO `na_menu` VALUES ('110', '玩家模板', '101', '', 'GamePaiJiu', 'usertel', '', '', '', '999', '1', '1497858309');
INSERT INTO `na_menu` VALUES ('111', '时间配置', '101', '', 'GamePaiJiu', 'time', '', '', '', '999', '1', '1497858309');
INSERT INTO `na_menu` VALUES ('112', '大厅配置', '0', 'fa-map', 'System', 'gamehall', '', '', '', '999', '2', '1497858311');
INSERT INTO `na_menu` VALUES ('113', '用户名查询玩家', '70', '', 'User', 'likeusername', '', '', '', '999', '2', '1497858304');
INSERT INTO `na_menu` VALUES ('114', '购买金币或房卡', '70', '', 'User', 'addcoins', '', '', '', '999', '2', '1497858304');
INSERT INTO `na_menu` VALUES ('115', '发送邮件', '70', '', 'User', 'mail', '', '', '', '999', '2', '1497858305');
INSERT INTO `na_menu` VALUES ('116', '查看所有游戏', '70', '', 'User', 'details', '', '', '', '999', '2', '1497858305');
INSERT INTO `na_menu` VALUES ('117', '推锅游戏房间', '70', '', 'User', 'roomshow', '', '', '', '999', '2', '1497858305');
INSERT INTO `na_menu` VALUES ('118', '推筒子游戏', '70', '', 'User', 'tuitong', '', '', '', '999', '2', '1497858305');
INSERT INTO `na_menu` VALUES ('119', '牌九游戏', '70', '', 'User', 'paijiu', '', '', '', '999', '2', '1497858305');
INSERT INTO `na_menu` VALUES ('120', '推锅游戏房间房间号查询', '70', '', 'User', 'likepwd', '', '', '', '999', '2', '1497858305');
INSERT INTO `na_menu` VALUES ('121', '查看每回合详情', '70', '', 'User', 'roomdetail', '', '', '', '999', '2', '1497858305');
INSERT INTO `na_menu` VALUES ('122', '房间号查询房间', '88', '', 'GameTuiGuo', 'likeroomid', '', '', '', '999', '2', '1497858306');
INSERT INTO `na_menu` VALUES ('123', '查看结果', '88', '', 'GameTuiGuo', 'details', '', '', '', '999', '2', '1497858307');
INSERT INTO `na_menu` VALUES ('125', '用户名查询', '88', '', 'GameTuiGuo', 'likeuser', '', '', '', '999', '2', '1497858307');
INSERT INTO `na_menu` VALUES ('126', '应用模板', '92', '', 'System', 'activetem', '', '', '', '999', '2', '1497858307');
INSERT INTO `na_menu` VALUES ('127', '解除应用模板', '92', '', 'System', 'disactivetem', '', '', '', '999', '2', '1497858307');
INSERT INTO `na_menu` VALUES ('128', '修改', '103', '', 'System', 'editrc', '', '', '', '999', '2', '1497858309');
INSERT INTO `na_menu` VALUES ('129', '用户名查询', '97', '', 'BuyLog', 'searchname', '', '', '', '999', '2', '1497858311');
INSERT INTO `na_menu` VALUES ('130', '时间查询', '97', '', 'BuyLog', 'liketime', '', '', '', '999', '2', '1497858311');
INSERT INTO `na_menu` VALUES ('131', '子管理员配置', '0', 'fa-cog', 'SonAdmin', 'index', '', '', '', '999', '1', '1497858311');
INSERT INTO `na_menu` VALUES ('132', '所有管理员', '131', '', 'SonAdmin', 'index', '', '', '', '999', '1', '1497858311');
INSERT INTO `na_menu` VALUES ('133', '查看管理员', '132', '', 'SonAdmin', 'info', '', '', '', '999', '2', '1497858311');
INSERT INTO `na_menu` VALUES ('134', '编辑管理员', '132', '', 'SonAdmin', 'edit', '', '', '', '999', '2', '1497858311');
INSERT INTO `na_menu` VALUES ('135', '添加管理员', '132', '', 'SonAdmin', 'add', '', '', '', '999', '2', '1497858311');
INSERT INTO `na_menu` VALUES ('136', '删除管理员', '132', '', 'SonAdmin', 'del', '', '', '', '999', '2', '1497858311');
INSERT INTO `na_menu` VALUES ('137', '房间号查询房间', '104', '', 'GameTuiTong', 'likeroomid', '', '', '', '999', '2', '1497858308');
INSERT INTO `na_menu` VALUES ('138', '用户名查询', '104', '', 'GameTuiTong', 'likeuser', '', '', '', '999', '2', '1497858308');
INSERT INTO `na_menu` VALUES ('139', '详情', '104', '', 'GameTuiTong', 'details', '', '', '', '999', '2', '1497858308');
INSERT INTO `na_menu` VALUES ('140', '局详情', '104', '', 'GameTuiTong', 'juinfo', '', '', '', '999', '2', '1497858308');
INSERT INTO `na_menu` VALUES ('141', '回合详情', '104', '', 'GameTuiTong', 'huiinfo', '', '', '', '999', '2', '1497858308');
INSERT INTO `na_menu` VALUES ('142', '每局详情', '88', '', 'GameTuiGuo', 'juinfo', '', '', '', '999', '2', '1497858307');
INSERT INTO `na_menu` VALUES ('143', '回合详情', '88', '', 'GameTuiGuo', 'huiinfo', '', '', '', '999', '2', '1497858307');
INSERT INTO `na_menu` VALUES ('144', '添加模板', '105', '', 'GameTuiTong', 'addtemplate', '', '', '', '999', '2', '1497858308');
INSERT INTO `na_menu` VALUES ('145', '修改模板', '105', '', 'GameTuiTong', 'edittem', '', '', '', '999', '2', '1497858308');
INSERT INTO `na_menu` VALUES ('146', '删除模板', '105', '', 'GameTuiTong', 'deltem', '', '', '', '999', '2', '1497858308');
INSERT INTO `na_menu` VALUES ('147', '应用模板', '105', '', 'GameTuiTong', 'activetem', '', '', '', '999', '2', '1497858309');
INSERT INTO `na_menu` VALUES ('148', '解除应用模板', '105', '', 'GameTuiTong', 'disactivetem', '', '', '', '999', '2', '1497858309');
INSERT INTO `na_menu` VALUES ('149', '删除玩家模板', '106', '', 'GameTuiTong', 'userdeltem', '', '', '', '999', '2', '1497858309');
INSERT INTO `na_menu` VALUES ('150', '删除玩家模板', '96', '', 'System', 'userdeltem', '', '', '', '999', '2', '1497858307');
INSERT INTO `na_menu` VALUES ('151', '推筒子房间号查询', '70', '', 'User', 'likepwdtong', '', '', '', '999', '2', '1497858305');
INSERT INTO `na_menu` VALUES ('152', '推筒子回合详情', '70', '', 'User', 'roomdetailtong', '', '', '', '999', '2', '1497858305');
INSERT INTO `na_menu` VALUES ('153', '玩家购买房卡日志', '0', 'fa-shopping-cart', 'UserBuyFangKa', 'index', '', '', '', '888', '1', '1497858311');
INSERT INTO `na_menu` VALUES ('154', '玩家ID查询', '153', '', 'UserBuyFangKa', 'searchid', '', '', '', '999', '2', null);
INSERT INTO `na_menu` VALUES ('155', '玩家用户名查询', '153', '', 'UserBuyFangKa', 'searchname', '', '', '', '999', '2', null);
INSERT INTO `na_menu` VALUES ('156', '时间查询', '153', '', 'UserBuyFangKa', 'liketime', '', '', '', '999', '2', null);

-- ----------------------------
-- Table structure for na_propose
-- ----------------------------
DROP TABLE IF EXISTS `na_propose`;
CREATE TABLE `na_propose` (
  `id` int(11) NOT NULL,
  `content` varchar(255) DEFAULT NULL COMMENT '反馈的内容',
  `phone` varchar(50) DEFAULT NULL COMMENT '建议人的联系方式',
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='反馈表';

-- ----------------------------
-- Records of na_propose
-- ----------------------------

-- ----------------------------
-- Table structure for na_roomcardconsumeorder
-- ----------------------------
DROP TABLE IF EXISTS `na_roomcardconsumeorder`;
CREATE TABLE `na_roomcardconsumeorder` (
  `un32ID` int(11) NOT NULL AUTO_INCREMENT,
  `un32GameUserID` int(11) NOT NULL,
  `un32ConsumeCardNum` int(11) NOT NULL,
  `un32LogTime` int(11) NOT NULL,
  `bIfCancel` tinyint(1) NOT NULL DEFAULT '0',
  `un32GameServerID` int(1) NOT NULL,
  `un64RoomID` int(22) NOT NULL DEFAULT '0' COMMENT '0创建房间1增加时长',
  PRIMARY KEY (`un32ID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_roomcardconsumeorder
-- ----------------------------
INSERT INTO `na_roomcardconsumeorder` VALUES ('1', '373018', '6', '1498058016', '0', '10', '6');
INSERT INTO `na_roomcardconsumeorder` VALUES ('2', '607326', '6', '1498059266', '0', '11', '6');
INSERT INTO `na_roomcardconsumeorder` VALUES ('3', '220453', '6', '1498095163', '0', '12', '6');
INSERT INTO `na_roomcardconsumeorder` VALUES ('4', '525658', '6', '1498097256', '0', '13', '6');
INSERT INTO `na_roomcardconsumeorder` VALUES ('5', '630537', '6', '1498114625', '0', '14', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('6', '630537', '6', '1498114626', '0', '15', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('7', '630537', '6', '1498114630', '0', '16', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('8', '630537', '6', '1498114630', '0', '17', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('9', '630537', '6', '1498114630', '0', '18', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('10', '630537', '6', '1498114630', '0', '19', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('11', '655764', '6', '1498114672', '0', '20', '6');
INSERT INTO `na_roomcardconsumeorder` VALUES ('12', '630537', '6', '1498116803', '0', '21', '6');
INSERT INTO `na_roomcardconsumeorder` VALUES ('13', '655764', '6', '1498119210', '0', '22', '6');
INSERT INTO `na_roomcardconsumeorder` VALUES ('14', '976460', '6', '1498120309', '0', '23', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('15', '976460', '6', '1498120311', '0', '24', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('16', '976460', '6', '1498120354', '0', '25', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('17', '976460', '6', '1498120358', '0', '26', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('18', '976460', '6', '1498120359', '0', '27', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('19', '976460', '6', '1498120361', '0', '28', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('20', '976460', '6', '1498120361', '0', '29', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('21', '976460', '6', '1498120361', '0', '30', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('22', '976460', '6', '1498120361', '0', '31', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('23', '976460', '6', '1498120361', '0', '32', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('24', '976460', '6', '1498120364', '0', '33', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('25', '976460', '6', '1498120365', '0', '34', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('26', '976460', '6', '1498120365', '0', '35', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('27', '976460', '6', '1498120366', '0', '36', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('28', '976460', '6', '1498120366', '0', '37', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('29', '976460', '6', '1498120366', '0', '38', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('30', '976460', '6', '1498120367', '0', '39', '7');
INSERT INTO `na_roomcardconsumeorder` VALUES ('31', '655764', '6', '1498121181', '0', '40', '6');
INSERT INTO `na_roomcardconsumeorder` VALUES ('32', '655764', '6', '1498121191', '0', '41', '6');

-- ----------------------------
-- Table structure for na_roomrelatedserver
-- ----------------------------
DROP TABLE IF EXISTS `na_roomrelatedserver`;
CREATE TABLE `na_roomrelatedserver` (
  `un32RoomID` int(22) NOT NULL DEFAULT '0',
  `un32GameServerID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`un32RoomID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_roomrelatedserver
-- ----------------------------
INSERT INTO `na_roomrelatedserver` VALUES ('1', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('2', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('3', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('4', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('5', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('6', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('7', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('8', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('9', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('10', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('11', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('12', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('13', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('14', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('15', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('16', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('17', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('18', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('19', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('20', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('21', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('22', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('23', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('24', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('25', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('26', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('27', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('28', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('29', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('30', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('31', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('32', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('33', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('34', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('35', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('36', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('37', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('38', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('39', '7');
INSERT INTO `na_roomrelatedserver` VALUES ('40', '6');
INSERT INTO `na_roomrelatedserver` VALUES ('41', '6');

-- ----------------------------
-- Table structure for na_roomseed
-- ----------------------------
DROP TABLE IF EXISTS `na_roomseed`;
CREATE TABLE `na_roomseed` (
  `un64RoomIDSeed` int(22) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_roomseed
-- ----------------------------
INSERT INTO `na_roomseed` VALUES ('41');

-- ----------------------------
-- Table structure for na_roomshopping
-- ----------------------------
DROP TABLE IF EXISTS `na_roomshopping`;
CREATE TABLE `na_roomshopping` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `roomcard` int(11) DEFAULT NULL,
  `coins` double(10,2) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '0' COMMENT '0正常价格，1特惠价格',
  `merchantId` int(3) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='房卡商店';

-- ----------------------------
-- Records of na_roomshopping
-- ----------------------------
INSERT INTO `na_roomshopping` VALUES ('1', '10', '5.00', '0', '0');
INSERT INTO `na_roomshopping` VALUES ('2', '24', '12.00', '0', '0');
INSERT INTO `na_roomshopping` VALUES ('3', '72', '36.00', '0', '0');
INSERT INTO `na_roomshopping` VALUES ('4', '96', '48.00', '0', '0');
INSERT INTO `na_roomshopping` VALUES ('5', '120', '60.00', '0', '0');
INSERT INTO `na_roomshopping` VALUES ('6', '144', '72.00', '0', '0');

-- ----------------------------
-- Table structure for na_routeserver
-- ----------------------------
DROP TABLE IF EXISTS `na_routeserver`;
CREATE TABLE `na_routeserver` (
  `un32RSID` int(11) NOT NULL DEFAULT '0',
  `aszRSName` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `aszRSPwd` varchar(33) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`un32RSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of na_routeserver
-- ----------------------------
INSERT INTO `na_routeserver` VALUES ('1', 'WYY_RouteServer', 'aabbcc123');

-- ----------------------------
-- Table structure for na_settime_tuiguo
-- ----------------------------
DROP TABLE IF EXISTS `na_settime_tuiguo`;
CREATE TABLE `na_settime_tuiguo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tel_id` int(11) DEFAULT NULL COMMENT '模板ID',
  `un32BetWaitSecond` int(11) DEFAULT NULL COMMENT '下注时间',
  `un32RubCardSecond` int(11) DEFAULT NULL COMMENT '搓牌时间',
  `time` int(11) DEFAULT NULL,
  `merchantId` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_settime_tuiguo
-- ----------------------------
INSERT INTO `na_settime_tuiguo` VALUES ('1', null, '15', '15', null, '0');
INSERT INTO `na_settime_tuiguo` VALUES ('2', '2', '15', '15', '1498057248', '457');
INSERT INTO `na_settime_tuiguo` VALUES ('3', '3', '15', '15', '1498057414', '986');
INSERT INTO `na_settime_tuiguo` VALUES ('4', '4', '15', '15', '1498058545', '279');
INSERT INTO `na_settime_tuiguo` VALUES ('5', '5', '15', '15', '1498096400', '805');
INSERT INTO `na_settime_tuiguo` VALUES ('6', '6', '15', '15', '1498096494', '108');

-- ----------------------------
-- Table structure for na_settime_tuitongzi
-- ----------------------------
DROP TABLE IF EXISTS `na_settime_tuitongzi`;
CREATE TABLE `na_settime_tuitongzi` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tel_id` int(11) DEFAULT NULL COMMENT '模板ID',
  `un32BetWaitSecond` int(11) DEFAULT NULL COMMENT '下注时间',
  `un32RubCardSecond` int(11) DEFAULT NULL COMMENT '搓牌时间',
  `time` int(11) DEFAULT NULL,
  `merchantId` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_settime_tuitongzi
-- ----------------------------
INSERT INTO `na_settime_tuitongzi` VALUES ('1', null, '15', '15', null, '0');
INSERT INTO `na_settime_tuitongzi` VALUES ('2', '2', '15', '15', '1498057248', '457');
INSERT INTO `na_settime_tuitongzi` VALUES ('3', '3', '15', '15', '1498057414', '986');
INSERT INTO `na_settime_tuitongzi` VALUES ('4', '4', '15', '15', '1498058545', '279');
INSERT INTO `na_settime_tuitongzi` VALUES ('5', '5', '15', '15', '1498096400', '805');
INSERT INTO `na_settime_tuitongzi` VALUES ('6', '6', '15', '15', '1498096494', '108');

-- ----------------------------
-- Table structure for na_upgradelog
-- ----------------------------
DROP TABLE IF EXISTS `na_upgradelog`;
CREATE TABLE `na_upgradelog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LastUpgradeTime` bigint(20) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of na_upgradelog
-- ----------------------------

-- ----------------------------
-- Table structure for na_userfeedback
-- ----------------------------
DROP TABLE IF EXISTS `na_userfeedback`;
CREATE TABLE `na_userfeedback` (
  `un32ID` int(11) NOT NULL AUTO_INCREMENT,
  `un32GameUserID` int(11) NOT NULL DEFAULT '0',
  `szContactInfo` varchar(1024) COLLATE utf8_bin DEFAULT NULL,
  `szContent` varchar(1024) COLLATE utf8_bin DEFAULT NULL,
  `un32LogTime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`un32ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_userfeedback
-- ----------------------------

-- ----------------------------
-- Table structure for na_usergoldconsumerecord
-- ----------------------------
DROP TABLE IF EXISTS `na_usergoldconsumerecord`;
CREATE TABLE `na_usergoldconsumerecord` (
  `un32ID` int(11) NOT NULL AUTO_INCREMENT,
  `un32UserID` int(11) NOT NULL DEFAULT '0',
  `un32HallID` int(11) NOT NULL DEFAULT '0',
  `dConsumeGold` double(20,6) NOT NULL DEFAULT '0.000000',
  `dRestGold` double(20,6) NOT NULL DEFAULT '0.000000',
  `un32GotRoomCard` int(11) NOT NULL DEFAULT '0',
  `un32LogTime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`un32ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_usergoldconsumerecord
-- ----------------------------
INSERT INTO `na_usergoldconsumerecord` VALUES ('1', '220453', '0', '4.000000', '9300.000000', '8', '1498013713');
INSERT INTO `na_usergoldconsumerecord` VALUES ('2', '220453', '0', '32.000000', '9268.000000', '64', '1498013719');
INSERT INTO `na_usergoldconsumerecord` VALUES ('3', '220453', '0', '16.000000', '9252.000000', '32', '1498013723');
INSERT INTO `na_usergoldconsumerecord` VALUES ('4', '220453', '0', '2.000000', '9250.000000', '4', '1498013727');
INSERT INTO `na_usergoldconsumerecord` VALUES ('5', '220453', '0', '2.000000', '9248.000000', '4', '1498013731');
INSERT INTO `na_usergoldconsumerecord` VALUES ('6', '290292', '0', '32.000000', '908.000000', '64', '1498019555');
INSERT INTO `na_usergoldconsumerecord` VALUES ('7', '220453', '0', '4.000000', '9244.000000', '8', '1498028859');
INSERT INTO `na_usergoldconsumerecord` VALUES ('8', '373018', '0', '72.000000', '9462.000000', '144', '1498056919');
INSERT INTO `na_usergoldconsumerecord` VALUES ('9', '373018', '0', '72.000000', '9390.000000', '144', '1498056929');
INSERT INTO `na_usergoldconsumerecord` VALUES ('10', '373018', '0', '72.000000', '9318.000000', '144', '1498056933');
INSERT INTO `na_usergoldconsumerecord` VALUES ('11', '373018', '0', '72.000000', '9246.000000', '144', '1498057709');
INSERT INTO `na_usergoldconsumerecord` VALUES ('12', '607326', '0', '72.000000', '9928.000000', '144', '1498059262');
INSERT INTO `na_usergoldconsumerecord` VALUES ('13', '525658', '0', '72.000000', '999928.000000', '144', '1498097135');
INSERT INTO `na_usergoldconsumerecord` VALUES ('14', '254403', '0', '72.000000', '99928.000000', '144', '1498113264');
INSERT INTO `na_usergoldconsumerecord` VALUES ('15', '254403', '0', '72.000000', '99856.000000', '144', '1498113269');
INSERT INTO `na_usergoldconsumerecord` VALUES ('16', '630537', '0', '72.000000', '99928.000000', '144', '1498114598');
INSERT INTO `na_usergoldconsumerecord` VALUES ('17', '630537', '0', '72.000000', '99856.000000', '144', '1498114622');
INSERT INTO `na_usergoldconsumerecord` VALUES ('18', '630537', '0', '72.000000', '99784.000000', '144', '1498114658');
INSERT INTO `na_usergoldconsumerecord` VALUES ('19', '655764', '0', '72.000000', '99928.000000', '144', '1498114669');
INSERT INTO `na_usergoldconsumerecord` VALUES ('20', '630537', '0', '5.000000', '99779.000000', '10', '1498114693');
INSERT INTO `na_usergoldconsumerecord` VALUES ('21', '630537', '0', '5.000000', '99774.000000', '10', '1498114744');
INSERT INTO `na_usergoldconsumerecord` VALUES ('22', '630537', '0', '12.000000', '99762.000000', '24', '1498114792');
INSERT INTO `na_usergoldconsumerecord` VALUES ('23', '655764', '0', '72.000000', '99856.000000', '144', '1498119207');
INSERT INTO `na_usergoldconsumerecord` VALUES ('24', '976460', '0', '5.000000', '483.000000', '10', '1498119409');
INSERT INTO `na_usergoldconsumerecord` VALUES ('25', '976460', '0', '5.000000', '478.000000', '10', '1498120294');
INSERT INTO `na_usergoldconsumerecord` VALUES ('26', '206689', '0', '5.000000', '995.000000', '10', '1498120338');
INSERT INTO `na_usergoldconsumerecord` VALUES ('27', '206689', '0', '12.000000', '983.000000', '24', '1498120350');
INSERT INTO `na_usergoldconsumerecord` VALUES ('28', '206689', '0', '36.000000', '947.000000', '72', '1498120631');
INSERT INTO `na_usergoldconsumerecord` VALUES ('29', '655764', '0', '36.000000', '99800.000000', '72', '1498121150');
INSERT INTO `na_usergoldconsumerecord` VALUES ('30', '655764', '0', '5.000000', '99795.000000', '10', '1498121187');
INSERT INTO `na_usergoldconsumerecord` VALUES ('31', '630537', '0', '72.000000', '99680.000000', '144', '1498121373');
