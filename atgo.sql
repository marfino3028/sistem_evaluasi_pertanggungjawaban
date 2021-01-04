/*
 Navicat Premium Data Transfer

 Source Server         : atgo
 Source Server Type    : MySQL
 Source Server Version : 100141
 Source Host           : enforcer.atsoft.co.id:42806
 Source Schema         : atgo

 Target Server Type    : MySQL
 Target Server Version : 100141
 File Encoding         : 65001

 Date: 02/08/2020 15:21:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cr_app
-- ----------------------------
DROP TABLE IF EXISTS `cr_app`;
CREATE TABLE `cr_app`  (
  `app_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `app` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`app_id`) USING BTREE,
  UNIQUE INDEX `app`(`app`) USING BTREE
) ENGINE = InnoDB AVG_ROW_LENGTH = 16384 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cr_app
-- ----------------------------
INSERT INTO `cr_app` VALUES ('atgo-api', 'Main API');

-- ----------------------------
-- Table structure for cr_bulan
-- ----------------------------
DROP TABLE IF EXISTS `cr_bulan`;
CREATE TABLE `cr_bulan`  (
  `bulan_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bulan_no` int(11) NOT NULL,
  `bulan` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`bulan_id`) USING BTREE,
  UNIQUE INDEX `bulan_no`(`bulan_no`) USING BTREE
) ENGINE = InnoDB AVG_ROW_LENGTH = 1365 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cr_bulan
-- ----------------------------
INSERT INTO `cr_bulan` VALUES ('01', 1, 'Januari');
INSERT INTO `cr_bulan` VALUES ('02', 2, 'Februari');
INSERT INTO `cr_bulan` VALUES ('03', 3, 'Maret');
INSERT INTO `cr_bulan` VALUES ('04', 4, 'April');
INSERT INTO `cr_bulan` VALUES ('05', 5, 'Mei');
INSERT INTO `cr_bulan` VALUES ('06', 6, 'Juni');
INSERT INTO `cr_bulan` VALUES ('07', 7, 'Juli');
INSERT INTO `cr_bulan` VALUES ('08', 8, 'Agustus');
INSERT INTO `cr_bulan` VALUES ('09', 9, 'September');
INSERT INTO `cr_bulan` VALUES ('10', 10, 'Oktober');
INSERT INTO `cr_bulan` VALUES ('11', 11, 'November');
INSERT INTO `cr_bulan` VALUES ('12', 12, 'Desember');

-- ----------------------------
-- Table structure for cr_grup_menu
-- ----------------------------
DROP TABLE IF EXISTS `cr_grup_menu`;
CREATE TABLE `cr_grup_menu`  (
  `grup_menu_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `app_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `grup_menu` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `urutan` int(11) NOT NULL,
  PRIMARY KEY (`grup_menu_id`) USING BTREE,
  INDEX `cr_grup_menu_fk1`(`app_id`) USING BTREE,
  CONSTRAINT `cr_grup_menu_fk1` FOREIGN KEY (`app_id`) REFERENCES `cr_app` (`app_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cr_grup_menu
-- ----------------------------
INSERT INTO `cr_grup_menu` VALUES ('admin', 'atgo-api', 'ADMINISTRATOR', 99);
INSERT INTO `cr_grup_menu` VALUES ('dpa', 'atgo-api', 'DPA', 1);
INSERT INTO `cr_grup_menu` VALUES ('esakip', 'atgo-api', 'ESAKIP', 2);
INSERT INTO `cr_grup_menu` VALUES ('lf', 'atgo-api', 'LOGFRAME', 3);
INSERT INTO `cr_grup_menu` VALUES ('ropk', 'atgo-api', 'ROPK', 4);

-- ----------------------------
-- Table structure for cr_hak
-- ----------------------------
DROP TABLE IF EXISTS `cr_hak`;
CREATE TABLE `cr_hak`  (
  `hak_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `app_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `peran_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resource_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hak_aktif` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`hak_id`) USING BTREE,
  INDEX `cr_hak_fk2`(`peran_id`) USING BTREE,
  INDEX `cr_hak_fk1`(`app_id`) USING BTREE,
  INDEX `resource_id`(`resource_id`) USING BTREE,
  CONSTRAINT `cr_hak_fk1` FOREIGN KEY (`app_id`) REFERENCES `cr_app` (`app_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `cr_hak_fk2` FOREIGN KEY (`peran_id`) REFERENCES `cr_peran` (`peran_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `cr_hak_fk3` FOREIGN KEY (`resource_id`) REFERENCES `cr_resource` (`resource_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AVG_ROW_LENGTH = 8192 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cr_hak
-- ----------------------------
INSERT INTO `cr_hak` VALUES ('asg3n', 'atgo-api', 'admin', 'allxsadasd', 1);
INSERT INTO `cr_hak` VALUES ('asgsag', 'atgo-api', 'publik', 'index57fhfh', 1);

-- ----------------------------
-- Table structure for cr_log_akses
-- ----------------------------
DROP TABLE IF EXISTS `cr_log_akses`;
CREATE TABLE `cr_log_akses`  (
  `log_akses_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `app_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `aktivitas` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `kat` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_datetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`log_akses_id`) USING BTREE
) ENGINE = MyISAM AVG_ROW_LENGTH = 103 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cr_log_akses
-- ----------------------------
INSERT INTO `cr_log_akses` VALUES ('e34fa031-cf8f-4b77-a0d3-f262834cbfdf', 'atgo-api', 'LOGIN GAGAL', 'TOLAK', '198506252010011012', '172.20.0.1', '2020-08-02 15:06:10');
INSERT INTO `cr_log_akses` VALUES ('73b614ff-6e4e-49d0-a17a-6daacead5922', 'atgo-api', 'username dan password salah', 'ERROR', 'publik', '172.20.0.1', '2020-08-02 15:06:10');
INSERT INTO `cr_log_akses` VALUES ('8d61b996-a4d1-4355-8e11-df25690d52d5', 'atgo-api', 'Mohon maaf telah terjadi kesalahan', 'ERROR', 'publik', '172.20.0.1', '2020-08-02 15:06:30');
INSERT INTO `cr_log_akses` VALUES ('20026d16-6642-47af-8651-7b14d58e3d92', 'atgo-api', 'LOGIN GAGAL', 'TOLAK', '198506252010011012', '172.20.0.1', '2020-08-02 15:07:15');
INSERT INTO `cr_log_akses` VALUES ('e9bed4ad-f24e-41cf-b919-9cd61acceb62', 'atgo-api', 'username dan password salah', 'ERROR', 'publik', '172.20.0.1', '2020-08-02 15:07:15');
INSERT INTO `cr_log_akses` VALUES ('984f54b8-d464-459f-8bfc-391db903eb6f', 'atgo-api', 'LOGIN GAGAL', 'TOLAK', 'atsoftdev', '172.20.0.1', '2020-08-02 15:08:11');
INSERT INTO `cr_log_akses` VALUES ('0da41c96-fb3e-4213-9a20-5d30071316ee', 'atgo-api', 'username dan password salah', 'ERROR', 'publik', '172.20.0.1', '2020-08-02 15:08:11');
INSERT INTO `cr_log_akses` VALUES ('9d17bc47-5756-4f14-9933-28d3c610aee5', 'atgo-api', 'LOGIN BERHASIL', 'TERIMA', 'atsoftdev', '172.20.0.1', '2020-08-02 15:09:04');
INSERT INTO `cr_log_akses` VALUES ('252de334-43ce-499d-9431-b49e99d7bfc2', 'atgo-api', 'Mohon maaf telah terjadi kesalahan', 'ERROR', 'publik', '172.20.0.1', '2020-08-02 15:09:04');
INSERT INTO `cr_log_akses` VALUES ('7d074927-5a6c-4e4b-9e56-d26e4704d2b8', 'atgo-api', 'LOGIN BERHASIL', 'TERIMA', 'atsoftdev', '172.20.0.1', '2020-08-02 15:10:44');
INSERT INTO `cr_log_akses` VALUES ('9cfef913-7be1-42a6-ac1a-08c75a35a3da', 'atgo-api', 'LOGIN BERHASIL', 'TERIMA', 'atsoftdev', '172.20.0.1', '2020-08-02 15:11:19');
INSERT INTO `cr_log_akses` VALUES ('c982f302-b4e7-4f6e-a7f4-869c64c23a21', 'atgo-api', 'token tidak dikirim', 'ERROR', 'publik', '172.20.0.1', '2020-08-02 15:12:13');
INSERT INTO `cr_log_akses` VALUES ('aa400993-81c0-487c-95b1-703b6f8721d0', 'atgo-api', 'token tidak dikirim', 'ERROR', 'publik', '172.20.0.1', '2020-08-02 15:12:22');
INSERT INTO `cr_log_akses` VALUES ('8c49b32d-8573-445e-9bfb-852595a76628', 'atgo-api', 'token invalid', 'ERROR', NULL, '172.20.0.1', '2020-08-02 15:12:24');
INSERT INTO `cr_log_akses` VALUES ('e84c6965-8c70-4939-b8de-2d893545ee0d', 'atgo-api', 'Mohon maaf telah terjadi kesalahan', 'ERROR', 'atsoftdev', '172.20.0.1', '2020-08-02 15:12:42');
INSERT INTO `cr_log_akses` VALUES ('b9480173-6ba8-4709-b59f-1e196fbcb251', 'atgo-api', 'Mohon maaf telah terjadi kesalahan', 'ERROR', 'atsoftdev', '172.20.0.1', '2020-08-02 15:13:39');
INSERT INTO `cr_log_akses` VALUES ('b5e45042-ab4a-402b-9f42-d5033a137ddc', 'atgo-api', 'Mohon maaf telah terjadi kesalahan', 'ERROR', 'atsoftdev', '172.20.0.1', '2020-08-02 15:14:12');
INSERT INTO `cr_log_akses` VALUES ('ca3ca348-4e18-49f7-abc3-ea0583f6ccb9', 'atgo-api', 'username atsoftdev token  group admin akses ke auth - cek', 'TERIMA', 'atsoftdev', '172.20.0.1', '2020-08-02 15:14:37');
INSERT INTO `cr_log_akses` VALUES ('d8dfad02-472f-4776-8b39-732390faaa57', 'atgo-api', 'akses ke resource ini ditolak', 'TOLAK', 'atsoftdev', '172.20.0.1', '2020-08-02 15:15:46');
INSERT INTO `cr_log_akses` VALUES ('e9b6e291-958d-48a1-a14a-c3bfdf1c9f7c', 'atgo-api', 'akses ke resource ini ditolak', 'ERROR', 'atsoftdev', '172.20.0.1', '2020-08-02 15:15:47');
INSERT INTO `cr_log_akses` VALUES ('da501f15-9b9d-496c-b789-49f0b4e6feea', 'atgo-api', 'akses ke resource ini ditolak', 'TOLAK', 'atsoftdev', '172.20.0.1', '2020-08-02 15:16:07');
INSERT INTO `cr_log_akses` VALUES ('966536f0-70b9-4ed8-a7f1-19cec37248eb', 'atgo-api', 'akses ke resource ini ditolak', 'ERROR', 'atsoftdev', '172.20.0.1', '2020-08-02 15:16:07');
INSERT INTO `cr_log_akses` VALUES ('951386de-c70c-4faa-b7d1-f93482c8f7b6', 'atgo-api', 'username atsoftdev token  group admin akses ke auth - cek', 'TERIMA', 'atsoftdev', '172.20.0.1', '2020-08-02 15:16:13');
INSERT INTO `cr_log_akses` VALUES ('6b2fb049-3571-4496-88fd-b214d28a8872', 'atgo-api', 'LOGIN BERHASIL', 'TERIMA', 'bkdx', '172.20.0.1', '2020-08-02 15:17:59');
INSERT INTO `cr_log_akses` VALUES ('99d217e4-61a1-4c57-a1f1-b961b964c817', 'atgo-api', 'username atsoftdev token  group admin akses ke auth - logout', 'TERIMA', 'atsoftdev', '172.20.0.1', '2020-08-02 15:19:25');
INSERT INTO `cr_log_akses` VALUES ('79511873-7d30-4c12-b526-fd78eb90f16f', 'atgo-api', 'LOGOUT BERHASIL', 'TERIMA', 'atsoftdev', '172.20.0.1', '2020-08-02 15:19:25');
INSERT INTO `cr_log_akses` VALUES ('667c1c81-b76f-4fcc-a37b-4f96ed487f9c', 'atgo-api', 'akses ke resource ini ditolak', 'TOLAK', 'publik', '172.20.0.1', '2020-08-02 15:20:52');
INSERT INTO `cr_log_akses` VALUES ('9516cc82-fd8f-4bb3-9e88-04ac58675e04', 'atgo-api', 'akses ke resource ini ditolak', 'ERROR', 'publik', '172.20.0.1', '2020-08-02 15:20:53');

-- ----------------------------
-- Table structure for cr_log_error
-- ----------------------------
DROP TABLE IF EXISTS `cr_log_error`;
CREATE TABLE `cr_log_error`  (
  `log_error_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `app_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pesan` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `trace` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `query` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_agent` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_datetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`log_error_id`) USING BTREE
) ENGINE = MyISAM AVG_ROW_LENGTH = 642 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cr_log_error
-- ----------------------------
INSERT INTO `cr_log_error` VALUES ('c9d6b63c-f2e7-413d-aee4-e411b0dc05f1', 'atgo-api', 'Column \'kuncix\' doesn\'t belong to any of the selected models (1), when preparing: SELECT user_id, username, peran_id FROM [CrUser] WHERE (username=:a:) AND (kuncix=md5(:y:))', '#0 [internal function]: Phalcon\\Mvc\\Model\\Query->_getQualified(Array)\n#1 [internal function]: Phalcon\\Mvc\\Model\\Query->_getExpression(Array, true)\n#2 [internal function]: Phalcon\\Mvc\\Model\\Query->_getExpression(Array, true)\n#3 [internal function]: Phalcon\\Mvc\\Model\\Query->_getExpression(Array, true)\n#4 [internal function]: Phalcon\\Mvc\\Model\\Query->_getExpression(Array)\n#5 [internal function]: Phalcon\\Mvc\\Model\\Query->_prepareSelect()\n#6 [internal function]: Phalcon\\Mvc\\Model\\Query->parse()\n#7 [internal function]: Phalcon\\Mvc\\Model\\Query->execute(Array, Array)\n#8 /var/www/html/web/controller/AuthController.php(98): Phalcon\\Mvc\\Model\\Query->getSingleResult()\n#9 [internal function]: AuthController->indexAction()\n#10 [internal function]: Phalcon\\Dispatcher\\AbstractDispatcher->callActionMethod(Object(AuthController), \'indexAction\', Array)\n#11 [internal function]: Phalcon\\Dispatcher\\AbstractDispatcher->dispatch()\n#12 /var/www/html/web/boot.php(90): Phalcon\\Mvc\\Application->handle(\'/auth\')\n#13 /var/www/html/web-root/index.php(2): include(\'/var/www/html/w...\')\n#14 {main}', '/auth', 'PostmanRuntime/7.26.2', 'publik', '172.20.0.1', '2020-08-02 15:06:30');
INSERT INTO `cr_log_error` VALUES ('a11387e3-8026-41a0-9516-3297370473e3', 'atgo-api', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'cr_token.username\' in \'field list\'', '#0 [internal function]: PDOStatement->execute()\n#1 [internal function]: Phalcon\\Db\\Adapter\\Pdo\\AbstractPdo->executePrepared(Object(PDOStatement), Array, Array)\n#2 [internal function]: Phalcon\\Db\\Adapter\\Pdo\\AbstractPdo->query(\'SELECT `cr_toke...\', Array, Array)\n#3 [internal function]: Phalcon\\Mvc\\Model\\Query->_executeSelect(Array, Array, Array)\n#4 [internal function]: Phalcon\\Mvc\\Model\\Query->execute(Array, Array)\n#5 /var/www/html/lib/At.php(22): Phalcon\\Mvc\\Model\\Query->getSingleResult()\n#6 /var/www/html/web/controller/AuthController.php(130): At::tokenGetInfo(\'66a17ebd-5102-4...\')\n#7 [internal function]: AuthController->indexAction()\n#8 [internal function]: Phalcon\\Dispatcher\\AbstractDispatcher->callActionMethod(Object(AuthController), \'indexAction\', Array)\n#9 [internal function]: Phalcon\\Dispatcher\\AbstractDispatcher->dispatch()\n#10 /var/www/html/web/boot.php(90): Phalcon\\Mvc\\Application->handle(\'/auth\')\n#11 /var/www/html/web-root/index.php(2): include(\'/var/www/html/w...\')\n#12 {main}', '/auth', 'PostmanRuntime/7.26.2', 'publik', '172.20.0.1', '2020-08-02 15:09:04');
INSERT INTO `cr_log_error` VALUES ('54d205e3-387c-4acf-afc1-d31fee2b82c1', 'atgo-api', 'Unknown model or alias \'CrToken\' (11), when preparing: SELECT CrToken.username FROM [CrHak] JOIN [CrResource] ON CrResource.resource_id=CrHak.resource_id WHERE ((((((CrHak.app_id=:a:) AND (CrHak.peran_id=:b:)) AND (CrHak.hak_aktif=1)) AND (CrResource.app_id=CrHak.app_id)) AND (CrResource.resource_aktif=1)) AND ((CrResource.kontroler=\'all\' or CrResource.kontroler=:c:))) AND ((CrResource.aksi=\'all\' or CrResource.aksi=:d:))', '#0 [internal function]: Phalcon\\Mvc\\Model\\Query->_getQualified(Array)\n#1 [internal function]: Phalcon\\Mvc\\Model\\Query->_getExpression(Array)\n#2 [internal function]: Phalcon\\Mvc\\Model\\Query->_getSelectColumn(Array)\n#3 [internal function]: Phalcon\\Mvc\\Model\\Query->_prepareSelect()\n#4 [internal function]: Phalcon\\Mvc\\Model\\Query->parse()\n#5 [internal function]: Phalcon\\Mvc\\Model\\Query->execute(Array, Array)\n#6 /var/www/html/lib/At.php(65): Phalcon\\Mvc\\Model\\Query->getSingleResult()\n#7 /var/www/html/web/listener/ListenerKeamanan.php(50): At::hakIsAllowed(\'admin\', \'auth\', \'cek\')\n#8 [internal function]: ListenerKeamanan->beforeExecuteRoute(Object(Phalcon\\Events\\Event), Object(Phalcon\\Mvc\\Dispatcher), NULL)\n#9 [internal function]: Phalcon\\Events\\Manager->fireQueue(Object(SplPriorityQueue), Object(Phalcon\\Events\\Event))\n#10 [internal function]: Phalcon\\Events\\Manager->fire(\'dispatch:before...\', Object(Phalcon\\Mvc\\Dispatcher))\n#11 [internal function]: Phalcon\\Dispatcher\\AbstractDispatcher->dispatch()\n#12 /var/www/html/web/boot.php(90): Phalcon\\Mvc\\Application->handle(\'/auth/cek\')\n#13 /var/www/html/web-root/index.php(2): include(\'/var/www/html/w...\')\n#14 {main}', '/auth/cek', 'PostmanRuntime/7.26.2', 'atsoftdev', '172.20.0.1', '2020-08-02 15:12:42');
INSERT INTO `cr_log_error` VALUES ('45066f30-ccce-48a3-9c52-e2265acbb2bf', 'atgo-api', 'Unknown model or alias \'CrToken\' (11), when preparing: SELECT CrToken.token FROM [CrHak] JOIN [CrResource] ON CrResource.resource_id=CrHak.resource_id WHERE ((((((CrHak.app_id=:a:) AND (CrHak.peran_id=:b:)) AND (CrHak.hak_aktif=1)) AND (CrResource.app_id=CrHak.app_id)) AND (CrResource.resource_aktif=1)) AND ((CrResource.kontroler=\'all\' or CrResource.kontroler=:c:))) AND ((CrResource.aksi=\'all\' or CrResource.aksi=:d:))', '#0 [internal function]: Phalcon\\Mvc\\Model\\Query->_getQualified(Array)\n#1 [internal function]: Phalcon\\Mvc\\Model\\Query->_getExpression(Array)\n#2 [internal function]: Phalcon\\Mvc\\Model\\Query->_getSelectColumn(Array)\n#3 [internal function]: Phalcon\\Mvc\\Model\\Query->_prepareSelect()\n#4 [internal function]: Phalcon\\Mvc\\Model\\Query->parse()\n#5 [internal function]: Phalcon\\Mvc\\Model\\Query->execute(Array, Array)\n#6 /var/www/html/lib/At.php(65): Phalcon\\Mvc\\Model\\Query->getSingleResult()\n#7 /var/www/html/web/listener/ListenerKeamanan.php(50): At::hakIsAllowed(\'admin\', \'auth\', \'cek\')\n#8 [internal function]: ListenerKeamanan->beforeExecuteRoute(Object(Phalcon\\Events\\Event), Object(Phalcon\\Mvc\\Dispatcher), NULL)\n#9 [internal function]: Phalcon\\Events\\Manager->fireQueue(Object(SplPriorityQueue), Object(Phalcon\\Events\\Event))\n#10 [internal function]: Phalcon\\Events\\Manager->fire(\'dispatch:before...\', Object(Phalcon\\Mvc\\Dispatcher))\n#11 [internal function]: Phalcon\\Dispatcher\\AbstractDispatcher->dispatch()\n#12 /var/www/html/web/boot.php(90): Phalcon\\Mvc\\Application->handle(\'/auth/cek\')\n#13 /var/www/html/web-root/index.php(2): include(\'/var/www/html/w...\')\n#14 {main}', '/auth/cek', 'PostmanRuntime/7.26.2', 'atsoftdev', '172.20.0.1', '2020-08-02 15:13:39');
INSERT INTO `cr_log_error` VALUES ('615e5939-0764-4524-b6cb-07ffe2ac2938', 'atgo-api', 'SQLSTATE[HY093]: Invalid parameter number: number of bound variables does not match number of tokens', '#0 [internal function]: PDOStatement->execute()\n#1 [internal function]: Phalcon\\Db\\Adapter\\Pdo\\AbstractPdo->executePrepared(Object(PDOStatement), Array, Array)\n#2 [internal function]: Phalcon\\Db\\Adapter\\Pdo\\AbstractPdo->query(\'SELECT `cr_hak`...\', Array, Array)\n#3 [internal function]: Phalcon\\Mvc\\Model\\Query->_executeSelect(Array, Array, Array)\n#4 [internal function]: Phalcon\\Mvc\\Model\\Query->execute(Array, Array)\n#5 /var/www/html/lib/At.php(65): Phalcon\\Mvc\\Model\\Query->getSingleResult()\n#6 /var/www/html/web/listener/ListenerKeamanan.php(50): At::hakIsAllowed(\'admin\', \'auth\', \'cek\')\n#7 [internal function]: ListenerKeamanan->beforeExecuteRoute(Object(Phalcon\\Events\\Event), Object(Phalcon\\Mvc\\Dispatcher), NULL)\n#8 [internal function]: Phalcon\\Events\\Manager->fireQueue(Object(SplPriorityQueue), Object(Phalcon\\Events\\Event))\n#9 [internal function]: Phalcon\\Events\\Manager->fire(\'dispatch:before...\', Object(Phalcon\\Mvc\\Dispatcher))\n#10 [internal function]: Phalcon\\Dispatcher\\AbstractDispatcher->dispatch()\n#11 /var/www/html/web/boot.php(90): Phalcon\\Mvc\\Application->handle(\'/auth/cek\')\n#12 /var/www/html/web-root/index.php(2): include(\'/var/www/html/w...\')\n#13 {main}', '/auth/cek', 'PostmanRuntime/7.26.2', 'atsoftdev', '172.20.0.1', '2020-08-02 15:14:12');

-- ----------------------------
-- Table structure for cr_menu
-- ----------------------------
DROP TABLE IF EXISTS `cr_menu`;
CREATE TABLE `cr_menu`  (
  `menu_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `app_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `grup_menu_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hirarki` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `menu` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `kontroler` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `aksi` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `param` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_aktif` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`menu_id`) USING BTREE,
  INDEX `cr_menu_fk1`(`app_id`) USING BTREE,
  INDEX `cr_menu_fk2`(`grup_menu_id`) USING BTREE,
  CONSTRAINT `cr_menu_fk1` FOREIGN KEY (`app_id`) REFERENCES `cr_app` (`app_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `cr_menu_fk2` FOREIGN KEY (`grup_menu_id`) REFERENCES `cr_grup_menu` (`grup_menu_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AVG_ROW_LENGTH = 1024 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cr_menu
-- ----------------------------
INSERT INTO `cr_menu` VALUES ('asdsd', 'atgo-api', 'dpa', '0501', 'Mahasiswa', 'adm-mhs', 'index', NULL, 'icon-reading', 1);
INSERT INTO `cr_menu` VALUES ('asfassag', 'atgo-api', 'dpa', '03', 'Cek Registrasi', 'front-reg', 'cek', NULL, 'icon-file-check2', 1);
INSERT INTO `cr_menu` VALUES ('ddsgbh', 'atgo-api', 'dpa', '04', 'Unduh e-Certificate', 'front-cert', 'index', NULL, 'icon-download', 1);
INSERT INTO `cr_menu` VALUES ('dsgddf', 'atgo-api', 'dpa', '0502', 'Mata Kuliah', 'adm-matkul', 'index', NULL, 'icon-books', 1);
INSERT INTO `cr_menu` VALUES ('dsgtdfdf', 'atgo-api', 'dpa', '0500', 'Registrasi', 'adm-reg', 'index', NULL, 'icon-magazine', 1);
INSERT INTO `cr_menu` VALUES ('dssdf', 'atgo-api', 'dpa', '05', 'Manajemen', 'adm-home', 'index', NULL, 'icon-cogs', 1);
INSERT INTO `cr_menu` VALUES ('fasfsaf', 'atgo-api', 'dpa', '02', 'Registrasi', 'front-reg', 'index', NULL, 'icon-pen-plus', 1);
INSERT INTO `cr_menu` VALUES ('gdsgdsg', 'atgo-api', 'dpa', '0504', 'Dosen', 'adm-dosen', 'index', NULL, 'icon-brain', 1);
INSERT INTO `cr_menu` VALUES ('home', 'atgo-api', 'dpa', '01', 'Home', 'front-home', 'index', NULL, 'icon-home', 1);
INSERT INTO `cr_menu` VALUES ('sfsagsag', 'atgo-api', 'dpa', '0505', 'Kelas', 'adm-kelas', 'index', NULL, 'icon-book', 1);
INSERT INTO `cr_menu` VALUES ('xcgddg', 'atgo-api', 'dpa', '0503', 'Semester', 'adm-semester', 'index', NULL, 'icon-grid', 1);

-- ----------------------------
-- Table structure for cr_peran
-- ----------------------------
DROP TABLE IF EXISTS `cr_peran`;
CREATE TABLE `cr_peran`  (
  `peran_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `peran` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`peran_id`) USING BTREE,
  UNIQUE INDEX `peran`(`peran`) USING BTREE
) ENGINE = InnoDB AVG_ROW_LENGTH = 8192 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cr_peran
-- ----------------------------
INSERT INTO `cr_peran` VALUES ('admin', 'Administrator');
INSERT INTO `cr_peran` VALUES ('operator', 'Operator OPD');
INSERT INTO `cr_peran` VALUES ('publik', 'Publik');

-- ----------------------------
-- Table structure for cr_resource
-- ----------------------------
DROP TABLE IF EXISTS `cr_resource`;
CREATE TABLE `cr_resource`  (
  `resource_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `app_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resource` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `kontroler` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `aksi` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resource_aktif` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`resource_id`) USING BTREE,
  UNIQUE INDEX `cr_resource_idx1`(`kontroler`, `aksi`, `app_id`) USING BTREE,
  INDEX `app_id`(`app_id`) USING BTREE,
  CONSTRAINT `cr_resource_fk1` FOREIGN KEY (`app_id`) REFERENCES `cr_app` (`app_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cr_resource
-- ----------------------------
INSERT INTO `cr_resource` VALUES ('all-allxsadasd', 'atgo-api', 'all resource', 'all', 'all', 1);
INSERT INTO `cr_resource` VALUES ('auth-cekk3f8h', 'atgo-api', 'cek login', 'auth', 'cek', 1);
INSERT INTO `cr_resource` VALUES ('index57fhfh', 'atgo-api', 'resource index', 'index', 'all', 1);

-- ----------------------------
-- Table structure for cr_token
-- ----------------------------
DROP TABLE IF EXISTS `cr_token`;
CREATE TABLE `cr_token`  (
  `token_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `app_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token_aktif` tinyint(1) NOT NULL DEFAULT 0,
  `i_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_up` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_datetime` datetime(0) NULL DEFAULT NULL,
  `u_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_datetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`token_id`) USING BTREE,
  UNIQUE INDEX `token`(`token`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `app_id`(`app_id`) USING BTREE,
  CONSTRAINT `cr_token_fk1` FOREIGN KEY (`user_id`) REFERENCES `cr_user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `cr_token_fk2` FOREIGN KEY (`app_id`) REFERENCES `cr_app` (`app_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cr_token
-- ----------------------------
INSERT INTO `cr_token` VALUES ('177ea5e7-7cbf-4fe0-ad69-c1f33b3c8531', 'ccdb0117-2da3-47d1-a7db-61a676f6c036', 'atgo-api', 'bkdxsky73f', 1, 'publik', NULL, '2020-08-02 15:17:58', 'publik', '172.20.0.1', '2020-08-02 15:17:58');
INSERT INTO `cr_token` VALUES ('2e045cb1-3e8c-4459-a3ee-4a2a9a09f229', '9b3a592f-c821-47d5-9dc6-0e0d681cdec8', 'atgo-api', 'atsoftdevxs6tygh', 0, 'publik', NULL, '2020-08-02 15:11:19', 'publik', '172.20.0.1', '2020-08-02 15:11:19');
INSERT INTO `cr_token` VALUES ('3etd6gf', 'publik', 'atgo-api', 'publikxsjnatf6yg', 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `cr_token` VALUES ('906d039a-0f24-47a4-a9ae-15a25e6f31a4', '9753723b-4bcf-47d0-ad48-42bec572cc27', 'atgo-api', 'atsoftdevxs6tygh', 0, 'publik', NULL, '2020-08-02 15:10:44', 'publik', '172.20.0.1', '2020-08-02 15:10:44');
INSERT INTO `cr_token` VALUES ('eae90e1b-055c-4b7c-ab30-0ee06d8e9458', '66a17ebd-5102-447c-aa10-e130b159c3a3', 'atgo-api', 'atsoftdevxs6tygh', 0, 'publik', NULL, '2020-08-02 15:09:03', 'publik', '172.20.0.1', '2020-08-02 15:09:03');

-- ----------------------------
-- Table structure for cr_user
-- ----------------------------
DROP TABLE IF EXISTS `cr_user`;
CREATE TABLE `cr_user`  (
  `user_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `kunci` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_aktif` tinyint(1) NOT NULL DEFAULT 0,
  `peran_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `i_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_datetime` datetime(0) NULL DEFAULT NULL,
  `u_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_datetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `user_kode`(`username`) USING BTREE,
  INDEX `cr_user_fk1`(`peran_id`) USING BTREE,
  CONSTRAINT `cr_user_fk1` FOREIGN KEY (`peran_id`) REFERENCES `cr_peran` (`peran_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AVG_ROW_LENGTH = 1638 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cr_user
-- ----------------------------
INSERT INTO `cr_user` VALUES ('atsoftdevxs6tygh', 'atsoftdev', 'Tim Dev', 'd1b00eccacc6ae2339b8bdf2911bdb11', 1, 'admin', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `cr_user` VALUES ('bkdxsky73f', 'bkdx', 'Contoh User BKD', 'ad9a7e8cd21922fb70466186cbe60da9', 0, 'operator', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `cr_user` VALUES ('publikxsjnatf6yg', 'publik', 'Publik User', '0fa68ee5f86c0c345aa1b4aec7a26f39', 1, 'publik', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for go_jabatan
-- ----------------------------
DROP TABLE IF EXISTS `go_jabatan`;
CREATE TABLE `go_jabatan`  (
  `jabatan_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `unor_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `jabatan` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `eselon` int(11) NULL DEFAULT NULL,
  `i_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_up` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_datetime` datetime(0) NULL DEFAULT NULL,
  `u_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_datetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`jabatan_id`) USING BTREE,
  INDEX `unor_id`(`unor_id`) USING BTREE,
  INDEX `jabatan_id`(`jabatan_id`, `unor_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of go_jabatan
-- ----------------------------
INSERT INTO `go_jabatan` VALUES ('asgasgasas', 'wdsyh', 'Kepala Subbidang Sistem Informasi Pegawai', 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_jabatan` VALUES ('sadasfasg', 'asfasf', 'Kepala Badan Kepegawaian Daerah', 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_jabatan` VALUES ('sagasgsa', 'wdsyh', 'Pengelola Sistem Informasi Manajemen Kepegawaian', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_jabatan` VALUES ('sdgdgdg', 'xcbdsgdsg', 'Kepala Bidang Perencanaan Pengadaan dan Sistem Informasi Pegawai', 3, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for go_pegawai
-- ----------------------------
DROP TABLE IF EXISTS `go_pegawai`;
CREATE TABLE `go_pegawai`  (
  `pegawai_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nama` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `jabatan_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `unor_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `i_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_up` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_datetime` datetime(0) NULL DEFAULT NULL,
  `u_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_datetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`pegawai_id`) USING BTREE,
  UNIQUE INDEX `nip`(`nip`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `jabatan_id`(`jabatan_id`) USING BTREE,
  INDEX `unor_id`(`unor_id`) USING BTREE,
  INDEX `jabatan_id_2`(`jabatan_id`, `unor_id`) USING BTREE,
  CONSTRAINT `go_pegawai_fk1` FOREIGN KEY (`user_id`) REFERENCES `cr_user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `go_pegawai_fk2` FOREIGN KEY (`jabatan_id`) REFERENCES `go_jabatan` (`jabatan_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `go_pegawai_fk3` FOREIGN KEY (`unor_id`) REFERENCES `go_unor` (`unor_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `go_pegawai_fk4` FOREIGN KEY (`jabatan_id`, `unor_id`) REFERENCES `go_jabatan` (`jabatan_id`, `unor_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of go_pegawai
-- ----------------------------
INSERT INTO `go_pegawai` VALUES ('dgdsg', '197601192005011003', 'Widanta Arintaka', NULL, 'asgasgasas', 'wdsyh', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_pegawai` VALUES ('safasfas', '12435', 'Gak Punya Jabatan', NULL, NULL, 'wdsyh', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for go_unor
-- ----------------------------
DROP TABLE IF EXISTS `go_unor`;
CREATE TABLE `go_unor`  (
  `unor_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `unor_kode` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `unor` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `flag_opd` tinyint(1) NOT NULL DEFAULT 0,
  `i_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_up` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_datetime` datetime(0) NULL DEFAULT NULL,
  `u_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_datetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`unor_id`) USING BTREE,
  UNIQUE INDEX `unor_kode`(`unor_kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of go_unor
-- ----------------------------
INSERT INTO `go_unor` VALUES ('afasf', '002.002', 'Bidang Perencanaan', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('asfasf', '001', 'Badan Kepegawaian Daerah', 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('asfasfsf', '001.100.001', 'Subbagian Tata Usaha', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('asgasg', '002.001.001', 'Subbagian Program', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('asgdshsdh', '002.001.002', 'Subbagian Keuangan', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('asgsagasg', '001.001.001', 'Subbagian Program', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('asv45e', '002', 'Badan Perencanaan Pembangunan Daerah', 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('ddfdgf', '001.100.002', 'Seksi Program dan Evaluasi', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('dgdsg', '002.001', 'Sekretariat', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('fassag', '002.002.001', 'Subbidang Sinkronisasi Perencanaan Pembangunan', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('fs', '001.100', 'Balai Latihan Pendidikan Teknik', 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('fsafsaf', '001.002.001', 'Subbidang Perencanaan Pengadaan Pegawai', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('fsafsafs', '001.001.002', 'Subbagian Keuangan', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('sgdsh', '001.001', 'Sekretariat', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('wdsyh', '001.002.002', 'Subbidang Sistem Informasi Pegawai', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('xcbdsgdsg', '001.002', 'Bidang Perencanaan Pengadaan dan Sistem Informasi Pegawai', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_unor` VALUES ('zxvr3', '002.002.002', 'Subbidang Perencanaan Pembangunan', 0, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for go_urusan
-- ----------------------------
DROP TABLE IF EXISTS `go_urusan`;
CREATE TABLE `go_urusan`  (
  `urusan_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `urusan_kode` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `urusan` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `i_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_up` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_datetime` datetime(0) NULL DEFAULT NULL,
  `u_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_datetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`urusan_id`) USING BTREE,
  UNIQUE INDEX `urusan_kode`(`urusan_kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of go_urusan
-- ----------------------------
INSERT INTO `go_urusan` VALUES ('asfasf', '1.02', 'Kesehatan', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_urusan` VALUES ('asfasg', '0', 'Umum', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_urusan` VALUES ('asfsagsag', '2', 'PIlihan', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_urusan` VALUES ('dsdsdh', '3', 'Dais', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_urusan` VALUES ('fassag', '1.01', 'Pendidikan', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_urusan` VALUES ('fsafasf', '1', 'Wajib', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `go_urusan` VALUES ('safsaf', '0.00', 'Umum', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for go_user_unor
-- ----------------------------
DROP TABLE IF EXISTS `go_user_unor`;
CREATE TABLE `go_user_unor`  (
  `user_unor_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `unor_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `i_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_up` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `i_datetime` datetime(0) NULL DEFAULT NULL,
  `u_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_datetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`user_unor_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of go_user_unor
-- ----------------------------
INSERT INTO `go_user_unor` VALUES ('fasasgasg', 'kjy6tyghdfk', 'asfasf', NULL, NULL, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
