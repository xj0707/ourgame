/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : na_gameplaza

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2017-10-09 16:51:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for na_roomcardconfig
-- ----------------------------
DROP TABLE IF EXISTS `na_roomcardconfig`;
CREATE TABLE `na_roomcardconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roomcard_time` int(11) NOT NULL DEFAULT '0',
  `roomcard_round` int(11) NOT NULL DEFAULT '0',
  `rebate` int(3) NOT NULL DEFAULT '0',
  `eGameKind` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_roomcardconfig
-- ----------------------------
INSERT INTO `na_roomcardconfig` VALUES ('1', '120', '0', '100', '10001');
INSERT INTO `na_roomcardconfig` VALUES ('2', '120', '0', '100', '10002');
INSERT INTO `na_roomcardconfig` VALUES ('3', '0', '3', '100', '20001');
