/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.7.34-log : Database - dabao
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `idcsmart_admin` */

CREATE TABLE `idcsmart_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '名称',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名,登录用户名',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '登录密码,加密函数:',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '邮箱',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_action_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后操作时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`),
  KEY `nickname` (`nickname`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='管理员表';

/*Data for the table `idcsmart_admin` */

LOCK TABLES `idcsmart_admin` WRITE;

insert  into `idcsmart_admin`(`id`,`nickname`,`name`,`password`,`email`,`status`,`last_login_time`,`last_login_ip`,`last_action_time`,`create_time`,`update_time`) values (1,'管理员','admin','###b9eae231c897d22fbb12a92fe72d4549','11813572222@qq.com',1,1660301871,'14.104.85.91',1660302986,1652257974,1658284592);

UNLOCK TABLES;

/*Table structure for table `idcsmart_admin_login` */

CREATE TABLE `idcsmart_admin_login` (
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_action_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后操作时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '记录创建时间(此表创建是用来实现2小时未操作自动退出登录)',
  `jwt_key` varchar(255) NOT NULL DEFAULT '' COMMENT 'jwt的签发密钥',
  KEY `admin_login_ip` (`admin_id`,`last_login_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `idcsmart_admin_login` */

LOCK TABLES `idcsmart_admin_login` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_admin_role` */

CREATE TABLE `idcsmart_admin_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态;0:禁用;1:正常',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '分组名称',
  `description` varchar(2000) NOT NULL DEFAULT '' COMMENT '分组说明',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='管理员分组表';

/*Data for the table `idcsmart_admin_role` */

LOCK TABLES `idcsmart_admin_role` WRITE;

insert  into `idcsmart_admin_role`(`id`,`status`,`name`,`description`,`create_time`,`update_time`) values (1,1,'超级管理员','拥有所有权限',1652245641,1656039224);

UNLOCK TABLES;

/*Table structure for table `idcsmart_admin_role_link` */

CREATE TABLE `idcsmart_admin_role_link` (
  `admin_role_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分组ID',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  KEY `admin_role_id` (`admin_role_id`) USING BTREE,
  KEY `admin_id` (`admin_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员分组对应表';

/*Data for the table `idcsmart_admin_role_link` */

LOCK TABLES `idcsmart_admin_role_link` WRITE;

insert  into `idcsmart_admin_role_link`(`admin_role_id`,`admin_id`) values (1,9),(1,11),(1,13),(1,15),(1,16),(1,14),(1,19),(1,21),(1,23),(24,29),(24,30),(33,43),(33,50),(24,28),(38,52),(29,53),(29,55),(41,35),(33,42),(34,41),(38,54),(29,57),(33,56),(42,79),(24,87),(29,88),(29,89),(33,90),(1,1),(5,92),(29,94),(29,95),(42,96),(29,91),(3,98),(29,99),(29,100);

UNLOCK TABLES;

/*Table structure for table `idcsmart_api` */

CREATE TABLE `idcsmart_api` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'API密钥ID',
  `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `token` varchar(200) NOT NULL DEFAULT '' COMMENT 'token',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '白名单状态0关闭1开启',
  `ip` text NOT NULL COMMENT '白名单IP',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100014 DEFAULT CHARSET=utf8mb4 COMMENT='API密钥表';

/*Data for the table `idcsmart_api` */

LOCK TABLES `idcsmart_api` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_auth` */

CREATE TABLE `idcsmart_auth` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `title` varchar(1000) NOT NULL DEFAULT '' COMMENT '权限标题,存语言的键',
  `url` varchar(1000) NOT NULL DEFAULT '' COMMENT '页面地址',
  `order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父权限ID',
  `module` varchar(100) NOT NULL DEFAULT '' COMMENT '插件模块路径,如:gateway支付接口/sms短信接口/mail邮件接口/addon插件',
  `plugin` varchar(100) NOT NULL DEFAULT '' COMMENT '插件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=utf8mb4 COMMENT='权限表';

/*Data for the table `idcsmart_auth` */

LOCK TABLES `idcsmart_auth` WRITE;

insert  into `idcsmart_auth`(`id`,`title`,`url`,`order`,`parent_id`,`module`,`plugin`) values (1,'auth_user_management','',1,0,'',''),(2,'auth_user_list','client.html',2,1,'',''),(3,'auth_view','',3,2,'',''),(4,'auth_add','',4,2,'',''),(5,'auth_user_details','',5,1,'',''),(6,'auth_view','',6,5,'',''),(7,'auth_management','',7,5,'',''),(8,'auth_delete','',8,5,'',''),(9,'auth_recharge_record','',9,1,'',''),(10,'auth_view','',10,9,'',''),(11,'auth_management','',11,9,'',''),(12,'auth_log','',12,1,'',''),(13,'auth_business_management','',13,0,'',''),(14,'auth_order_management','order.html',14,13,'',''),(15,'auth_view','',15,14,'',''),(16,'auth_add','',16,14,'',''),(17,'auth_delete','',17,14,'',''),(18,'auth_marker_payment','',18,14,'',''),(19,'auth_adjustment_amount','',19,13,'',''),(20,'auth_host_management','host.html',20,13,'',''),(21,'auth_view','',21,20,'',''),(22,'auth_delete','',22,20,'',''),(23,'auth_host_details','',23,20,'',''),(24,'auth_module_management','',24,20,'',''),(25,'auth_transaction','transaction.html',25,13,'',''),(26,'auth_view','',26,25,'',''),(27,'auth_add','',27,25,'',''),(28,'auth_delete','',28,25,'',''),(29,'auth_product_management','',29,0,'',''),(30,'auth_product_management','product.html',30,29,'',''),(31,'auth_view','',31,30,'',''),(32,'auth_add','',32,30,'',''),(33,'auth_delete','',33,30,'',''),(34,'auth_management','',34,30,'',''),(35,'auth_product_group','',35,29,'',''),(36,'auth_add','',36,35,'',''),(37,'auth_delete','',37,35,'',''),(38,'auth_management','',38,35,'',''),(39,'auth_server_management','server.html',39,29,'',''),(40,'auth_view','',40,39,'',''),(41,'auth_add','',41,39,'',''),(42,'auth_delete','',42,39,'',''),(43,'auth_management','',43,39,'',''),(44,'auth_server_group','server_group.html',44,29,'',''),(45,'auth_view','',45,44,'',''),(46,'auth_add','',46,44,'',''),(47,'auth_delete','',47,44,'',''),(48,'auth_management','',48,44,'',''),(49,'auth_system_settings','',49,0,'',''),(50,'auth_system_settings','configuration_system.html',50,49,'',''),(51,'auth_system_settings','',51,50,'',''),(52,'auth_login_settings','',52,50,'',''),(53,'auth_admin_settings','admin.html',53,49,'',''),(54,'auth_view','',54,53,'',''),(55,'auth_add','',55,53,'',''),(56,'auth_delete','',56,53,'',''),(57,'auth_management','',57,53,'',''),(58,'auth_admin_group','admin_role.html',58,53,'',''),(59,'auth_view','',59,58,'',''),(60,'auth_add','',60,58,'',''),(61,'auth_delete','',61,58,'',''),(62,'auth_management','',62,58,'',''),(63,'auth_security_settings','configuration_security.html',63,49,'',''),(64,'auth_currency_settings','configuration_currency.html',64,49,'',''),(65,'auth_payment_gateway','gateway.html',65,49,'',''),(66,'auth_view','',66,65,'',''),(67,'auth_enable_disable','',67,65,'',''),(68,'auth_install_uninstall_config','',68,65,'',''),(69,'auth_notice','',69,0,'',''),(70,'auth_sms_notice','notice_sms.html',70,69,'',''),(71,'auth_view','',71,70,'',''),(72,'auth_enable_disable','',72,70,'',''),(73,'auth_install_uninstall_config','',73,70,'',''),(74,'auth_template_management','',74,70,'',''),(75,'auth_email_notice','notice_email.html',75,69,'',''),(76,'auth_view','',76,75,'',''),(77,'auth_enable_disable','',77,75,'',''),(78,'auth_install_uninstall_config','',78,75,'',''),(79,'auth_template_management','',79,75,'',''),(80,'auth_send_settings','notice_send.html',80,69,'',''),(81,'auth_management','',81,0,'',''),(82,'auth_task','task.html',82,81,'',''),(83,'auth_view','',83,82,'',''),(84,'auth_management','',84,82,'',''),(85,'auth_log','log_system.html',85,81,'',''),(86,'auth_system_log','log_system.html',86,85,'',''),(87,'auth_notice_log','log_notice_sms.html',87,85,'',''),(88,'auth_auto','cron.html',88,81,'',''),(89,'auth_view','',89,88,'',''),(90,'auth_management','',90,88,'',''),(91,'auth_plugin','',91,0,'',''),(92,'auth_plugin_list','plugin.html',92,91,'',''),(93,'auth_view','',93,92,'',''),(94,'auth_enable_disable','',94,92,'',''),(95,'auth_install_uninstall_config','',95,92,'',''),(246,'智简魔方工单插件','',96,0,'addon','IdcsmartTicket'),(247,'auth_plugin_addon_ticket_list','plugin/idcsmart_ticket/ticket.html',97,246,'addon','IdcsmartTicket'),(248,'auth_plugin_addon_ticket_view','',98,247,'addon','IdcsmartTicket'),(249,'auth_plugin_addon_ticket_receive','',99,247,'addon','IdcsmartTicket'),(250,'auth_plugin_addon_ticket_resolved','',100,247,'addon','IdcsmartTicket'),(251,'auth_plugin_addon_ticket_detail','plugin/idcsmart_ticket/ticket_detail.html',101,246,'addon','IdcsmartTicket'),(252,'auth_plugin_addon_ticket_view','',102,251,'addon','IdcsmartTicket'),(253,'auth_plugin_addon_ticket_reply','',103,251,'addon','IdcsmartTicket'),(254,'auth_plugin_addon_ticket_download','',104,251,'addon','IdcsmartTicket'),(255,'auth_plugin_addon_ticket_internal_list','plugin/idcsmart_ticket/ticket_internal.html',105,246,'addon','IdcsmartTicket'),(256,'auth_plugin_addon_ticket_view','',106,255,'addon','IdcsmartTicket'),(257,'auth_plugin_addon_ticket_view','',107,255,'addon','IdcsmartTicket'),(258,'auth_plugin_addon_ticket_add','',108,255,'addon','IdcsmartTicket'),(259,'auth_plugin_addon_ticket_receive','',109,255,'addon','IdcsmartTicket'),(260,'auth_plugin_addon_ticket_resolved','',110,255,'addon','IdcsmartTicket'),(261,'auth_plugin_addon_ticket_reply','',111,255,'addon','IdcsmartTicket'),(262,'auth_plugin_addon_ticket_forward','',112,255,'addon','IdcsmartTicket'),(264,'文件下载','',113,0,'addon','IdcsmartFileDownload');

UNLOCK TABLES;

/*Table structure for table `idcsmart_auth_link` */

CREATE TABLE `idcsmart_auth_link` (
  `auth_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限ID',
  `admin_role_id` int(11) NOT NULL DEFAULT '0' COMMENT '管理员分组ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限对应表';

/*Data for the table `idcsmart_auth_link` */

LOCK TABLES `idcsmart_auth_link` WRITE;

insert  into `idcsmart_auth_link`(`auth_id`,`admin_role_id`) values (3,33),(4,33),(2,33),(6,33),(7,33),(8,33),(5,33),(10,33),(11,33),(9,33),(12,33),(1,33),(15,33),(16,33),(17,33),(18,33),(14,33),(19,33),(21,33),(22,33),(23,33),(24,33),(20,33),(26,33),(27,33),(28,33),(25,33),(13,33),(31,33),(32,33),(33,33),(34,33),(30,33),(36,33),(37,33),(38,33),(35,33),(40,33),(41,33),(42,33),(43,33),(39,33),(45,33),(46,33),(47,33),(48,33),(44,33),(29,33),(51,33),(52,33),(50,33),(54,33),(55,33),(56,33),(57,33),(53,33),(59,33),(60,33),(61,33),(62,33),(58,33),(63,33),(64,33),(66,33),(67,33),(68,33),(65,33),(49,33),(71,33),(72,33),(73,33),(74,33),(70,33),(76,33),(77,33),(78,33),(79,33),(75,33),(80,33),(69,33),(83,33),(84,33),(82,33),(86,33),(87,33),(85,33),(89,33),(90,33),(88,33),(81,33),(1,38),(2,38),(3,38),(4,38),(5,38),(6,38),(7,38),(8,38),(9,38),(10,38),(11,38),(12,38),(13,38),(14,38),(15,38),(16,38),(17,38),(18,38),(19,38),(20,38),(21,38),(22,38),(23,38),(24,38),(25,38),(26,38),(27,38),(28,38),(31,38),(32,38),(34,38),(35,38),(36,38),(37,38),(38,38),(39,38),(40,38),(41,38),(42,38),(43,38),(44,38),(45,38),(46,38),(47,38),(48,38),(49,38),(50,38),(51,38),(52,38),(53,38),(54,38),(55,38),(56,38),(57,38),(58,38),(59,38),(60,38),(61,38),(62,38),(63,38),(64,38),(65,38),(66,38),(67,38),(68,38),(69,38),(70,38),(71,38),(72,38),(73,38),(74,38),(75,38),(76,38),(77,38),(78,38),(79,38),(80,38),(81,38),(82,38),(83,38),(84,38),(85,38),(86,38),(87,38),(88,38),(89,38),(90,38),(1,42),(2,42),(3,42),(4,42),(5,42),(6,42),(7,42),(8,42),(9,42),(10,42),(11,42),(12,42),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3),(10,3),(11,3),(12,3),(91,3),(92,3),(93,3),(94,3),(95,3),(248,3),(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(42,1),(43,1),(44,1),(45,1),(46,1),(47,1),(48,1),(49,1),(50,1),(51,1),(52,1),(53,1),(54,1),(55,1),(56,1),(57,1),(58,1),(59,1),(60,1),(61,1),(62,1),(63,1),(64,1),(65,1),(66,1),(67,1),(68,1),(69,1),(70,1),(71,1),(72,1),(73,1),(74,1),(75,1),(76,1),(77,1),(78,1),(79,1),(80,1),(81,1),(82,1),(83,1),(84,1),(85,1),(86,1),(87,1),(88,1),(89,1),(90,1),(91,1),(92,1),(93,1),(94,1),(95,1),(246,1),(247,1),(248,1),(249,1),(250,1),(251,1),(252,1),(253,1),(254,1),(255,1),(256,1),(257,1),(258,1),(259,1),(260,1),(261,1),(262,1),(264,1),(1,29),(2,29),(3,29),(4,29),(5,29),(6,29),(7,29),(8,29),(9,29),(10,29),(11,29),(12,29),(29,29),(30,29),(31,29),(32,29),(33,29),(34,29),(35,29),(36,29),(37,29),(38,29),(39,29),(40,29),(41,29),(42,29),(43,29),(44,29),(45,29),(46,29),(47,29),(48,29),(49,29),(50,29),(51,29),(52,29),(53,29),(54,29),(55,29),(56,29),(57,29),(58,29),(59,29),(60,29),(61,29),(62,29),(63,29),(64,29),(65,29),(66,29),(67,29),(68,29),(69,29),(70,29),(71,29),(72,29),(73,29),(74,29),(75,29),(76,29),(77,29),(78,29),(79,29),(80,29),(81,29),(82,29),(83,29),(84,29),(85,29),(86,29),(87,29),(88,29),(89,29),(90,29),(91,29),(92,29),(93,29),(94,29),(95,29),(247,29),(248,29),(249,29),(250,29);

UNLOCK TABLES;

/*Table structure for table `idcsmart_auth_rule` */

CREATE TABLE `idcsmart_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '权限规则ID',
  `name` varchar(150) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `title` varchar(1000) NOT NULL DEFAULT '' COMMENT '规则描述',
  `module` varchar(100) NOT NULL DEFAULT '' COMMENT '插件模块路径,如:gateway支付接口/sms短信接口/mail邮件接口/addon插件',
  `plugin` varchar(100) NOT NULL DEFAULT '' COMMENT '插件',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='权限规则表';

/*Data for the table `idcsmart_auth_rule` */

LOCK TABLES `idcsmart_auth_rule` WRITE;

insert  into `idcsmart_auth_rule`(`id`,`name`,`title`,`module`,`plugin`) values (1,'app\\admin\\controller\\AdminController::adminList','auth_rule_admin_list','',''),(2,'app\\admin\\controller\\AdminController::index','auth_rule_admin_index','',''),(3,'app\\admin\\controller\\AdminController::create','auth_rule_admin_create','',''),(4,'app\\admin\\controller\\AdminController::update','auth_rule_admin_update','',''),(5,'app\\admin\\controller\\AdminController::delete','auth_rule_admin_delete','',''),(6,'app\\admin\\controller\\AdminController::status','auth_rule_admin_status','',''),(7,'app\\admin\\controller\\AdminRoleController::adminRoleList','auth_rule_admin_role_list','',''),(8,'app\\admin\\controller\\AdminRoleController::index','auth_rule_admin_role_index','',''),(9,'app\\admin\\controller\\AdminRoleController::create','auth_rule_admin_role_create','',''),(10,'app\\admin\\controller\\AdminRoleController::update','auth_rule_admin_role_update','',''),(11,'app\\admin\\controller\\AdminRoleController::delete','auth_rule_admin_role_delete','',''),(12,'app\\admin\\controller\\ClientController::clientList','auth_rule_client_list','',''),(13,'app\\admin\\controller\\ClientController::index','auth_rule_client_index','',''),(14,'app\\admin\\controller\\ClientController::create','auth_rule_client_create','',''),(15,'app\\admin\\controller\\ClientController::update','auth_rule_client_update','',''),(16,'app\\admin\\controller\\ClientController::delete','auth_rule_client_delete','',''),(17,'app\\admin\\controller\\ClientController::search','auth_rule_client_search','',''),(18,'app\\admin\\controller\\ClientCreditController::clientCreditList','auth_rule_client_credit_list','',''),(19,'app\\admin\\controller\\ClientCreditController::update','auth_rule_client_credit_update','',''),(20,'app\\admin\\controller\\ConfigurationController::systemList','auth_rule_configuration_system','',''),(21,'app\\admin\\controller\\ConfigurationController::systemUpdate','auth_rule_configuration_system_update','',''),(22,'app\\admin\\controller\\ConfigurationController::loginList','auth_rule_configuration_login','',''),(23,'app\\admin\\controller\\ConfigurationController::loginUpdate','auth_rule_configuration_login_update','',''),(24,'app\\admin\\controller\\ConfigurationController::securityList','auth_rule_configuration_security','',''),(25,'app\\admin\\controller\\ConfigurationController::securityUpdate','auth_rule_configuration_security_update','',''),(26,'app\\admin\\controller\\ConfigurationController::currencyList','auth_rule_configuration_currency','',''),(27,'app\\admin\\controller\\ConfigurationController::currencyUpdate','auth_rule_configuration_currency_update','',''),(28,'app\\admin\\controller\\OrderController::orderList','auth_rule_order_list','',''),(29,'app\\admin\\controller\\OrderController::index','auth_rule_order_index','',''),(30,'app\\admin\\controller\\OrderController::create','auth_rule_order_create','',''),(31,'app\\admin\\controller\\OrderController::updateAmount','auth_rule_order_amount_update','',''),(32,'app\\admin\\controller\\OrderController::paid','auth_rule_order_status_paid','',''),(33,'app\\admin\\controller\\OrderController::delete','auth_rule_order_delete','',''),(34,'app\\admin\\controller\\TransactionController::transactionList','auth_rule_transaction_list','',''),(35,'app\\admin\\controller\\TransactionController::create','auth_rule_transaction_create','',''),(36,'app\\admin\\controller\\TransactionController::delete','auth_rule_transaction_delete','',''),(37,'app\\admin\\controller\\HostController::hostList','auth_rule_host_list','',''),(38,'app\\admin\\controller\\HostController::index','auth_rule_host_index','',''),(39,'app\\admin\\controller\\HostController::update','auth_rule_host_update','',''),(40,'app\\admin\\controller\\HostController::delete','auth_rule_host_delete','',''),(41,'app\\admin\\controller\\PluginController::pluginList','auth_rule_plugin_list','',''),(42,'app\\admin\\controller\\PluginController::setting','auth_rule_plugin_setting','',''),(43,'app\\admin\\controller\\PluginController::status','auth_rule_plugin_status','',''),(44,'app\\admin\\controller\\PluginController::install','auth_rule_plugin_install','',''),(45,'app\\admin\\controller\\PluginController::uninstall','auth_rule_plugin_uninstall','',''),(46,'app\\admin\\controller\\PluginController::settingPost','auth_rule_plugin_setting_update','',''),(47,'app\\admin\\controller\\NoticeEmailController::emailTemplateList','auth_rule_email_template_list','',''),(48,'app\\admin\\controller\\NoticeEmailController::create','auth_rule_email_template_create','',''),(49,'app\\admin\\controller\\NoticeEmailController::index','auth_rule_email_template_index','',''),(50,'app\\admin\\controller\\NoticeEmailController::update','auth_rule_email_template_update','',''),(51,'app\\admin\\controller\\NoticeEmailController::delete','auth_rule_email_template_delete','',''),(52,'app\\admin\\controller\\NoticeEmailController::test','auth_rule_email_template_test','',''),(53,'app\\admin\\controller\\NoticeSmsController::templateList','auth_rule_sms_template_list','',''),(54,'app\\admin\\controller\\NoticeSmsController::create','auth_rule_sms_template_create','',''),(55,'app\\admin\\controller\\NoticeSmsController::index','auth_rule_sms_template_index','',''),(56,'app\\admin\\controller\\NoticeSmsController::update','auth_rule_sms_template_update','',''),(57,'app\\admin\\controller\\NoticeSmsController::delete','auth_rule_sms_template_delete','',''),(58,'app\\admin\\controller\\NoticeSmsController::test','auth_rule_sms_template_test','',''),(59,'app\\admin\\controller\\NoticeSettingController::settingList','auth_rule_notice_setting_list','',''),(60,'app\\admin\\controller\\NoticeSettingController::update','auth_rule_notice_setting_update','',''),(61,'app\\admin\\controller\\TaskController::taskList','auth_rule_task_list','',''),(62,'app\\admin\\controller\\TaskController::retry','auth_rule_task_retry','',''),(63,'app\\admin\\controller\\LogController::systemLogList','auth_rule_system_log_list','',''),(64,'app\\admin\\controller\\LogController::emailLogList','auth_rule_email_log_list','',''),(65,'app\\admin\\controller\\LogController::smsLogList','auth_rule_sms_log_list','',''),(66,'app\\admin\\controller\\ProductController::productList','auth_rule_product_list','',''),(67,'app\\admin\\controller\\ProductController::index','auth_rule_product_index','',''),(68,'app\\admin\\controller\\ProductController::create','auth_rule_product_create','',''),(69,'app\\admin\\controller\\ProductController::update','auth_rule_product_update','',''),(70,'app\\admin\\controller\\ProductController::order','auth_rule_product_order','',''),(71,'app\\admin\\controller\\ProductController::delete','auth_rule_product_delete','',''),(72,'app\\admin\\controller\\ProductController::hidden','auth_rule_product_hidden','',''),(73,'app\\admin\\controller\\ProductGroupController::create','auth_rule_product_group_create','',''),(74,'app\\admin\\controller\\ProductGroupController::moveProduct','auth_rule_product_group_move_product','',''),(75,'app\\admin\\controller\\ProductGroupController::delete','auth_rule_product_group_delete','',''),(76,'app\\admin\\controller\\ProductGroupController::productGroupFirstList','auth_rule_product_group_first_list','',''),(77,'app\\admin\\controller\\ProductGroupController::productGroupSecondList','auth_rule_product_group_second_list','',''),(78,'app\\admin\\controller\\ClientController::login','auth_rule_client_login','',''),(79,'app\\admin\\controller\\ConfigurationController::cronList','auth_rule_configuration_cron','',''),(80,'app\\admin\\controller\\ConfigurationController::cronUpdate','auth_rule_configuration_cron_update','',''),(81,'app\\admin\\controller\\ProductGroupController::update','auth_rule_product_group_update','',''),(82,'app\\admin\\controller\\ProductController::upgrade','auth_rule_product_upgrade','',''),(83,'app\\admin\\controller\\ServerGroupController::serverGroupList','auth_rule_server_group_list','',''),(84,'app\\admin\\controller\\ServerGroupController::create','auth_rule_server_group_create','',''),(85,'app\\admin\\controller\\ServerGroupController::update','auth_rule_server_group_update','',''),(86,'app\\admin\\controller\\ServerGroupController::delete','auth_rule_server_group_delete','',''),(87,'app\\admin\\controller\\ServerController::serverList','auth_rule_server_list','',''),(88,'app\\admin\\controller\\ServerController::create','auth_rule_server_create','',''),(89,'app\\admin\\controller\\ServerController::update','auth_rule_server_update','',''),(90,'app\\admin\\controller\\ServerController::delete','auth_rule_server_delete','',''),(91,'app\\admin\\controller\\ServerController::status','auth_rule_server_status','',''),(92,'app\\admin\\controller\\ModuleController::moduleList','auth_rule_module_list','',''),(93,'app\\admin\\controller\\HostController::adminArea','auth_rule_host_module','',''),(94,'app\\admin\\controller\\HostController::changeConfigOption','auth_rule_host_upgrade_config_option','',''),(95,'app\\admin\\controller\\HostController::changeConfigOptionCalculatePrice','auth_rule_host_upgrade_config_option_price','',''),(96,'app\\admin\\controller\\HostController::createAccount','auth_rule_host_module_create','',''),(97,'app\\admin\\controller\\HostController::suspendAccount','auth_rule_host_module_suspend','',''),(98,'app\\admin\\controller\\HostController::unsuspendAccount','auth_rule_host_module_unsuspend','',''),(99,'app\\admin\\controller\\HostController::terminateAccount','auth_rule_host_module_terminate','',''),(100,'app\\admin\\controller\\ProductController::moduleServerConfigOption','auth_rule_product_server_config_option','',''),(101,'app\\admin\\controller\\ProductController::moduleAdminConfigOption','auth_rule_product_config_option','',''),(102,'app\\admin\\controller\\ProductController::moduleCalculatePrice','auth_rule_product_config_option_price','',''),(103,'app\\admin\\controller\\ClientController::status','auth_rule_client_status','',''),(104,'app\\admin\\controller\\OrderController::getUpgradeAmount','auth_rule_order_upgrade_amount','',''),(216,'addon\\idcsmart_ticket\\controller\\TicketController::ticketList','auth_rule_plugin_addon_ticket_list','addon','IdcsmartTicket'),(217,'addon\\idcsmart_ticket\\controller\\TicketController::receive','auth_rule_plugin_addon_ticket_receive','addon','IdcsmartTicket'),(218,'addon\\idcsmart_ticket\\controller\\TicketController::resolved','auth_rule_plugin_addon_ticket_resolved','addon','IdcsmartTicket'),(219,'addon\\idcsmart_ticket\\controller\\TicketController::index','auth_rule_plugin_addon_ticket_index','addon','IdcsmartTicket'),(220,'addon\\idcsmart_ticket\\controller\\TicketController::reply','auth_rule_plugin_addon_ticket_reply','addon','IdcsmartTicket'),(221,'addon\\idcsmart_ticket\\controller\\TicketController::download','auth_rule_plugin_addon_ticket_download','addon','IdcsmartTicket'),(222,'addon\\idcsmart_ticket\\controller\\TicketInternalController::ticketInternalList','auth_rule_plugin_addon_ticket_internal_list','addon','IdcsmartTicket'),(223,'addon\\idcsmart_ticket\\controller\\TicketInternalController::index','auth_rule_plugin_addon_ticket_internal_index','addon','IdcsmartTicket'),(224,'addon\\idcsmart_ticket\\controller\\TicketInternalController::create','auth_rule_plugin_addon_ticket_internal_create','addon','IdcsmartTicket'),(225,'addon\\idcsmart_ticket\\controller\\TicketInternalController::receive','auth_rule_plugin_addon_ticket_internal_receive','addon','IdcsmartTicket'),(226,'addon\\idcsmart_ticket\\controller\\TicketInternalController::resolved','auth_rule_plugin_addon_ticket_internal_resolved','addon','IdcsmartTicket'),(227,'addon\\idcsmart_ticket\\controller\\TicketInternalController::reply','auth_rule_plugin_addon_ticket_internal_reply','addon','IdcsmartTicket'),(228,'addon\\idcsmart_ticket\\controller\\TicketInternalController::forward','auth_rule_plugin_addon_ticket_internal_forward','addon','IdcsmartTicket');

UNLOCK TABLES;

/*Table structure for table `idcsmart_auth_rule_link` */

CREATE TABLE `idcsmart_auth_rule_link` (
  `auth_rule_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限规则ID',
  `auth_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限ID',
  KEY `auth_rule_id` (`auth_rule_id`),
  KEY `auth_id` (`auth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限规则对应表';

/*Data for the table `idcsmart_auth_rule_link` */

LOCK TABLES `idcsmart_auth_rule_link` WRITE;

insert  into `idcsmart_auth_rule_link`(`auth_rule_id`,`auth_id`) values (12,3),(14,4),(13,6),(15,7),(103,7),(16,8),(18,10),(19,11),(63,12),(64,12),(65,12),(28,15),(29,15),(30,16),(17,16),(82,16),(66,16),(101,16),(102,16),(104,16),(33,17),(32,18),(31,19),(37,21),(40,22),(38,23),(39,23),(93,24),(94,24),(95,24),(96,24),(97,24),(98,24),(99,24),(34,26),(35,27),(17,27),(36,28),(66,31),(67,31),(68,32),(76,32),(77,32),(71,33),(69,34),(70,34),(72,34),(83,34),(87,34),(100,34),(73,36),(76,36),(75,37),(74,38),(81,38),(87,40),(88,41),(92,41),(90,42),(89,43),(91,43),(92,43),(83,45),(84,46),(87,46),(86,47),(85,48),(87,48),(20,51),(21,51),(22,52),(23,52),(1,54),(3,55),(7,55),(5,56),(2,57),(4,57),(6,57),(7,57),(7,59),(9,60),(11,61),(8,62),(10,62),(24,63),(25,63),(26,64),(27,64),(41,66),(43,67),(42,68),(44,68),(45,68),(46,68),(41,71),(43,72),(42,73),(44,73),(45,73),(46,73),(53,74),(54,74),(55,74),(56,74),(57,74),(58,74),(41,76),(43,77),(42,78),(44,78),(45,78),(46,78),(47,79),(48,79),(49,79),(50,79),(51,79),(52,79),(59,80),(60,80),(61,83),(62,84),(63,86),(64,87),(65,87),(79,89),(80,90),(41,93),(43,94),(42,95),(44,95),(45,95),(46,95),(216,248),(217,249),(218,250),(219,252),(220,253),(221,254),(222,256),(223,257),(224,258),(225,259),(226,260),(227,261),(228,262);

UNLOCK TABLES;

/*Table structure for table `idcsmart_cart` */

CREATE TABLE `idcsmart_cart` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `data` text NOT NULL COMMENT '购物车数据',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='购物车表';

/*Data for the table `idcsmart_cart` */

LOCK TABLES `idcsmart_cart` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_client` */

CREATE TABLE `idcsmart_client` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '客户ID',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态:0禁用',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮件',
  `phone_code` int(11) NOT NULL DEFAULT '44' COMMENT '国际电话区号  默认44中国为+86',
  `phone` varchar(100) NOT NULL DEFAULT '' COMMENT '电话',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '密码',
  `credit` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `company` varchar(255) NOT NULL DEFAULT '' COMMENT '公司',
  `country` varchar(100) NOT NULL DEFAULT '' COMMENT '国家',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '地址',
  `language` varchar(100) NOT NULL DEFAULT '' COMMENT '语言',
  `notes` varchar(1000) NOT NULL DEFAULT '' COMMENT '备注',
  `client_notes` varchar(1000) NOT NULL DEFAULT '' COMMENT '用户备注',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `last_action_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后操作时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `email` (`email`),
  KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

/*Data for the table `idcsmart_client` */

LOCK TABLES `idcsmart_client` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_client_credit` */

CREATE TABLE `idcsmart_client_credit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户余额变更记录ID',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '类型:人工Artificial 充值Recharge 应用至订单Applied 超付Overpayment 少付Underpayment 退款Refund',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `credit` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更后余额',
  `notes` varchar(1000) NOT NULL DEFAULT '' COMMENT '备注',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `host_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=964 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='用户余额变更记录表';

/*Data for the table `idcsmart_client_credit` */

LOCK TABLES `idcsmart_client_credit` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_client_login` */

CREATE TABLE `idcsmart_client_login` (
  `client_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_action_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后操作时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '记录创建时间',
  `jwt_key` varchar(255) NOT NULL DEFAULT '' COMMENT 'jwt的签发密钥',
  KEY `client_login_ip` (`client_id`,`last_login_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `idcsmart_client_login` */

LOCK TABLES `idcsmart_client_login` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_config_option` */

CREATE TABLE `idcsmart_config_option` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自定义配置ID',
  `module` varchar(100) NOT NULL DEFAULT '' COMMENT '模块名称',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '显示名称',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段名',
  `data` text NOT NULL COMMENT '配置规则',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `module` (`module`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='自定义配置表';

/*Data for the table `idcsmart_config_option` */

LOCK TABLES `idcsmart_config_option` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_config_option_sub` */

CREATE TABLE `idcsmart_config_option_sub` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自定义配置子项ID',
  `config_option_id` int(11) NOT NULL DEFAULT '0' COMMENT '自定义配置ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '显示名称',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段名',
  `data` text NOT NULL COMMENT '子项规则',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `config_option_id` (`config_option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='自定义配置子项';

/*Data for the table `idcsmart_config_option_sub` */

LOCK TABLES `idcsmart_config_option_sub` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_configuration` */

CREATE TABLE `idcsmart_configuration` (
  `setting` text NOT NULL,
  `value` text NOT NULL,
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `description` text NOT NULL COMMENT '说明',
  KEY `setting` (`setting`(32)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

/*Data for the table `idcsmart_configuration` */

LOCK TABLES `idcsmart_configuration` WRITE;

insert  into `idcsmart_configuration`(`setting`,`value`,`create_time`,`update_time`,`description`) values ('lang_admin','zh-cn',0,0,'后台默认语言'),('lang_home','zh-cn',0,0,'前台默认语言'),('lang_home_open','0',0,0,'前台多语言开关 1开启，0关闭'),('maintenance_mode','1',0,0,'维护模式开关 1开启，0关闭'),('maintenance_mode_message','维护模式',0,0,'维护模式内容'),('website_name','智简魔方1',0,0,'网站名称'),('website_url','https://financenew.wyhluoyu.com',0,0,'网站域名地址'),('terms_service_url','https://financenew.wyhluoyu.com',0,0,'服务条款地址'),('login_phone_verify','1',0,0,'手机号登录短信验证开关 1开启，0关闭'),('captcha_client_register','0',0,0,'客户注册图形验证码开关  1开启，0关闭'),('captcha_client_login','1',0,0,'客户登录图形验证码开关  1开启，0关闭'),('captcha_admin_login','0',0,0,'管理员登录图形验证码开关  1开启，0关闭'),('captcha_client_login_error','0',0,0,'客户登录失败图形验证码开关  1开启，0关闭'),('captcha_width','200',0,0,'图形验证码宽度'),('captcha_height','50',0,0,'图形验证码高度'),('captcha_length','4',0,0,'图形验证码字符长度'),('register_email','1',0,0,'邮箱注册开关 1开启，0关闭'),('register_phone','1',0,0,'手机号注册开关 1开启，0关闭'),('currency_code','CNY',0,0,'货币代码'),('currency_prefix','￥',0,0,'货币符号'),('recharge_open','1',0,0,'启用充值'),('recharge_min','0.01',0,0,'单笔最小金额'),('task','1',0,0,'任务队列锁'),('system_version','1.0.0',0,0,'系统版本'),('send_sms','Idcsmart',0,0,'默认短信发送国内接口'),('send_sms_global','Submail',0,0,'默认短信发送国际接口'),('send_email','Idcsmartmail',0,0,'默认邮件发送接口'),('cron_lock','0',0,0,'定时任务锁'),('cron_lock_last_time','1660302841',0,0,'定时任务最后执行时间'),('cron_lock_day_last_time','1660296842',0,0,'每天执行一次定时任务最后执行时间'),('task_time','1660302979',0,0,'队列执行时长，然后程序结束'),('cron_lock_five_minute_last_time','1660302841',0,0,'每五分钟执行一次定时任务最后执行时间'),('cron_lock_start_time','1660302961',0,0,'定时任务开始执行时间'),('cron_due_suspend_swhitch','1',0,0,'产品到期暂停开关 1开启，0关闭'),('cron_due_suspend_day','2',0,0,'产品到期暂停X天后暂停'),('cron_due_unsuspend_swhitch','1',0,0,'财务原因产品暂停后付款自动解封开关 1开启，0关闭'),('cron_due_terminate_swhitch','1',0,0,'产品到期删除开关 1开启，0关闭'),('cron_due_terminate_day','7',0,0,'产品到期X天后删除'),('cron_due_renewal_first_swhitch','1',0,0,'续费第一次提醒开关 1开启，0关闭'),('cron_due_renewal_first_day','7',0,0,'续费X天后到期第一次提醒'),('cron_due_renewal_second_swhitch','1',0,0,'续费第二次提醒开关 1开启，0关闭'),('cron_due_renewal_second_day','3',0,0,'续费X天后到期第二次提醒'),('cron_overdue_first_swhitch','1',0,0,'产品逾期第一次提醒开关 1开启，0关闭'),('cron_overdue_first_day','3',0,0,'产品逾期X天后第一次提醒'),('cron_overdue_second_swhitch','1',0,0,'产品逾期第二次提醒开关 1开启，0关闭'),('cron_overdue_second_day','4',0,0,'产品逾期X天后第二次提醒'),('cron_overdue_third_swhitch','1',0,0,'产品逾期第三次提醒开关 1开启，0关闭'),('cron_overdue_third_day','6',0,0,'产品逾期X天后第三次提醒'),('cron_ticket_close_swhitch','1',0,0,'自动关闭工单开关 1开启，0关闭'),('cron_ticket_close_day','3',0,0,'已回复状态的工单超过x小时后关闭'),('cron_aff_swhitch','1',0,0,'推介月报开关 1开启，0关闭'),('currency_suffix','元',0,0,'货币后缀'),('code_client_email_register','1',0,0,'邮箱注册数字验证码开关:1开启0关闭'),('cron_order_overdue_day','5',0,0,'订单未付款通知'),('cron_order_overdue_swhitch','1',0,0,'订单未付款通知开关 1开启，0关闭'),('admin_theme','default',0,0,'后台主题'),('clientarea_theme','default',0,0,'会员中心主题');

UNLOCK TABLES;

/*Table structure for table `idcsmart_country` */

CREATE TABLE `idcsmart_country` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `iso` varchar(80) NOT NULL,
  `iso3` varchar(80) NOT NULL,
  `name` varchar(80) NOT NULL,
  `name_zh` varchar(80) NOT NULL,
  `nicename` varchar(80) NOT NULL,
  `num_code` smallint(6) NOT NULL,
  `phone_code` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `phone_code` (`phone_code`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

/*Data for the table `idcsmart_country` */

LOCK TABLES `idcsmart_country` WRITE;

insert  into `idcsmart_country`(`id`,`iso`,`iso3`,`name`,`name_zh`,`nicename`,`num_code`,`phone_code`,`order`) values (1,'AF','AFG','AFGHANISTAN','阿富汗','Afghanistan',4,93,0),(2,'AL','ALB','ALBANIA','阿尔巴尼亚','Albania',8,355,0),(3,'DZ','DZA','ALGERIA','阿尔及利亚','Algeria',12,213,0),(4,'AS','ASM','AMERICAN SAMOA','美属萨摩亚','American Samoa',16,1684,0),(5,'AD','AND','ANDORRA','安道尔','Andorra',20,376,0),(6,'AO','AGO','ANGOLA','安哥拉','Angola',24,244,0),(7,'AI','AIA','ANGUILLA','安圭拉岛','Anguilla',660,1264,0),(8,'AQ','','ANTARCTICA','南极洲','Antarctica',0,0,0),(9,'AG','ATG','ANTIGUA AND BARBUDA','安提瓜岛和巴布达','Antigua and Barbuda',28,1268,0),(10,'AR','ARG','ARGENTINA','阿根廷','Argentina',32,54,0),(11,'AM','ARM','ARMENIA','亚美尼亚','Armenia',51,374,0),(12,'AW','ABW','ARUBA','阿鲁巴岛','Aruba',533,297,0),(13,'AU','AUS','AUSTRALIA','澳大利亚','Australia',36,61,0),(14,'AT','AUT','AUSTRIA','奥地利','Austria',40,43,0),(15,'AZ','AZE','AZERBAIJAN','阿塞拜疆','Azerbaijan',31,994,0),(16,'BS','BHS','BAHAMAS','巴哈马群岛','Bahamas',44,1242,0),(17,'BH','BHR','BAHRAIN','巴林','Bahrain',48,973,0),(18,'BD','BGD','BANGLADESH','孟加拉国','Bangladesh',50,880,0),(19,'BB','BRB','BARBADOS','巴巴多斯','Barbados',52,1246,0),(20,'BY','BLR','BELARUS','白俄罗斯','Belarus',112,375,0),(21,'BE','BEL','BELGIUM','比利时','Belgium',56,32,0),(22,'BZ','BLZ','BELIZE','伯利兹','Belize',84,501,0),(23,'BJ','BEN','BENIN','贝宁','Benin',204,229,0),(24,'BM','BMU','BERMUDA','百慕大','Bermuda',60,1441,0),(25,'BT','BTN','BHUTAN','不丹','Bhutan',64,975,0),(26,'BO','BOL','BOLIVIA','玻利维亚','Bolivia',68,591,0),(27,'BA','BIH','BOSNIA AND HERZEGOVINA','波斯尼亚和黑塞哥维那','Bosnia and Herzegovina',70,387,0),(28,'BW','BWA','BOTSWANA','博茨瓦纳','Botswana',72,267,0),(29,'BV','','BOUVET ISLAND','布维岛','Bouvet Island',0,0,0),(30,'BR','BRA','BRAZIL','巴西','Brazil',76,55,0),(31,'IO','','BRITISH INDIAN OCEAN TERRITORY','英属印度洋领地','British Indian Ocean Territory',0,246,0),(32,'BN','BRN','BRUNEI DARUSSALAM','文莱达鲁萨兰国','Brunei Darussalam',96,673,0),(33,'BG','BGR','BULGARIA','保加利亚','Bulgaria',100,359,0),(34,'BF','BFA','BURKINA FASO','布吉纳法索','Burkina Faso',854,226,0),(35,'BI','BDI','BURUNDI','布隆迪','Burundi',108,257,0),(36,'KH','KHM','CAMBODIA','柬埔寨','Cambodia',116,855,0),(37,'CM','CMR','CAMEROON','喀麦隆','Cameroon',120,237,0),(38,'CA','CAN','CANADA','加拿大','Canada',124,1,0),(39,'CV','CPV','CAPE VERDE','佛得角','Cape Verde',132,238,0),(40,'KY','CYM','CAYMAN ISLANDS','开曼群岛','Cayman Islands',136,1345,0),(41,'CF','CAF','CENTRAL AFRICAN REPUBLIC','中非共和国','Central African Republic',140,236,0),(42,'TD','TCD','CHAD','乍得','Chad',148,235,0),(43,'CL','CHL','CHILE','智利','Chile',152,56,0),(44,'CN','CHN','CHINA','中国','China',156,86,0),(45,'CX','','CHRISTMAS ISLAND','圣诞岛','Christmas Island',0,61,0),(46,'CC','','COCOS (KEELING) ISLANDS','COCOS(KEELING)岛','Cocos (Keeling) Islands',0,672,0),(47,'CO','COL','COLOMBIA','哥伦比亚','Colombia',170,57,0),(48,'KM','COM','COMOROS','科摩罗','Comoros',174,269,0),(49,'CG','COG','CONGO','刚果','Congo',178,242,0),(50,'CD','COD','CONGO, THE DEMOCRATIC REPUBLIC OF THE','刚果民主共和国的','Congo, the Democratic Republic of the',180,242,0),(51,'CK','COK','COOK ISLANDS','库克群岛','Cook Islands',184,682,0),(52,'CR','CRI','COSTA RICA','哥斯达黎加','Costa Rica',188,506,0),(53,'CI','CIV','COTE D\'IVOIRE','科特迪瓦','Cote D\'Ivoire',384,225,0),(54,'HR','HRV','CROATIA','克罗地亚','Croatia',191,385,0),(55,'CU','CUB','CUBA','古巴','Cuba',192,53,0),(56,'CY','CYP','CYPRUS','塞浦路斯','Cyprus',196,357,0),(57,'CZ','CZE','CZECH REPUBLIC','捷克共和国','Czech Republic',203,420,0),(58,'DK','DNK','DENMARK','丹麦','Denmark',208,45,0),(59,'DJ','DJI','DJIBOUTI','吉布提','Djibouti',262,253,0),(60,'DM','DMA','DOMINICA','多米尼加','Dominica',212,1767,0),(61,'DO','DOM','DOMINICAN REPUBLIC','多米尼加共和国','Dominican Republic',214,1809,0),(62,'EC','ECU','ECUADOR','厄瓜多尔','Ecuador',218,593,0),(63,'EG','EGY','EGYPT','埃及','Egypt',818,20,0),(64,'SV','SLV','EL SALVADOR','萨尔瓦多','El Salvador',222,503,0),(65,'GQ','GNQ','EQUATORIAL GUINEA','赤道几内亚','Equatorial Guinea',226,240,0),(66,'ER','ERI','ERITREA','厄立特里亚','Eritrea',232,291,0),(67,'EE','EST','ESTONIA','爱沙尼亚','Estonia',233,372,0),(68,'ET','ETH','ETHIOPIA','埃塞俄比亚','Ethiopia',231,251,0),(69,'FK','FLK','FALKLAND ISLANDS (MALVINAS)','福克兰群岛(马尔维纳斯)','Falkland Islands (Malvinas)',238,500,0),(70,'FO','FRO','FAROE ISLANDS','法罗群岛','Faroe Islands',234,298,0),(71,'FJ','FJI','FIJI','斐济','Fiji',242,679,0),(72,'FI','FIN','FINLAND','芬兰','Finland',246,358,0),(73,'FR','FRA','FRANCE','法国','France',250,33,0),(74,'GF','GUF','FRENCH GUIANA','法属圭亚那','French Guiana',254,594,0),(75,'PF','PYF','FRENCH POLYNESIA','法属波利尼西亚','French Polynesia',258,689,0),(76,'TF','','FRENCH SOUTHERN TERRITORIES','法国南部地区','French Southern Territories',0,0,0),(77,'GA','GAB','GABON','加蓬','Gabon',266,241,0),(78,'GM','GMB','GAMBIA','冈比亚','Gambia',270,220,0),(79,'GE','GEO','GEORGIA','乔治亚州','Georgia',268,995,0),(80,'DE','DEU','GERMANY','德国','Germany',276,49,0),(81,'GH','GHA','GHANA','加纳','Ghana',288,233,0),(82,'GI','GIB','GIBRALTAR','直布罗陀','Gibraltar',292,350,0),(83,'GR','GRC','GREECE','希腊','Greece',300,30,0),(84,'GL','GRL','GREENLAND','格陵兰岛','Greenland',304,299,0),(85,'GD','GRD','GRENADA','格林纳达','Grenada',308,1473,0),(86,'GP','GLP','GUADELOUPE','瓜德罗普岛','Guadeloupe',312,590,0),(87,'GU','GUM','GUAM','关岛','Guam',316,1671,0),(88,'GT','GTM','GUATEMALA','危地马拉','Guatemala',320,502,0),(89,'GN','GIN','GUINEA','几内亚','Guinea',324,224,0),(90,'GW','GNB','GUINEA-BISSAU','几内亚比绍','Guinea-Bissau',624,245,0),(91,'GY','GUY','GUYANA','圭亚那','Guyana',328,592,0),(92,'HT','HTI','HAITI','海地','Haiti',332,509,0),(93,'HM','','HEARD ISLAND AND MCDONALD ISLANDS','听到岛和麦当劳的岛屿','Heard Island and Mcdonald Islands',0,0,0),(94,'VA','VAT','HOLY SEE (VATICAN CITY STATE)','教廷(梵蒂冈)','Holy See (Vatican City State)',336,39,0),(95,'HN','HND','HONDURAS','洪都拉斯','Honduras',340,504,0),(96,'HK','HKG','HONG KONG','中国香港','Hong Kong',344,852,0),(97,'HU','HUN','HUNGARY','匈牙利','Hungary',348,36,0),(98,'IS','ISL','ICELAND','冰岛','Iceland',352,354,0),(99,'IN','IND','INDIA','印度','India',356,91,0),(100,'ID','IDN','INDONESIA','印尼','Indonesia',360,62,0),(101,'IR','IRN','IRAN, ISLAMIC REPUBLIC OF','伊朗伊斯兰共和国','Iran, Islamic Republic of',364,98,0),(102,'IQ','IRQ','IRAQ','伊拉克','Iraq',368,964,0),(103,'IE','IRL','IRELAND','爱尔兰','Ireland',372,353,0),(104,'IL','ISR','ISRAEL','以色列','Israel',376,972,0),(105,'IT','ITA','ITALY','意大利','Italy',380,39,0),(106,'JM','JAM','JAMAICA','牙买加','Jamaica',388,1876,0),(107,'JP','JPN','JAPAN','日本','Japan',392,81,0),(108,'JO','JOR','JORDAN','约旦','Jordan',400,962,0),(109,'KZ','KAZ','KAZAKHSTAN','哈萨克斯坦','Kazakhstan',398,7,0),(110,'KE','KEN','KENYA','肯尼亚','Kenya',404,254,0),(111,'KI','KIR','KIRIBATI','基里巴斯','Kiribati',296,686,0),(112,'KP','PRK','KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF','朝鲜民主主义人民共和国','Korea, Democratic People\'s Republic of',408,850,0),(113,'KR','KOR','KOREA, REPUBLIC OF','朝鲜共和国','Korea, Republic of',410,82,0),(114,'KW','KWT','KUWAIT','科威特','Kuwait',414,965,0),(115,'KG','KGZ','KYRGYZSTAN','吉尔吉斯斯坦','Kyrgyzstan',417,996,0),(116,'LA','LAO','LAO PEOPLE\'S DEMOCRATIC REPUBLIC','老挝人民民主共和国','Lao People\'s Democratic Republic',418,856,0),(117,'LV','LVA','LATVIA','拉脱维亚','Latvia',428,371,0),(118,'LB','LBN','LEBANON','黎巴嫩','Lebanon',422,961,0),(119,'LS','LSO','LESOTHO','莱索托','Lesotho',426,266,0),(120,'LR','LBR','LIBERIA','利比里亚','Liberia',430,231,0),(121,'LY','LBY','LIBYAN ARAB JAMAHIRIYA','阿拉伯利比亚民众国','Libyan Arab Jamahiriya',434,218,0),(122,'LI','LIE','LIECHTENSTEIN','列支敦斯登','Liechtenstein',438,423,0),(123,'LT','LTU','LITHUANIA','立陶宛','Lithuania',440,370,0),(124,'LU','LUX','LUXEMBOURG','卢森堡','Luxembourg',442,352,0),(125,'MO','MAC','MACAO','澳门','Macao',446,853,0),(126,'MK','MKD','MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF','前南斯拉夫马其顿共和国','Macedonia, the Former Yugoslav Republic of',807,389,0),(127,'MG','MDG','MADAGASCAR','马达加斯加','Madagascar',450,261,0),(128,'MW','MWI','MALAWI','马拉维','Malawi',454,265,0),(129,'MY','MYS','MALAYSIA','马来西亚','Malaysia',458,60,0),(130,'MV','MDV','MALDIVES','马尔代夫','Maldives',462,960,0),(131,'ML','MLI','MALI','马里','Mali',466,223,0),(132,'MT','MLT','MALTA','马耳他','Malta',470,356,0),(133,'MH','MHL','MARSHALL ISLANDS','马绍尔群岛','Marshall Islands',584,692,0),(134,'MQ','MTQ','MARTINIQUE','马提尼克岛','Martinique',474,596,0),(135,'MR','MRT','MAURITANIA','毛利塔尼亚','Mauritania',478,222,0),(136,'MU','MUS','MAURITIUS','毛里求斯','Mauritius',480,230,0),(137,'YT','','MAYOTTE','马约特岛','Mayotte',0,269,0),(138,'MX','MEX','MEXICO','墨西哥','Mexico',484,52,0),(139,'FM','FSM','MICRONESIA, FEDERATED STATES OF','密克罗尼西亚联邦','Micronesia, Federated States of',583,691,0),(140,'MD','MDA','MOLDOVA, REPUBLIC OF','摩尔多瓦共和国','Moldova, Republic of',498,373,0),(141,'MC','MCO','MONACO','摩纳哥','Monaco',492,377,0),(142,'MN','MNG','MONGOLIA','蒙古','Mongolia',496,976,0),(143,'MS','MSR','MONTSERRAT','蒙特塞拉特','Montserrat',500,1664,0),(144,'MA','MAR','MOROCCO','摩洛哥','Morocco',504,212,0),(145,'MZ','MOZ','MOZAMBIQUE','MOZAMBIQUE','Mozambique',508,258,0),(146,'MM','MMR','MYANMAR','缅甸','Myanmar',104,95,0),(147,'NA','NAM','NAMIBIA','纳米比亚','Namibia',516,264,0),(148,'NR','NRU','NAURU','瑙鲁','Nauru',520,674,0),(149,'NP','NPL','NEPAL','尼泊尔','Nepal',524,977,0),(150,'NL','NLD','NETHERLANDS','荷兰','Netherlands',528,31,0),(151,'AN','ANT','NETHERLANDS ANTILLES','荷属安的列斯群岛','Netherlands Antilles',530,599,0),(152,'NC','NCL','NEW CALEDONIA','新喀里多尼亚','New Caledonia',540,687,0),(153,'NZ','NZL','NEW ZEALAND','新西兰','New Zealand',554,64,0),(154,'NI','NIC','NICARAGUA','尼加拉瓜','Nicaragua',558,505,0),(155,'NE','NER','NIGER','尼日尔','Niger',562,227,0),(156,'NG','NGA','NIGERIA','尼日利亚','Nigeria',566,234,0),(157,'NU','NIU','NIUE','纽埃岛','Niue',570,683,0),(158,'NF','NFK','NORFOLK ISLAND','诺福克岛','Norfolk Island',574,672,0),(159,'MP','MNP','NORTHERN MARIANA ISLANDS','北马里亚纳群岛','Northern Mariana Islands',580,1670,0),(160,'NO','NOR','NORWAY','挪威','Norway',578,47,0),(161,'OM','OMN','OMAN','阿曼','Oman',512,968,0),(162,'PK','PAK','PAKISTAN','巴基斯坦','Pakistan',586,92,0),(163,'PW','PLW','PALAU','帕劳','Palau',585,680,0),(164,'PS','','PALESTINIAN TERRITORY, OCCUPIED','巴勒斯坦的领土,占领','Palestinian Territory, Occupied',0,970,0),(165,'PA','PAN','PANAMA','巴拿马','Panama',591,507,0),(166,'PG','PNG','PAPUA NEW GUINEA','巴布新几内亚','Papua New Guinea',598,675,0),(167,'PY','PRY','PARAGUAY','巴拉圭','Paraguay',600,595,0),(168,'PE','PER','PERU','秘鲁','Peru',604,51,0),(169,'PH','PHL','PHILIPPINES','菲律宾','Philippines',608,63,0),(170,'PN','PCN','PITCAIRN','皮特克恩','Pitcairn',612,0,0),(171,'PL','POL','POLAND','波兰','Poland',616,48,0),(172,'PT','PRT','PORTUGAL','葡萄牙','Portugal',620,351,0),(173,'PR','PRI','PUERTO RICO','波多黎各','Puerto Rico',630,1787,0),(174,'QA','QAT','QATAR','卡塔尔','Qatar',634,974,0),(175,'RE','REU','REUNION','团聚','Reunion',638,262,0),(176,'RO','ROM','ROMANIA','罗马尼亚','Romania',642,40,0),(177,'RU','RUS','RUSSIAN FEDERATION','俄罗斯联邦','Russian Federation',643,70,0),(178,'RW','RWA','RWANDA','卢旺达','Rwanda',646,250,0),(179,'SH','SHN','SAINT HELENA','圣赫勒拿','Saint Helena',654,290,0),(180,'KN','KNA','SAINT KITTS AND NEVIS','圣基茨和尼维斯','Saint Kitts and Nevis',659,1869,0),(181,'LC','LCA','SAINT LUCIA','圣卢西亚岛','Saint Lucia',662,1758,0),(182,'PM','SPM','SAINT PIERRE AND MIQUELON','圣皮埃尔和MIQUELON','Saint Pierre and Miquelon',666,508,0),(183,'VC','VCT','SAINT VINCENT AND THE GRENADINES','圣文森特和格林纳丁斯','Saint Vincent and the Grenadines',670,1784,0),(184,'WS','WSM','SAMOA','萨摩亚','Samoa',882,684,0),(185,'SM','SMR','SAN MARINO','圣马力诺','San Marino',674,378,0),(186,'ST','STP','SAO TOME AND PRINCIPE','圣多美和王子','Sao Tome and Principe',678,239,0),(187,'SA','SAU','SAUDI ARABIA','沙特阿拉伯','Saudi Arabia',682,966,0),(188,'SN','SEN','SENEGAL','塞内加尔','Senegal',686,221,0),(189,'CS','','SERBIA AND MONTENEGRO','塞尔维亚和黑山','Serbia and Montenegro',0,381,0),(190,'SC','SYC','SEYCHELLES','塞舌尔','Seychelles',690,248,0),(191,'SL','SLE','SIERRA LEONE','塞拉利昂','Sierra Leone',694,232,0),(192,'SG','SGP','SINGAPORE','新加坡','Singapore',702,65,0),(193,'SK','SVK','SLOVAKIA','斯洛伐克','Slovakia',703,421,0),(194,'SI','SVN','SLOVENIA','斯洛文尼亚','Slovenia',705,386,0),(195,'SB','SLB','SOLOMON ISLANDS','所罗门群岛','Solomon Islands',90,677,0),(196,'SO','SOM','SOMALIA','索马里','Somalia',706,252,0),(197,'ZA','ZAF','SOUTH AFRICA','南非','South Africa',710,27,0),(198,'GS','','SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS','南乔治亚岛和南桑威奇群岛','South Georgia and the South Sandwich Islands',0,0,0),(199,'ES','ESP','SPAIN','西班牙','Spain',724,34,0),(200,'LK','LKA','SRI LANKA','斯里兰卡','Sri Lanka',144,94,0),(201,'SD','SDN','SUDAN','苏丹','Sudan',736,249,0),(202,'SR','SUR','SURINAME','苏里南','Suriname',740,597,0),(203,'SJ','SJM','SVALBARD AND JAN MAYEN','斯瓦尔巴群岛和扬马延岛','Svalbard and Jan Mayen',744,47,0),(204,'SZ','SWZ','SWAZILAND','斯威士兰','Swaziland',748,268,0),(205,'SE','SWE','SWEDEN','瑞典','Sweden',752,46,0),(206,'CH','CHE','SWITZERLAND','瑞士','Switzerland',756,41,0),(207,'SY','SYR','SYRIAN ARAB REPUBLIC','阿拉伯叙利亚共和国','Syrian Arab Republic',760,963,0),(208,'TW','TWN','TAIWAN, PROVINCE OF CHINA','中国台湾地区','Taiwan, Province of China',158,886,0),(209,'TJ','TJK','TAJIKISTAN','塔吉克斯坦','Tajikistan',762,992,0),(210,'TZ','TZA','TANZANIA, UNITED REPUBLIC OF','坦桑尼亚联合共和国','Tanzania, United Republic of',834,255,0),(211,'TH','THA','THAILAND','泰国','Thailand',764,66,0),(212,'TL','','TIMOR-LESTE','东帝汶','Timor-Leste',0,670,0),(213,'TG','TGO','TOGO','多哥','Togo',768,228,0),(214,'TK','TKL','TOKELAU','托克劳','Tokelau',772,690,0),(215,'TO','TON','TONGA','汤加','Tonga',776,676,0),(216,'TT','TTO','TRINIDAD AND TOBAGO','特立尼达和多巴哥','Trinidad and Tobago',780,1868,0),(217,'TN','TUN','TUNISIA','突尼斯','Tunisia',788,216,0),(218,'TR','TUR','TURKEY','土耳其','Turkey',792,90,0),(219,'TM','TKM','TURKMENISTAN','土库曼斯坦','Turkmenistan',795,7370,0),(220,'TC','TCA','TURKS AND CAICOS ISLANDS','特克斯和凯科斯群岛','Turks and Caicos Islands',796,1649,0),(221,'TV','TUV','TUVALU','图瓦卢','Tuvalu',798,688,0),(222,'UG','UGA','UGANDA','乌干达','Uganda',800,256,0),(223,'UA','UKR','UKRAINE','乌克兰','Ukraine',804,380,0),(224,'AE','ARE','UNITED ARAB EMIRATES','阿拉伯联合酋长国','United Arab Emirates',784,971,0),(225,'GB','GBR','UNITED KINGDOM','联合王国','United Kingdom',826,44,0),(226,'US','USA','UNITED STATES','美国','United States',840,1,0),(227,'UM','','UNITED STATES MINOR OUTLYING ISLANDS','美国小离岛','United States Minor Outlying Islands',0,1,0),(228,'UY','URY','URUGUAY','乌拉圭','Uruguay',858,598,0),(229,'UZ','UZB','UZBEKISTAN','乌兹别克斯坦','Uzbekistan',860,998,0),(230,'VU','VUT','VANUATU','瓦努阿图','Vanuatu',548,678,0),(231,'VE','VEN','VENEZUELA','委内瑞拉','Venezuela',862,58,0),(232,'VN','VNM','VIET NAM','越南','Viet Nam',704,84,0),(233,'VG','VGB','VIRGIN ISLANDS, BRITISH','维尔京群岛,英国','Virgin Islands, British',92,1284,0),(234,'VI','VIR','VIRGIN ISLANDS, U.S.','维尔京群岛,美国','Virgin Islands, U.s.',850,1340,0),(235,'WF','WLF','WALLIS AND FUTUNA','瓦利斯群岛和富图纳群岛','Wallis and Futuna',876,681,0),(236,'EH','ESH','WESTERN SAHARA','西撒哈拉','Western Sahara',732,212,0),(237,'YE','YEM','YEMEN','也门','Yemen',887,967,0),(238,'ZM','ZMB','ZAMBIA','赞比亚','Zambia',894,260,0),(239,'ZW','ZWE','ZIMBABWE','津巴布韦','Zimbabwe',716,263,0);

UNLOCK TABLES;

/*Table structure for table `idcsmart_email_log` */

CREATE TABLE `idcsmart_email_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '邮件日志ID',
  `subject` varchar(100) NOT NULL DEFAULT '' COMMENT '邮件标题',
  `message` text NOT NULL COMMENT '邮件内容',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发送状态:1成功,0失败',
  `to` varchar(100) NOT NULL DEFAULT '' COMMENT '收件邮箱',
  `fail_reason` varchar(1000) NOT NULL DEFAULT '' COMMENT '失败原因',
  `rel_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联ID',
  `type` varchar(20) NOT NULL DEFAULT 'client' COMMENT '关联类型:client表示rel_id关联客户id,admin表示rel_id关联管理员id',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'ip',
  `port` int(11) NOT NULL DEFAULT '0' COMMENT '端口号',
  PRIMARY KEY (`id`),
  KEY `rel_id_type` (`rel_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2482 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

/*Data for the table `idcsmart_email_log` */

LOCK TABLES `idcsmart_email_log` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_email_template` */

CREATE TABLE `idcsmart_email_template` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '邮件模板ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '模板名称',
  `subject` varchar(100) NOT NULL DEFAULT '' COMMENT '模板标题',
  `message` text NOT NULL COMMENT '模板内容',
  `attachment` text NOT NULL COMMENT '附件',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='邮件模板表';

/*Data for the table `idcsmart_email_template` */

LOCK TABLES `idcsmart_email_template` WRITE;

insert  into `idcsmart_email_template`(`id`,`name`,`subject`,`message`,`attachment`,`create_time`,`update_time`) values (1,'验证码','[{system_website_name}]验证码邮件','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]收到新的验证码</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span><br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您正在申请验证码：</span><br /><span style=\"margin: 0; padding: 0; line-height: 32px;\">为了账号安全，请在指定位置输入下列验证码： <span style=\"margin: 0; padding: 0; color: #007bfc; font-size: 18px; font-weight: bold;\">{code}</span>。 验证码涉及个人账号隐私安全，切勿向他人透漏。</span><br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span>\r\n<div class=\"logo_top\">&nbsp;</div>\r\n</div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',1652863243,1652943008),(2,'用户登录','[{system_website_name}]用户登录','<p>&nbsp;</p>\n<div class=\"box\">\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\n<div class=\"card\">\n<h2 style=\"text-align: center;\">[{system_website_name}]用户登录</h2>\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\n<div class=\"card\">您的账号{account}成功登录系统，如不是本人操作请及时修改密码<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\n<ul class=\"banquan\">\n<li>{system_website_name}</li>\n</ul>\n</div>','',0,1660274230),(3,'用户注册','[{system_website_name}]用户注册','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]用户注册</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">{account}，感谢您支持{system_website_name}<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(4,'客户更改邮箱','[{system_website_name}]客户更改邮箱','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]用户更改邮箱</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的邮箱被改为：{client_email}，请注意账户安全<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(5,'客户更改密码','[{system_website_name}]客户更改密码','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]用户更改密码</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的密码被改为：{client_password}，请注意账户安全<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(6,'订单创建','[{system_website_name}]订单创建','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]订单创建</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您已下单，订单：{order_id}（订单号），请及时支付<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(7,'产品开通中','[{system_website_name}]产品开通中','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]产品开通中</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的产品：{product_name}（产品名称）正在开通，请耐心等待<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,1660301886),(8,'开通成功','[{system_website_name}]开通成功','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]开通成功</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的产品：{product_name}（产品名称），已开通可使用<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(9,'产品暂停通知','[{system_website_name}]产品暂停通知','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]产品暂停通知</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的产品：{product_name}（产品名称），{product_suspend_reason}，已被停用，有疑问请联系客服<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(10,'产品解除暂停通知','[{system_website_name}]产品解除暂停通知','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]产品解除暂停通知</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的产品：{product_name}（产品名称），已解除暂停<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(11,'产品删除通知','[{system_website_name}]产品删除通知','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]产品删除通知</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的产品：{product_name}（产品名称），由于已经到期续费，已被清除用户数据，有疑问请联系客服<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(12,'产品升降级','[{system_website_name}]产品升降级','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]产品升降级</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您已成功升级产品{product_info}，感谢您的支持<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(13,'超级管理员添加后台管理员','[{system_website_name}]超级管理员添加后台管理员','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]超级管理员添加后台管理员</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您已被设置为后台管理员，登录账户为：{admin_name}，密码为：{admin_password}<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(14,'第一次续费提醒','[{system_website_name}]第一次续费提醒','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]第一次续费提醒</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的产品：{product_name}（产品名称），还有{renewal_first)天到期，请注意是否续费<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(15,'第二次续费提醒','[{system_website_name}]第二次续费提醒','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]第二次续费提醒</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的产品：{product_name}（产品名称），还有{renewal_second}天到期，请注意是否续费<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(16,'逾期付款第一次','[{system_website_name}]逾期付款第一次','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]逾期付款第一次</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的产品：{product_name}（产品名称），将会删除，请及时续费<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(17,'逾期付款第二次','[{system_website_name}]逾期付款第二次','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]逾期付款第二次</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的产品：{product_name}（产品名称），将会删除，请及时续费<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(18,'逾期付款第三次','[{system_website_name}]逾期付款第三次','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]逾期付款第三次</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的产品：{product_name}（产品名称），将会删除，请及时续费<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(19,'订单未付款通知','[{system_website_name}]订单未付款通知','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]订单未付款通知</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的订单：{order_id}（订单号）尚未支付，金额{order_amount}，请及时支付<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(20,'订单金额修改','[{system_website_name}]订单金额修改','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]订单金额修改</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的订单：{order_id}（订单号）金额修改为{order_amount}，请及时支付<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(21,'订单支付通知','[{system_website_name}]订单支付通知','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]订单支付通知</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的订单：{order_id}（订单号）支付成功，支付金额为：{order_amount}元<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(22,'充值成功通知','[{system_website_name}]充值成功通知','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]充值成功通知</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">充值成功，本次充值金额为：{order_amount}元<br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 60px;\">如果本次请求并非由您发起，请务必告知我们, 由此给您带来的不便敬请谅解。</span><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',0,0),(56,'产品退款申请','[{system_website_name}]产品退款申请','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]产品退款申请</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的退款申请（产品{product_name}），正在处理<br /><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',1660202081,0),(57,'产品退款成功','[{system_website_name}]产品退款成功','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]产品退款成功</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的退款申请（产品{product_name}），已成功退款<br /><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',1660202081,0),(58,'产品退款驳回','[{system_website_name}]产品退款驳回','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]产品退款驳回</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的退款申请（产品{product_name}），被驳回<br /><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',1660202082,0),(59,'产品取消请求','[{system_website_name}]产品取消请求','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]产品取消请求</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的退款申请（产品{product_name}），被取消<br /><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',1660202082,0),(102,'客户新增工单','[{system_website_name}]客户新增工单','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]客户新增工单</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的工单：{subject}正在处理中，请耐心等待<br /><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',1660290299,0),(103,'客户关闭工单','[{system_website_name}]客户关闭工单','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]客户关闭工单</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的工单：{subject}已关闭<br /><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',1660290300,0),(104,'管理员回复工单','[{system_website_name}]管理员回复工单','<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"> <title>Document</title> <style> li{list-style: none;} a{text-decoration: none;} body{margin: 0;} .box{ background-color: #EBEBEB; height: 100%; } .logo_top {padding: 20px 0;} .logo_top img{ display: block; width: auto; margin: 0 auto; } .card{ width: 650px; margin: 0 auto; background-color: white; font-size: 0.8rem; line-height: 22px; padding: 40px 50px; box-sizing: border-box; } .contimg{ text-align: center; } button{ background-color: #F75697; padding: 8px 16px; border-radius: 6px; outline: none; color: white; border: 0; } .lvst{ color: #57AC80; } .banquan{ display: flex; justify-content: center; flex-wrap: nowrap; color: #B7B8B9; font-size: 0.4rem; padding: 20px 0; margin: 0; padding-left: 0; } .banquan li span{ display: inline-block; padding: 0 8px; } @media (max-width: 650px){ .card{ padding: 5% 5%; } .logo_top img,.contimg img{width: 280px;} .box{height: auto;} .card{width: auto;} } @media (max-width: 280px){.logo_top img,.contimg img{width: 100%;}} </style> </head> <body>\r\n<div class=\"box\">\r\n<div class=\"logo_top\"><img src=\"{system_logo_url}\" alt=\"\" /></div>\r\n<div class=\"card\">\r\n<h2 style=\"text-align: center;\">[{system_website_name}]管理员回复工单</h2>\r\n<br /><strong>尊敬的用户</strong> <br /><span style=\"margin: 0; padding: 0; display: inline-block; margin-top: 55px;\">您好！</span></div>\r\n<div class=\"card\">您的工单：{subject}有新回复<br /><br />&nbsp; <span style=\"margin: 0; padding: 0; display: inline-block; width: 100%; text-align: right;\"> <strong>{system_website_name}</strong> </span><br /><span style=\"margin: 0; padding: 0; margin-top: 20px; display: inline-block; width: 100%; text-align: right;\">{send_time}</span></div>\r\n<ul class=\"banquan\">\r\n<li>{system_website_name}</li>\r\n</ul>\r\n</div>\r\n</body> </html>','',1660290301,0);

UNLOCK TABLES;

/*Table structure for table `idcsmart_host` */

CREATE TABLE `idcsmart_host` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `server_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务器ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '标识名称',
  `status` varchar(20) NOT NULL DEFAULT '' COMMENT '状态Unpaid未付款Pending开通中Active已开通Suspended已暂停Deleted已删除Failed开通失败',
  `suspend_type` varchar(50) NOT NULL DEFAULT '' COMMENT '暂停类型,overdue=到期暂停,overtraffic=超流暂停,certification_not_complete=实名未完成,other=其他',
  `suspend_reason` varchar(1000) NOT NULL DEFAULT '' COMMENT '暂停原因',
  `suspend_time` int(11) NOT NULL DEFAULT '0' COMMENT '暂停时间',
  `gateway` varchar(100) NOT NULL DEFAULT '' COMMENT '支付方式',
  `gateway_name` varchar(100) NOT NULL DEFAULT '' COMMENT '支付方式名称',
  `first_payment_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '首付金额',
  `renew_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '续费金额',
  `billing_cycle` varchar(100) NOT NULL DEFAULT '' COMMENT '计费周期免费free，一次onetime，周期先付recurring_prepayment,周期后付recurring_postpaid',
  `billing_cycle_name` varchar(100) NOT NULL DEFAULT '' COMMENT '模块计费周期名称',
  `billing_cycle_time` int(11) NOT NULL DEFAULT '0' COMMENT '模块计费周期时间,秒',
  `notes` varchar(1000) NOT NULL DEFAULT '' COMMENT '备注',
  `client_notes` varchar(1000) NOT NULL DEFAULT '' COMMENT '用户备注',
  `active_time` int(11) NOT NULL DEFAULT '0' COMMENT '开通时间',
  `due_time` int(11) NOT NULL DEFAULT '0' COMMENT '到期时间',
  `termination_time` int(11) NOT NULL DEFAULT '0' COMMENT '终止时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4815 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='产品表';

/*Data for the table `idcsmart_host` */

LOCK TABLES `idcsmart_host` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_host_config_option` */

CREATE TABLE `idcsmart_host_config_option` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '产品和自定义配置关联ID',
  `host_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `config_option_id` int(11) NOT NULL DEFAULT '0' COMMENT '自定义配置ID',
  `config_option_sub_id` int(11) NOT NULL DEFAULT '0' COMMENT '自定义配置子项ID',
  `data` text CHARACTER SET utf8 NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`),
  KEY `host_id` (`host_id`),
  KEY `config_option_id` (`config_option_id`),
  KEY `config_option_sub_id` (`config_option_sub_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1474 DEFAULT CHARSET=utf8mb4 COMMENT='产品和自定义配置关联表';

/*Data for the table `idcsmart_host_config_option` */

LOCK TABLES `idcsmart_host_config_option` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_menu` */

CREATE TABLE `idcsmart_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '类型admin后台home前台',
  `menu_type` varchar(20) NOT NULL DEFAULT '' COMMENT '菜单类型system系统plugin插件custom自定义',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `language` text NOT NULL COMMENT '多语言',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '地址',
  `icon` varchar(255) NOT NULL DEFAULT '' COMMENT '图标',
  `nav_id` int(11) NOT NULL DEFAULT '0' COMMENT '系统页面ID',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级ID',
  `order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `nav_id` (`nav_id`),
  KEY `parent_id` (`parent_id`),
  KEY `menu_type` (`menu_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='导航菜单表';

/*Data for the table `idcsmart_menu` */

LOCK TABLES `idcsmart_menu` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_nav` */

CREATE TABLE `idcsmart_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '默认导航表',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '类型admin后台home前台',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '地址',
  `icon` varchar(255) NOT NULL DEFAULT '' COMMENT '图标',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级id',
  `order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '插件模块路径,如:gateway支付接口/sms短信接口/mail邮件接口/addon插件',
  `plugin` varchar(100) NOT NULL DEFAULT '' COMMENT '插件',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='默认导航表';

/*Data for the table `idcsmart_nav` */

LOCK TABLES `idcsmart_nav` WRITE;

insert  into `idcsmart_nav`(`id`,`type`,`name`,`url`,`icon`,`parent_id`,`order`,`module`,`plugin`) values (1,'admin','nav_user_management','','user',0,2,'',''),(2,'admin','nav_user_list','client.html','',1,3,'',''),(3,'admin','nav_business_management','','view-module',0,4,'',''),(4,'admin','nav_order_management','order.html','',3,5,'',''),(5,'admin','nav_host_management','host.html','',3,6,'',''),(6,'admin','nav_transaction','transaction.html','',3,7,'',''),(7,'admin','nav_product_management','','cart',0,8,'',''),(8,'admin','nav_product_management','product.html','',7,9,'',''),(9,'admin','nav_server_management','server.html','',7,10,'',''),(10,'admin','nav_server_group','server_group.html','',7,11,'',''),(11,'admin','nav_system_settings','','setting',0,12,'',''),(12,'admin','nav_system_settings','configuration_system.html','',11,13,'',''),(13,'admin','nav_admin_settings','admin.html','',11,14,'',''),(14,'admin','nav_security_settings','configuration_security.html','',11,15,'',''),(15,'admin','nav_currency_settings','configuration_currency.html','',11,16,'',''),(16,'admin','nav_payment_gateway','gateway.html','',11,17,'',''),(17,'admin','nav_notice','','folder-open',0,18,'',''),(18,'admin','nav_sms_notice','notice_sms.html','',17,19,'',''),(19,'admin','nav_email_notice','notice_email.html','',17,20,'',''),(20,'admin','nav_send_settings','notice_send.html','',17,21,'',''),(21,'admin','nav_management','','precise-monitor',0,22,'',''),(22,'admin','nav_task','task.html','',21,23,'',''),(23,'admin','nav_log','log_system.html','',21,24,'',''),(24,'admin','nav_auto','cron.html','',21,25,'',''),(25,'admin','nav_plugin','','control-platform',0,220,'',''),(26,'admin','nav_plugin_list','plugin.html','',25,27,'',''),(27,'home','nav_index','index.html','',0,0,'',''),(28,'home','nav_host_list','host.html','',0,1,'',''),(29,'home','nav_finance_info','finance.html','',0,2,'',''),(30,'home','nav_account_info','account.html','',0,3,'',''),(31,'home','nav_security','security.html','',0,4,'',''),(131,'admin','nav_plugin_addon_idcsmart_refund','plugin/idcsmart_refund/index.html','',25,98,'addon','IdcsmartRefund'),(132,'admin','nav_plugin_addon_refund','','tools',0,99,'addon','IdcsmartRefund'),(133,'admin','nav_plugin_addon_refund_list','plugin/idcsmart_refund/refund.html','',132,100,'addon','IdcsmartRefund'),(134,'admin','nav_plugin_addon_refund_product_list','plugin/idcsmart_refund/refund_product.html','',132,101,'addon','IdcsmartRefund'),(135,'admin','nav_plugin_addon_idcsmart_promo_code','plugin/idcsmart_promo_code/index.html','',25,103,'addon','IdcsmartPromoCode'),(139,'admin','nav_plugin_addon_idcsmart_news','plugin/idcsmart_news/index.html','',25,111,'addon','IdcsmartNews'),(140,'admin','nav_plugin_addon_idcsmart_help','plugin/idcsmart_help/index.html','',25,113,'addon','IdcsmartHelp'),(251,'admin','nav_plugin_addon_idcsmart_ticket','plugin/idcsmart_ticket/index.html','',25,197,'addon','IdcsmartTicket'),(252,'admin','nav_plugin_addon_ticket','','tools',0,198,'addon','IdcsmartTicket'),(253,'admin','nav_plugin_addon_ticket_list','plugin/idcsmart_ticket/ticket.html','',1,199,'addon','IdcsmartTicket'),(254,'admin','nav_plugin_addon_ticket_internal_list','plugin/idcsmart_ticket/ticket_internal.html','',252,200,'addon','IdcsmartTicket'),(255,'home','nav_plugin_addon_ticket','','',0,201,'addon','IdcsmartTicket'),(256,'home','nav_plugin_addon_ticket_list','plugin/idcsmart_ticket/ticket.html','',255,202,'addon','IdcsmartTicket'),(266,'admin','nav_plugin_addon_idcsmart_file_download','plugin/idcsmart_file_download/index.html','',25,215,'addon','IdcsmartFileDownload');

UNLOCK TABLES;

/*Table structure for table `idcsmart_notice_setting` */

CREATE TABLE `idcsmart_notice_setting` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '发送管理',
  `name` varchar(100) NOT NULL COMMENT '动作标识名称',
  `name_lang` varchar(100) NOT NULL DEFAULT '' COMMENT '动作名称',
  `sms_global_name` varchar(50) NOT NULL DEFAULT '' COMMENT '短信国际接口名称',
  `sms_global_template` int(10) NOT NULL DEFAULT '0' COMMENT '短信国际接口模板id',
  `sms_name` varchar(50) NOT NULL DEFAULT '' COMMENT '短信国内接口名称',
  `sms_template` int(10) NOT NULL DEFAULT '0' COMMENT '短信国内接口模板id',
  `sms_enable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0禁用,1启用',
  `email_name` varchar(50) NOT NULL DEFAULT '' COMMENT '邮件接口名称',
  `email_template` int(10) NOT NULL DEFAULT '0' COMMENT '邮件接口模板id',
  `email_enable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0禁用,1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4;

/*Data for the table `idcsmart_notice_setting` */

LOCK TABLES `idcsmart_notice_setting` WRITE;

insert  into `idcsmart_notice_setting`(`id`,`name`,`name_lang`,`sms_global_name`,`sms_global_template`,`sms_name`,`sms_template`,`sms_enable`,`email_name`,`email_template`,`email_enable`) values (26,'code','','',0,'Idcsmart',79,1,'Smtp',1,1),(41,'client_login_success','','',0,'Idcsmart',80,1,'Smtp',2,1),(42,'client_register_success','','',0,'Idcsmart',81,1,'Smtp',3,1),(43,'client_change_phone','','',0,'Idcsmart',82,1,'',0,1),(44,'client_change_email','','',0,'',0,1,'Smtp',4,1),(45,'client_change_password','','',0,'Idcsmart',84,1,'Smtp',5,1),(46,'order_create','','',0,'Idcsmart',85,1,'Smtp',6,1),(47,'host_pending','','',0,'Idcsmart',86,1,'Smtp',7,1),(48,'host_active','','',0,'Idcsmart',87,1,'Smtp',8,1),(49,'host_suspend','','',0,'Idcsmart',88,1,'Smtp',9,1),(50,'host_unsuspend','','',0,'Idcsmart',89,1,'Smtp',10,1),(51,'host_terminate','','',0,'Idcsmart',90,1,'Smtp',11,1),(52,'host_upgrad','','',0,'Idcsmart',91,1,'Smtp',12,1),(53,'admin_create_account','','',0,'',0,1,'Smtp',13,1),(54,'host_renewal_first','','',0,'Idcsmart',93,1,'Smtp',14,1),(55,'host_renewal_second','','',0,'Idcsmart',94,1,'Smtp',15,1),(56,'host_overdue_first','','',0,'Idcsmart',95,1,'Smtp',16,1),(57,'host_overdue_second','','',0,'Idcsmart',96,1,'Smtp',17,1),(58,'host_overdue_third','','',0,'Idcsmart',97,1,'Smtp',18,1),(59,'order_overdue','','',0,'Idcsmart',100,1,'Smtp',19,1),(60,'admin_order_amount','','',0,'Idcsmart',101,1,'Smtp',20,1),(61,'order_pay','','',0,'Idcsmart',102,1,'Smtp',21,1),(62,'order_recharge','','',0,'Idcsmart',103,1,'Smtp',22,1),(80,'client_create_refund','产品退款申请','',0,'Idcsmart',172,1,'Smtp',56,1),(81,'client_refund_success','产品退款成功','',0,'Idcsmart',173,1,'Smtp',57,1),(82,'admin_refund_reject','产品退款驳回','',0,'Idcsmart',174,1,'Smtp',58,1),(83,'client_refund_cancel','产品取消请求','',0,'Idcsmart',175,1,'Smtp',59,1),(118,'client_create_ticket','客户新增工单','',0,'Idcsmart',209,1,'Smtp',102,1),(119,'client_close_ticket','客户关闭工单','',0,'Idcsmart',210,1,'Smtp',103,1),(120,'admin_reply_ticket','管理员回复工单','',0,'Idcsmart',211,1,'Smtp',104,1);

UNLOCK TABLES;

/*Table structure for table `idcsmart_order` */

CREATE TABLE `idcsmart_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` varchar(10) NOT NULL DEFAULT 'new' COMMENT '类型new新订单renew续费订单upgrade升降级订单artificial人工订单',
  `status` varchar(10) NOT NULL DEFAULT 'Unpaid' COMMENT '状态Paid已付款Unpaid未付款',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `credit` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `amount_unpaid` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '未付款金额',
  `upgrade_refund` tinyint(1) NOT NULL DEFAULT '1' COMMENT '升降级是否退款0否1是',
  `gateway` varchar(100) NOT NULL DEFAULT '' COMMENT '支付方式',
  `gateway_name` varchar(100) NOT NULL DEFAULT '' COMMENT '支付方式名称',
  `notes` varchar(1000) NOT NULL DEFAULT '' COMMENT '备注',
  `pay_time` int(11) NOT NULL DEFAULT '0' COMMENT '支付时间',
  `due_time` int(11) NOT NULL DEFAULT '0' COMMENT '到期时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `type` (`type`),
  KEY `status` (`status`),
  KEY `amount` (`amount`),
  KEY `pay_time` (`pay_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2146 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='订单表';

/*Data for the table `idcsmart_order` */

LOCK TABLES `idcsmart_order` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_order_item` */

CREATE TABLE `idcsmart_order_item` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单子项ID',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `host_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '关联类型',
  `rel_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联ID',
  `description` varchar(1000) NOT NULL DEFAULT '' COMMENT '描述',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `gateway` varchar(100) NOT NULL DEFAULT '' COMMENT '支付方式',
  `gateway_name` varchar(100) NOT NULL DEFAULT '' COMMENT '支付方式名称',
  `notes` varchar(1000) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `client_id` (`client_id`),
  KEY `rel_id` (`type`,`rel_id`),
  KEY `host_id` (`host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3713 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='订单子项表';

/*Data for the table `idcsmart_order_item` */

LOCK TABLES `idcsmart_order_item` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_order_tmp` */

CREATE TABLE `idcsmart_order_tmp` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `tmp_order_id` varchar(50) NOT NULL DEFAULT '' COMMENT '21-22位临时订单ID,传入三方接口',
  `tmp_order_id2` varchar(30) NOT NULL DEFAULT '' COMMENT '18位临时订单ID规则2,传入三方接口',
  `tmp_order_id3` varchar(20) NOT NULL DEFAULT '' COMMENT '10位临时订单ID规则3,传入三方接口',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间,72小时定时任务清除',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `tmp_order_id` (`tmp_order_id`),
  KEY `tmp_order_id2` (`tmp_order_id2`),
  KEY `tmp_order_id3` (`tmp_order_id3`)
) ENGINE=InnoDB AUTO_INCREMENT=1559 DEFAULT CHARSET=utf8mb4;

/*Data for the table `idcsmart_order_tmp` */

LOCK TABLES `idcsmart_order_tmp` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_plugin` */

CREATE TABLE `idcsmart_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:开启;0:禁用',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '插件标识名,英文字母(唯一)',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '插件名称',
  `url` text COMMENT '图标地址',
  `author` varchar(255) NOT NULL DEFAULT '' COMMENT '作者',
  `author_url` text COMMENT '作者链接',
  `version` varchar(20) NOT NULL DEFAULT '1.0' COMMENT '插件版本号',
  `description` text COMMENT '插件描述',
  `config` text COMMENT '插件配置',
  `module` varchar(25) NOT NULL DEFAULT '' COMMENT '插件模块路径,如:gateway支付接口/sms短信接口/mail邮件接口/addon插件',
  `order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `help_url` varchar(1000) NOT NULL DEFAULT '' COMMENT '帮助文档',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '插件更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='插件表';

/*Data for the table `idcsmart_plugin` */

LOCK TABLES `idcsmart_plugin` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_plugin_hook` */

CREATE TABLE `idcsmart_plugin_hook` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `plugin` varchar(50) NOT NULL DEFAULT '' COMMENT '插件标识名',
  `module` varchar(25) NOT NULL DEFAULT 'addon' COMMENT '插件所属模块',
  `order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `plugin` (`plugin`),
  KEY `module` (`plugin`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='插件钩子表';

/*Data for the table `idcsmart_plugin_hook` */

LOCK TABLES `idcsmart_plugin_hook` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_price` */

CREATE TABLE `idcsmart_price` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '模块周期价格表ID',
  `module` varchar(100) NOT NULL DEFAULT '' COMMENT '模块名称',
  `config_option_sub_id` int(11) NOT NULL DEFAULT '0' COMMENT '自定义配置子项ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '标识',
  `billing_cycle` int(11) NOT NULL DEFAULT '0' COMMENT '计费周期,按秒存储',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `module` (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='模块周期价格表';

/*Data for the table `idcsmart_price` */

LOCK TABLES `idcsmart_price` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_product` */

CREATE TABLE `idcsmart_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品表ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '商品名称',
  `product_group_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属商品组ID',
  `description` text COMMENT '商品描述',
  `hidden` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0显示默认，1隐藏',
  `stock_control` tinyint(1) NOT NULL DEFAULT '0' COMMENT '库存控制(1:启用)默认0',
  `qty` int(11) NOT NULL DEFAULT '0' COMMENT '库存数量(与stock_control有关)',
  `pay_type` varchar(255) NOT NULL DEFAULT '' COMMENT '付款类型(免费free，一次onetime，周期先付recurring_prepayment,周期后付recurring_postpaid',
  `auto_setup` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否自动开通:1是默认,0否',
  `type` varchar(50) NOT NULL DEFAULT 'server_group' COMMENT '关联类型:server,server_group',
  `rel_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联ID',
  `order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `creating_notice_sms` tinyint(1) NOT NULL DEFAULT '1' COMMENT '开通中短信通知是否开启:1开启默认,0关闭',
  `creating_notice_sms_api` int(11) NOT NULL DEFAULT '0' COMMENT '开通中短信通知接口,默认0',
  `creating_notice_sms_api_template` int(11) NOT NULL DEFAULT '0' COMMENT '开通中短信通知接口模板,默认0',
  `created_notice_sms` tinyint(1) NOT NULL DEFAULT '1' COMMENT '已开通短信通知是否开启:1开启默认,0关闭',
  `created_notice_sms_api` int(11) NOT NULL DEFAULT '0' COMMENT '已开通短信通知接口,默认0',
  `created_notice_sms_api_template` int(11) NOT NULL DEFAULT '0' COMMENT '已开通短信通知接口模板,默认0',
  `creating_notice_mail` tinyint(1) NOT NULL DEFAULT '1' COMMENT '开通中邮件通知是否开启:1开启默认,0关闭',
  `creating_notice_mail_api` int(11) NOT NULL DEFAULT '0' COMMENT '开通中邮件通知接口',
  `creating_notice_mail_template` int(11) NOT NULL DEFAULT '0' COMMENT '开通中邮件通知模板,默认0',
  `created_notice_mail` tinyint(1) NOT NULL DEFAULT '1' COMMENT '已开通邮件通知是否开启:1开启默认,0关闭',
  `created_notice_mail_api` int(11) NOT NULL DEFAULT '0' COMMENT '已开通邮件通知接口',
  `created_notice_mail_template` int(11) NOT NULL DEFAULT '0' COMMENT '已开通邮件通知模板,默认0',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '父级商品ID',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `product_group_id` (`product_group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='商品表';

/*Data for the table `idcsmart_product` */

LOCK TABLES `idcsmart_product` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_product_group` */

CREATE TABLE `idcsmart_product_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品组表ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '商品组名称',
  `hidden` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认0，1：隐藏',
  `order` int(11) NOT NULL DEFAULT '0' COMMENT '排序，默认处理为添加自增长',
  `parent_id` int(10) NOT NULL DEFAULT '0' COMMENT '父分组ID,0表示此分组为一级分组',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `order` (`order`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='商品组表';

/*Data for the table `idcsmart_product_group` */

LOCK TABLES `idcsmart_product_group` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_product_upgrade_product` */

CREATE TABLE `idcsmart_product_upgrade_product` (
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `upgrade_product_id` int(11) NOT NULL DEFAULT '0' COMMENT '可升降级商品ID',
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `idcsmart_product_upgrade_product` */

LOCK TABLES `idcsmart_product_upgrade_product` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_server` */

CREATE TABLE `idcsmart_server` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '接口ID',
  `server_group_id` int(11) NOT NULL DEFAULT '0' COMMENT '接口分组ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '接口名称',
  `module` varchar(100) NOT NULL DEFAULT '' COMMENT '模块名称',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '地址',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '密码',
  `hash` text NOT NULL COMMENT '哈希',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态0禁用1启用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `module` (`module`),
  KEY `server_group_id` (`server_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COMMENT='接口表';

/*Data for the table `idcsmart_server` */

LOCK TABLES `idcsmart_server` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_server_group` */

CREATE TABLE `idcsmart_server_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '接口分组ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '接口分组名称',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COMMENT='接口分组表';

/*Data for the table `idcsmart_server_group` */

LOCK TABLES `idcsmart_server_group` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_sms_log` */

CREATE TABLE `idcsmart_sms_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '短信日志ID',
  `phone_code` int(11) NOT NULL DEFAULT '44' COMMENT '国际区号',
  `phone` varchar(100) NOT NULL DEFAULT '' COMMENT '手机号',
  `template_code` varchar(100) NOT NULL DEFAULT '' COMMENT '模板标识',
  `content` text NOT NULL COMMENT '模板内容',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发送状态:1成功,0失败',
  `fail_reason` varchar(1000) NOT NULL DEFAULT '' COMMENT '失败原因',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `rel_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联ID',
  `type` varchar(20) NOT NULL DEFAULT 'client' COMMENT '关联类型:client表示rel_id关联客户id,admin表示rel_id关联管理员id',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'ip',
  `port` int(11) NOT NULL DEFAULT '0' COMMENT '端口号',
  PRIMARY KEY (`id`),
  KEY `rel_id_type` (`rel_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='短信日志';

/*Data for the table `idcsmart_sms_log` */

LOCK TABLES `idcsmart_sms_log` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_sms_template` */

CREATE TABLE `idcsmart_sms_template` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` varchar(100) NOT NULL DEFAULT '' COMMENT '模板ID',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0大陆，1国际',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '模板标题',
  `content` text NOT NULL COMMENT '模板内容',
  `notes` varchar(1000) NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未提交，1审核中，2通过，3未通过',
  `sms_name` varchar(50) NOT NULL DEFAULT '' COMMENT '模板接口标识名称',
  `error` varchar(1000) NOT NULL DEFAULT '' COMMENT '模板提交接口审核错误信息',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `template_id` (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='短信模板';

/*Data for the table `idcsmart_sms_template` */

LOCK TABLES `idcsmart_sms_template` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_system_log` */

CREATE TABLE `idcsmart_system_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统日志ID',
  `type` varchar(50) NOT NULL DEFAULT '' COMMENT '类型',
  `rel_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联ID',
  `description` text NOT NULL COMMENT '描述',
  `user_type` varchar(20) NOT NULL DEFAULT '' COMMENT '操作人类型client用户admin管理员system系统cron定时任务',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作人ID',
  `user_name` varchar(100) NOT NULL DEFAULT '' COMMENT '操作人名称',
  `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `port` int(11) NOT NULL DEFAULT '0' COMMENT '端口',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `rel_id` (`type`,`rel_id`),
  KEY `user_id` (`user_type`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10352 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='系统日志表';

/*Data for the table `idcsmart_system_log` */

LOCK TABLES `idcsmart_system_log` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_task` */

CREATE TABLE `idcsmart_task` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '关联类型',
  `rel_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联ID',
  `status` varchar(20) NOT NULL DEFAULT '' COMMENT '状态Wait未开始Exec执行中Finish完成Failed失败',
  `retry` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已重试0否1是',
  `description` varchar(1000) NOT NULL DEFAULT '' COMMENT '描述',
  `task_data` text NOT NULL COMMENT '任务数据',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `finish_time` int(11) NOT NULL DEFAULT '0' COMMENT '完成时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `fail_reason` varchar(1000) NOT NULL DEFAULT '' COMMENT '执行失败原因',
  PRIMARY KEY (`id`),
  KEY `rel_id` (`type`,`rel_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3969 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='任务表';

/*Data for the table `idcsmart_task` */

LOCK TABLES `idcsmart_task` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_task_wait` */

CREATE TABLE `idcsmart_task_wait` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '关联类型',
  `rel_id` int(10) NOT NULL DEFAULT '0',
  `task_id` int(11) NOT NULL DEFAULT '0' COMMENT 'taskID',
  `status` varchar(20) NOT NULL DEFAULT '' COMMENT '状态Wait未开始Exec执行中Finish完成Failed失败',
  `retry` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已重试0否1是',
  `description` varchar(1000) NOT NULL DEFAULT '' COMMENT '描述',
  `task_data` text NOT NULL COMMENT '任务数据',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `finish_time` int(11) NOT NULL DEFAULT '0' COMMENT '完成时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `rel_id` (`type`,`task_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3961 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='任务表';

/*Data for the table `idcsmart_task_wait` */

LOCK TABLES `idcsmart_task_wait` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_transaction` */

CREATE TABLE `idcsmart_transaction` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '交易流水ID',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `gateway` varchar(50) NOT NULL DEFAULT '' COMMENT '支付方式',
  `gateway_name` varchar(50) NOT NULL DEFAULT '' COMMENT '支付方式名称',
  `transaction_number` varchar(100) NOT NULL DEFAULT '' COMMENT '交易流水号',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `client_id` (`client_id`),
  KEY `transaction_number` (`transaction_number`)
) ENGINE=InnoDB AUTO_INCREMENT=474 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='交易流水表';

/*Data for the table `idcsmart_transaction` */

LOCK TABLES `idcsmart_transaction` WRITE;

UNLOCK TABLES;

/*Table structure for table `idcsmart_upgrade` */

CREATE TABLE `idcsmart_upgrade` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '升降级ID',
  `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `host_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `type` varchar(20) NOT NULL DEFAULT 'product' COMMENT '类型product商品,config_option配置',
  `rel_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联ID',
  `data` text NOT NULL COMMENT '配置',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '模块价格',
  `billing_cycle_name` varchar(100) NOT NULL DEFAULT '' COMMENT '模块计费周期名称',
  `billing_cycle_time` int(11) NOT NULL DEFAULT '0' COMMENT '模块计费周期时间,秒',
  `status` varchar(20) NOT NULL DEFAULT 'Unpaid' COMMENT '状态Unpaid未支付,Pending待执行,Completed已完成',
  `description` varchar(1000) NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `order_id` (`order_id`),
  KEY `host_id` (`host_id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='升降级表';

/*Data for the table `idcsmart_upgrade` */

LOCK TABLES `idcsmart_upgrade` WRITE;

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
