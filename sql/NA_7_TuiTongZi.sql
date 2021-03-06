/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : na_7_tuitongzi

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-06-22 18:56:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for na_gamebetrecord
-- ----------------------------
DROP TABLE IF EXISTS `na_gamebetrecord`;
CREATE TABLE `na_gamebetrecord` (
  `un32ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `un32GameRoomID` int(11) NOT NULL COMMENT '房间ID',
  `un32GameJuID` int(11) NOT NULL COMMENT '局数',
  `un32GameRoundID` int(11) NOT NULL COMMENT '回合数',
  `eIdentity` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0null,1庄家，2闲家，3旁观',
  `un32PlayerID` int(11) NOT NULL COMMENT '玩家ID',
  `n32TianBetNum` int(11) NOT NULL COMMENT '下注数量',
  `n32TianWinloseNum` int(11) NOT NULL COMMENT '输赢积分',
  `n32DiBetNum` int(11) NOT NULL,
  `n32DiWinloseNum` int(11) NOT NULL,
  `n32RenBetNum` int(11) NOT NULL,
  `n32RenWinloseNum` int(11) NOT NULL,
  `n32UserRemainScore` int(11) NOT NULL COMMENT '剩余积分',
  `un32LogTime` bigint(20) NOT NULL COMMENT '时间',
  `n32GuoDiScore` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`un32ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_gamebetrecord
-- ----------------------------

-- ----------------------------
-- Table structure for na_gameroom
-- ----------------------------
DROP TABLE IF EXISTS `na_gameroom`;
CREATE TABLE `na_gameroom` (
  `un32ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `un32OwnerUserID` int(11) unsigned zerofill NOT NULL,
  `tStartTime` int(11) NOT NULL DEFAULT '0',
  `tCreateTime` int(11) NOT NULL DEFAULT '0',
  `n32GameRoomPwd` int(11) NOT NULL DEFAULT '0',
  `bIfOver` tinyint(1) NOT NULL DEFAULT '0',
  `bIfTax` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否抽水',
  `fWinTaxRate` int(2) NOT NULL DEFAULT '0' COMMENT '抽水比率（赢）',
  `fLoseTaxRate` int(2) NOT NULL DEFAULT '0' COMMENT '抽水比率（输）',
  `un32TotalAnte` int(11) NOT NULL COMMENT '锅底大小',
  `un32RoomLiveSecond` int(11) NOT NULL DEFAULT '0' COMMENT '房间存活时间',
  `bIfLookOn` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否允许旁观',
  `un32OnLookerNum` int(11) NOT NULL DEFAULT '0' COMMENT '最大旁观者数量',
  `un32InitScore` int(11) NOT NULL DEFAULT '0' COMMENT '初始积分',
  `eForbidChat` int(1) NOT NULL DEFAULT '0' COMMENT '禁止聊天0：不禁止1：仅旁观者禁止2：全禁止',
  `un32SingleScore` int(11) NOT NULL DEFAULT '0' COMMENT '单注积分',
  `un32ConsumeCardNum` int(11) NOT NULL DEFAULT '0' COMMENT '消耗房卡数量',
  `un32JoinUserNum` int(11) NOT NULL DEFAULT '0' COMMENT '参与玩家数量',
  `un32OrderID` int(11) NOT NULL DEFAULT '0',
  `tPauseTime` int(11) NOT NULL DEFAULT '0' COMMENT '房间暂停时间',
  `un32PumpWater` int(11) NOT NULL DEFAULT '0' COMMENT '房间总抽水',
  PRIMARY KEY (`un32ID`),
  KEY `OwnerUserID` (`un32OwnerUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of na_gameroom
-- ----------------------------

-- ----------------------------
-- Table structure for na_gameroomrecord
-- ----------------------------
DROP TABLE IF EXISTS `na_gameroomrecord`;
CREATE TABLE `na_gameroomrecord` (
  `un32ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `un32GameRoomID` int(11) NOT NULL DEFAULT '0' COMMENT '房间ID',
  `un32GameUserID` int(11) NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `n32AppendedScore` int(11) NOT NULL DEFAULT '0',
  `n32GotScore` int(11) NOT NULL DEFAULT '0' COMMENT '输赢积分',
  `n32PumpWater` int(11) NOT NULL DEFAULT '0' COMMENT '抽水金额',
  `un32LogTime` bigint(20) NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`un32ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_gameroomrecord
-- ----------------------------

-- ----------------------------
-- Table structure for na_gameroundrecord
-- ----------------------------
DROP TABLE IF EXISTS `na_gameroundrecord`;
CREATE TABLE `na_gameroundrecord` (
  `un32ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `un32GameRoomID` int(11) NOT NULL COMMENT '房间ID',
  `un32GameJuID` int(11) NOT NULL COMMENT '局数',
  `un32GameRoundID` int(11) NOT NULL COMMENT '回合数',
  `un32LogTime` bigint(20) NOT NULL COMMENT '时间',
  `un32BankerPlayerID` int(11) NOT NULL COMMENT '座位1玩家ID',
  `n8BankerSeatID` tinyint(1) NOT NULL,
  `un8BankerCardID1` tinyint(2) NOT NULL COMMENT '座位1玩家第一张牌',
  `un8BankerCardID2` tinyint(2) NOT NULL COMMENT '座位1玩家第二张牌',
  `n32GuoDiScore` int(11) NOT NULL COMMENT '座位1总注数(如果为庄家就是锅底)',
  `n32BankerWinLoseNum` int(11) NOT NULL COMMENT '座位1总输赢',
  `un32ShunPlayerID` int(11) NOT NULL,
  `un8ShunCardID1` tinyint(2) NOT NULL,
  `un8ShunCardID2` tinyint(2) NOT NULL,
  `n32ShunTotalBetNum` int(11) NOT NULL,
  `n32ShunWinLoseNum` int(11) NOT NULL,
  `un32TianPlayerID` int(11) NOT NULL,
  `un8TianCardID1` tinyint(2) NOT NULL,
  `un8TianCardID2` tinyint(2) NOT NULL,
  `n32TianTotalBetNum` int(11) NOT NULL,
  `n32TianWinLoseNum` int(11) NOT NULL,
  `un32DiPlayerID` int(11) NOT NULL,
  `un8DiCardID1` tinyint(2) NOT NULL,
  `un8DiCardID2` tinyint(2) NOT NULL,
  `n32DiTotalBetNum` int(11) NOT NULL,
  `n32DiWinLoseNum` int(11) NOT NULL,
  PRIMARY KEY (`un32ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_gameroundrecord
-- ----------------------------

-- ----------------------------
-- Table structure for na_pumpwaterrecord
-- ----------------------------
DROP TABLE IF EXISTS `na_pumpwaterrecord`;
CREATE TABLE `na_pumpwaterrecord` (
  `un32ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `un32GameRoomID` int(11) NOT NULL COMMENT '房间ID',
  `un32GameJuID` int(11) NOT NULL COMMENT '局数',
  `ePlayWay` int(1) NOT NULL DEFAULT '0' COMMENT '1喝水2不喝水',
  `un32GameBankerID` int(11) NOT NULL,
  `n32BottonOfPotNum` int(11) NOT NULL COMMENT '锅底',
  `n32PumpWaterNum` int(11) NOT NULL COMMENT '抽水数量',
  `fPumpWaterPercent` int(5) NOT NULL COMMENT '抽水比率',
  `bIfWin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0输1赢',
  `un32LogTime` bigint(20) NOT NULL,
  PRIMARY KEY (`un32ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of na_pumpwaterrecord
-- ----------------------------
