/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : na_gameplaza

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2017-09-26 18:13:45
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of na_admingroup
-- ----------------------------
INSERT INTO `na_admingroup` VALUES ('1', '推锅游戏', '可以操作推锅游戏的所有功能', '87,88,122,123,125,142,143,92,96,150,98', '0', '1502354590');
INSERT INTO `na_admingroup` VALUES ('2', '推筒子', '可以操作所有推筒子的权限', '100,104,137,138,139,140,141,105,106,149,107', '0', '1502354573');
INSERT INTO `na_admingroup` VALUES ('3', '牌九', '可以操作所有的牌九的功能', '101,108,109,110,111', '0', '1493090781');
INSERT INTO `na_admingroup` VALUES ('4', '后台公告', '管理公告，邮件，玩家反馈', '66,69,82,83', '0', '1502703978');
INSERT INTO `na_admingroup` VALUES ('5', '玩家管理', '管理玩家功能', '32,70,86,113,114,115,116,117,118,119,120,121,151,152', '0', '1493621113');
INSERT INTO `na_admingroup` VALUES ('6', '系统设置', '房卡商店配置', '102,103,128', '0', '1506420041');
INSERT INTO `na_admingroup` VALUES ('8', '子管理员配置', '添加管理员等功能', '131,132,133,134,135,136', '0', '1493091056');
INSERT INTO `na_admingroup` VALUES ('9', '玩家购买房卡日志', '可以查看玩家购买房卡的记录', '153,154,155,156', '0', '1497858516');
INSERT INTO `na_admingroup` VALUES ('10', '四川麻将', '有关麻将的功能', '157,164,165,166,167,168,169', '0', '1504161640');
