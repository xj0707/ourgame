/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : na_gameplaza

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2017-09-26 18:14:28
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8 COMMENT='后台管理菜单栏';

-- ----------------------------
-- Records of na_menu
-- ----------------------------
INSERT INTO `na_menu` VALUES ('1', '管理员设置', '0', 'fa-users', 'Admin', 'index', '', '', '', '1', '2', '1501818966');
INSERT INTO `na_menu` VALUES ('31', '系统首页', '0', 'fa-bank', 'Index', 'index', '', '', '', '0', '1', '1501818972');
INSERT INTO `na_menu` VALUES ('32', '玩家管理', '0', 'fa-child', 'User', 'index', '', '', '', '2', '1', '1500519874');
INSERT INTO `na_menu` VALUES ('42', '菜单管理', '0', 'fa-cogs', 'Menu', 'index', '', '', '', '11', '1', '1500519877');
INSERT INTO `na_menu` VALUES ('43', '查看管理员', '43', '', 'Admin', 'index', '', '', '', '999', '2', '1482306721');
INSERT INTO `na_menu` VALUES ('44', '添加管理员', '72', '', 'Admin', 'add', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('45', '修改管理员', '72', '', 'Admin', 'edit', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('46', '删除管理员', '72', '', 'Admin', 'del', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('47', '角色管理', '0', ' fa-user', 'Group', 'index', '', '', '', '10', '1', '1500519877');
INSERT INTO `na_menu` VALUES ('48', '查看角色', '47', '', 'Group', 'index', '', '', '', '777', '1', '1500519877');
INSERT INTO `na_menu` VALUES ('49', '添加角色', '62', '', 'Group', 'add', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('50', '修改角色', '62', '', 'Group', 'edit', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('51', '删除角色', '62', '', 'Group', 'del', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('53', '查看管理员', '1', '', 'Admin', 'index', '', '', '', '777', '1', '1500519874');
INSERT INTO `na_menu` VALUES ('55', '查看权限', '48', '', 'Group', 'rule', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('56', '查看菜单', '42', '', 'Menu', 'index', '', '', '', '888', '1', '1500519877');
INSERT INTO `na_menu` VALUES ('58', '修改菜单', '64', '', 'Menu', 'edit', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('59', '删除菜单', '64', '', 'Menu', 'del', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('60', '日志管理', '0', ' fa-list-ul', 'Log', 'index', '', '', '', '12', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('62', '角色操作', '47', '', 'Group', 'info', '', '', '', '888', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('63', '修改权限', '48', '', 'Group', 'editRule', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('64', '菜单操作', '42', '', 'Menu', 'info', '', '', '', '888', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('65', '添加菜单', '64', '', 'Menu', 'add', '', '', '', '888', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('66', '站内信', '0', ' fa-bullhorn', 'System', 'index', '', '', '', '3', '2', '1506420330');
INSERT INTO `na_menu` VALUES ('67', '发布公告', '71', '', 'System', 'announce', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('68', '发布邮件', '75', '', 'System', 'sendmail', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('69', '玩家反馈', '66', '', 'System', 'propose', '', '', '', '999', '1', '1500519875');
INSERT INTO `na_menu` VALUES ('70', '所有玩家', '32', '', 'User', 'index', '', '', '', '999', '1', '1500519874');
INSERT INTO `na_menu` VALUES ('71', '查看公告', '66', '', 'System', 'index', '', '', '', '888', '2', '1506420235');
INSERT INTO `na_menu` VALUES ('72', '管理员操作', '1', '', 'Admin', 'info', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('74', '删除公告', '71', '', 'System', 'del', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('75', '查看邮件', '66', '', 'System', 'showmail', '', '', '', '888', '2', '1506420260');
INSERT INTO `na_menu` VALUES ('77', '添加帮助手册', '76', '', 'System', 'addhelp', '', '', '', '999', '2', '1482805694');
INSERT INTO `na_menu` VALUES ('78', '修改帮助手册', '76', '', 'System', 'edithelp', '', '', '', '999', '2', '1482805694');
INSERT INTO `na_menu` VALUES ('79', '公告详情', '71', '', 'System', 'show', '', '', '', '888', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('80', '删除邮件', '75', '', 'System', 'delmail', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('81', '邮件详情', '75', '', 'System', 'showinfo', '', '', '', '888', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('82', '反馈详情', '69', '', 'System', 'showpro', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('83', '删除反馈', '69', '', 'System', 'delpro', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('84', '删除手册', '76', '', 'System', 'del', '', '', '', '999', '2', '1482805694');
INSERT INTO `na_menu` VALUES ('85', '帮助手册详情', '76', '', 'System', 'show', '', '', '', '888', '2', '1482805694');
INSERT INTO `na_menu` VALUES ('86', 'id查询', '70', '', 'User', 'likeid', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('87', '推锅游戏', '0', ' fa-gamepad', 'GameTuiGuo', 'index', '', '', '', '4', '1', '1502245969');
INSERT INTO `na_menu` VALUES ('88', '推锅游戏房间', '87', '', 'GameTuiGuo', 'show', '', '', '', '999', '1', '1500519875');
INSERT INTO `na_menu` VALUES ('90', '修改邮件', '75', '', 'System', 'editmail', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('91', '修改公告', '71', '', 'System', 'editbc', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('92', '推锅游戏系统推荐模板', '87', '', 'System', 'template', '', '', '', '999', '2', '1503657130');
INSERT INTO `na_menu` VALUES ('93', '添加模板', '92', '', 'System', 'addtemplate', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('94', '修改模板', '92', '', 'System', 'edittem', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('95', '删除模板', '92', '', 'System', 'deltem', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('96', '推锅游戏玩家自定义模板', '87', '', 'System', 'gameusertel', '', '', '', '999', '1', '1500519876');
INSERT INTO `na_menu` VALUES ('97', '添加金币和房卡日志', '0', 'fa-shopping-cart ', 'BuyLog', 'index', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('98', '推锅下注搓牌时间', '87', '', 'System', 'timeindex', '', '', '', '999', '2', '1503657155');
INSERT INTO `na_menu` VALUES ('100', '推筒子', '0', ' fa-gamepad', 'GameTuiTong', 'index', '', '', '', '5', '1', '1500519876');
INSERT INTO `na_menu` VALUES ('101', '牌九', '0', ' fa-gamepad', 'GamePaiJiu', 'index', '', '', '', '6', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('102', '系统设置', '0', 'fa-cog ', 'System', 'index', '', '', '', '7', '2', '1502703905');
INSERT INTO `na_menu` VALUES ('103', '房卡商店', '102', '', 'System', 'roomcard', '', '', '', '999', '1', '1500519877');
INSERT INTO `na_menu` VALUES ('104', '推筒子游戏房间', '100', '', 'GameTuiTong', 'show', '', '', '', '999', '1', '1500519876');
INSERT INTO `na_menu` VALUES ('105', '推筒子系统推荐模板', '100', '', 'GameTuiTong', 'template', '', '', '', '999', '2', '1503657170');
INSERT INTO `na_menu` VALUES ('106', '推筒子玩家自定义模板', '100', '', 'GameTuiTong', 'gameusertel', '', '', '', '999', '1', '1500519876');
INSERT INTO `na_menu` VALUES ('107', '推筒子下注搓牌时间', '100', '', 'GameTuiTong', 'timeindex', '', '', '', '999', '2', '1503657192');
INSERT INTO `na_menu` VALUES ('108', '游戏房间', '101', '', 'GamePaiJiu', 'show', '', '', '', '999', '1', '1500519876');
INSERT INTO `na_menu` VALUES ('109', '系统模板', '101', '', 'GamePaiJiu', 'template', '', '', '', '999', '2', '1503657294');
INSERT INTO `na_menu` VALUES ('110', '玩家模板', '101', '', 'GamePaiJiu', 'usertel', '', '', '', '999', '1', '1500519876');
INSERT INTO `na_menu` VALUES ('111', '时间配置', '101', '', 'GamePaiJiu', 'time', '', '', '', '999', '2', '1503657223');
INSERT INTO `na_menu` VALUES ('112', '大厅配置', '0', 'fa-map', 'System', 'gamehall', '', '', '', '999', '2', '1503657311');
INSERT INTO `na_menu` VALUES ('113', '用户名查询玩家', '70', '', 'User', 'likeusername', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('114', '购买金币或房卡', '70', '', 'User', 'addcoins', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('115', '发送邮件', '70', '', 'User', 'mail', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('116', '查看所有游戏', '70', '', 'User', 'details', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('117', '推锅游戏房间', '70', '', 'User', 'roomshow', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('118', '推筒子游戏', '70', '', 'User', 'tuitong', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('119', '牌九游戏', '70', '', 'User', 'paijiu', '', '', '', '999', '2', '1500519874');
INSERT INTO `na_menu` VALUES ('120', '推锅游戏房间房间号查询', '70', '', 'User', 'likepwd', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('121', '查看每回合详情', '70', '', 'User', 'roomdetail', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('122', '房间号查询房间', '88', '', 'GameTuiGuo', 'likeroomid', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('123', '查看结果', '88', '', 'GameTuiGuo', 'details', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('125', '用户名查询', '88', '', 'GameTuiGuo', 'likeuser', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('126', '应用模板', '92', '', 'System', 'activetem', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('127', '解除应用模板', '92', '', 'System', 'disactivetem', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('128', '修改', '103', '', 'System', 'editrc', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('129', '用户名查询', '97', '', 'BuyLog', 'searchname', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('130', '时间查询', '97', '', 'BuyLog', 'liketime', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('131', '子管理员配置', '0', 'fa-cog', 'SonAdmin', 'index', '', '', '', '999', '2', '1501561515');
INSERT INTO `na_menu` VALUES ('132', '所有管理员', '131', '', 'SonAdmin', 'index', '', '', '', '999', '1', '1500519877');
INSERT INTO `na_menu` VALUES ('133', '查看管理员', '132', '', 'SonAdmin', 'info', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('134', '编辑管理员', '132', '', 'SonAdmin', 'edit', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('135', '添加管理员', '132', '', 'SonAdmin', 'add', '', '', '', '999', '2', '1500519878');
INSERT INTO `na_menu` VALUES ('136', '删除管理员', '132', '', 'SonAdmin', 'del', '', '', '', '999', '2', '1500519878');
INSERT INTO `na_menu` VALUES ('137', '房间号查询房间', '104', '', 'GameTuiTong', 'likeroomid', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('138', '用户名查询', '104', '', 'GameTuiTong', 'likeuser', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('139', '详情', '104', '', 'GameTuiTong', 'details', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('140', '局详情', '104', '', 'GameTuiTong', 'juinfo', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('141', '回合详情', '104', '', 'GameTuiTong', 'huiinfo', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('142', '每局详情', '88', '', 'GameTuiGuo', 'juinfo', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('143', '回合详情', '88', '', 'GameTuiGuo', 'huiinfo', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('144', '添加模板', '105', '', 'GameTuiTong', 'addtemplate', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('145', '修改模板', '105', '', 'GameTuiTong', 'edittem', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('146', '删除模板', '105', '', 'GameTuiTong', 'deltem', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('147', '应用模板', '105', '', 'GameTuiTong', 'activetem', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('148', '解除应用模板', '105', '', 'GameTuiTong', 'disactivetem', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('149', '删除玩家模板', '106', '', 'GameTuiTong', 'userdeltem', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('150', '删除玩家模板', '96', '', 'System', 'userdeltem', '', '', '', '999', '2', '1500519876');
INSERT INTO `na_menu` VALUES ('151', '推筒子房间号查询', '70', '', 'User', 'likepwdtong', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('152', '推筒子回合详情', '70', '', 'User', 'roomdetailtong', '', '', '', '999', '2', '1500519875');
INSERT INTO `na_menu` VALUES ('153', '玩家购买房卡日志', '0', 'fa-shopping-cart', 'UserBuyFangKa', 'index', '', '', '', '888', '1', '1500519877');
INSERT INTO `na_menu` VALUES ('154', '玩家ID查询', '153', '', 'UserBuyFangKa', 'searchid', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('155', '玩家用户名查询', '153', '', 'UserBuyFangKa', 'searchname', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('156', '时间查询', '153', '', 'UserBuyFangKa', 'liketime', '', '', '', '999', '2', '1500519877');
INSERT INTO `na_menu` VALUES ('157', '四川麻将', '0', ' fa-gamepad', 'GameMaJiang', 'index', '', '', '', '6', '1', '1501814525');
INSERT INTO `na_menu` VALUES ('160', '测试', '159', '', 'MJ', 'paixing', '', '', '', '999', '1', null);
INSERT INTO `na_menu` VALUES ('161', '游戏测试', '0', 'fa-bug', 'CeShi', 'index', '', '', '', '999', '2', '1506420092');
INSERT INTO `na_menu` VALUES ('162', '修改下注时间', '98', '', 'System', 'edittime', '', '', '', '999', '2', null);
INSERT INTO `na_menu` VALUES ('163', '下注时间修改', '107', '', 'GameTuiTong', 'edittime', '', '', '', '999', '2', null);
INSERT INTO `na_menu` VALUES ('164', '麻将房间', '157', '', 'GameMaJiang', 'index', '', '', '', '999', '1', null);
INSERT INTO `na_menu` VALUES ('165', '房间号或用户名查询', '164', '', 'GameMaJiang', 'search', '', '', '', '999', '2', null);
INSERT INTO `na_menu` VALUES ('166', '房间详情查询', '164', '', 'GameMaJiang', 'details', '', '', '', '999', '2', null);
INSERT INTO `na_menu` VALUES ('167', '玩家角度看麻将房间', '157', '', 'GameMaJiang', 'scmj', '', '', '', '999', '2', '1504161601');
INSERT INTO `na_menu` VALUES ('168', '房间号查询', '167', '', 'GameMaJiang', 'likepwd', '', '', '', '999', '2', null);
INSERT INTO `na_menu` VALUES ('169', '房间详情', '167', '', 'GameMaJiang', 'details2', '', '', '', '999', '2', null);
