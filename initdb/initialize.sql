CREATE DATABASE homer_data;
CREATE DATABASE homer_configuration;
CREATE DATABASE homer_statistic;
CREATE USER 'homer_user'@'localhost' IDENTIFIED BY 'homer_password';
GRANT ALL ON homer_configuration.* TO 'homer_user'@'localhost';
GRANT ALL ON homer_statistic.* TO 'homer_user'@'localhost';
GRANT ALL ON homer_data.* TO 'homer_user'@'localhost';

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `homer_configuration`
--

USE homer_configuration;

-- --------------------------------------------------------

--
-- Table structure for table `alias`
--

CREATE TABLE IF NOT EXISTS `alias` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `gid` int(5) NOT NULL DEFAULT 0,
  `ip` varchar(80) NOT NULL DEFAULT '',
  `port` int(10) NOT NULL DEFAULT '0',
  `capture_id` varchar(100) NOT NULL DEFAULT '',
  `alias` varchar(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `host_2` (`ip`,`port`,`capture_id`),
  KEY `host` (`ip`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `alias`
--

INSERT INTO `alias` (`id`, `gid`, `ip`, `port`, `capture_id`, `alias`, `status`, `created`) VALUES
(1, 10, '192.168.0.30', 0, 'homer01', 'proxy01', 1, '2014-06-12 20:36:50'),
(2, 10, '192.168.0.4', 0, 'homer01', 'acme-234', 1, '2014-06-12 20:37:01'),
(22, 10, '127.0.0.1:5060', 0, 'homer01', 'sip.local.net', 1, '2014-06-12 20:37:01');

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE IF NOT EXISTS `group` (
  `gid` int(10) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT '',
  UNIQUE KEY `gid` (`gid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`gid`, `name`) VALUES (10, 'Administrator');

-- --------------------------------------------------------

--
-- Table structure for table `link_share`
--

CREATE TABLE IF NOT EXISTS `link_share` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL DEFAULT 0,
  `uuid` varchar(120) NOT NULL DEFAULT '',
  `data` text NOT NULL,
  `expire` datetime NOT NULL DEFAULT '2032-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

-- --------------------------------------------------------

--
-- Table structure for table `node`
--

CREATE TABLE IF NOT EXISTS `node` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `host` varchar(80) NOT NULL DEFAULT '',
  `dbname` varchar(100) NOT NULL DEFAULT '',
  `dbport` varchar(100) NOT NULL DEFAULT '',
  `dbusername` varchar(100) NOT NULL DEFAULT '',
  `dbpassword` varchar(100) NOT NULL DEFAULT '',
  `dbtables` varchar(100) NOT NULL DEFAULT 'sip_capture',
  `name` varchar(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `host_2` (`host`),
  KEY `host` (`host`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `node`
--

INSERT INTO `node` (`id`, `host`, `dbname`, `dbport`, `dbusername`, `dbpassword`, `dbtables`, `name`, `status`) VALUES
(1, '127.0.0.1', 'homer_data', '3306', 'homer_user', 'mysql_password', 'sip_capture', 'homer01', 1),
(21, '10.1.0.7', 'homer_data', '3306', 'homer_user', 'mysql_password', 'sip_capture', 'external', 1);

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE IF NOT EXISTS `setting` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL DEFAULT '0',
  `param_name` varchar(120) NOT NULL DEFAULT '',
  `param_value` text NOT NULL,
  `valid_param_from` datetime NOT NULL DEFAULT '2012-01-01 00:00:00',
  `valid_param_to` datetime NOT NULL DEFAULT '2032-12-01 00:00:00',
  `param_prio` int(2) NOT NULL DEFAULT '10',
  `active` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_2` (`uid`,`param_name`),
  KEY `param_name` (`param_name`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 ;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id`, `uid`, `param_name`, `param_value`, `valid_param_from`, `valid_param_to`, `param_prio`, `active`) VALUES
(1, 1, 'timerange', '{"from":"2015-05-26T18:34:42.654Z","to":"2015-05-26T18:44:42.654Z"}', '2012-01-01 00:00:00', '2032-12-01 00:00:00', 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gid` int(10) NOT NULL DEFAULT '10',
  `grp` varchar(200) NOT NULL DEFAULT '',
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `firstname` varchar(250) NOT NULL DEFAULT '',
  `lastname` varchar(250) NOT NULL DEFAULT '',
  `email` varchar(250) NOT NULL DEFAULT '',
  `department` varchar(100) NOT NULL DEFAULT '',
  `regdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastvisit` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `login` (`username`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uid`, `gid`, `grp`, `username`, `password`, `firstname`, `lastname`, `email`, `department`, `regdate`, `lastvisit`, `active`) VALUES
(1, 10, 'users,admins', 'admin', PASSWORD('test123'), 'Admin', 'Admin', 'admin@test.com', 'Voice Enginering', '2012-01-19 00:00:00', '2015-05-29 07:17:35', 1),
(2, 10, 'users', 'noc', PASSWORD('123test'), 'NOC', 'NOC', 'noc@test.com', 'Voice NOC', '2012-01-19 00:00:00', '2015-05-29 07:17:35', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_menu`
--

CREATE TABLE IF NOT EXISTS `user_menu` (
  `id` varchar(125) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `alias` varchar(200) NOT NULL DEFAULT '',
  `icon` varchar(100) NOT NULL DEFAULT '',
  `weight` int(10) NOT NULL DEFAULT '10',
  `active` int(1) NOT NULL DEFAULT '1',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_menu`
--

INSERT INTO `user_menu` (`id`, `name`, `alias`, `icon`, `weight`, `active`) VALUES
('_1426001444630', 'SIP Search', 'search', 'fa-search', 10, 1),
('_1427728371642', 'Home', 'home', 'fa-home', 1, 1),
('_1431721484444', 'Alarms', 'alarms', 'fa-warning', 20, 1);


-- --------------------------------------------------------

USE homer_data;
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

--
-- Table structure for table `logs_capture`
--

CREATE TABLE IF NOT EXISTS `logs_capture` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `micro_ts` bigint(18) NOT NULL DEFAULT '0',
  `correlation_id` varchar(256) NOT NULL DEFAULT '',
  `source_ip` varchar(60) NOT NULL DEFAULT '',
  `source_port` int(10) NOT NULL DEFAULT 0,
  `destination_ip` varchar(60) NOT NULL DEFAULT '',
  `destination_port` int(10) NOT NULL DEFAULT 0,
  `proto` int(5) NOT NULL DEFAULT 0,
  `family` int(1) DEFAULT NULL,
  `type` int(2) NOT NULL DEFAULT 0,
  `node` varchar(125) NOT NULL DEFAULT '',
  `msg` varchar(1500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`date`),
  KEY `date` (`date`),
  KEY `correlationid` (`correlation_id`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`date`))
(PARTITION p2013082901 VALUES LESS THAN (1377734400) ENGINE = InnoDB,
 PARTITION p2013090821 VALUES LESS THAN (1378670400) ENGINE = InnoDB,
 PARTITION p2013090822 VALUES LESS THAN (1378674000) ENGINE = InnoDB,
 PARTITION p2013090823 VALUES LESS THAN (1378677600) ENGINE = InnoDB,
 PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */  ;

-- --------------------------------------------------------

--
-- Table structure for table `report_capture`
--

CREATE TABLE IF NOT EXISTS `report_capture` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `micro_ts` bigint(18) NOT NULL DEFAULT '0',
  `correlation_id` varchar(256) NOT NULL DEFAULT '',
  `source_ip` varchar(60) NOT NULL DEFAULT '',
  `source_port` int(10) NOT NULL DEFAULT 0,
  `destination_ip` varchar(60) NOT NULL DEFAULT '',
  `destination_port` int(10) NOT NULL DEFAULT 0,
  `proto` int(5) NOT NULL DEFAULT 0,
  `family` int(1) DEFAULT NULL,
  `type` tinyint(2) NOT NULL DEFAULT 0,
  `node` varchar(125) NOT NULL DEFAULT '',
  `msg` varchar(1500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`date`),
  KEY `date` (`date`),
  KEY `correlationid` (`correlation_id`(255))
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`date`))
(PARTITION p2013082901 VALUES LESS THAN (1377734400) ENGINE = InnoDB,
 PARTITION p2013090821 VALUES LESS THAN (1378670400) ENGINE = InnoDB,
 PARTITION p2013090822 VALUES LESS THAN (1378674000) ENGINE = InnoDB,
 PARTITION p2013090823 VALUES LESS THAN (1378677600) ENGINE = InnoDB,
 PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;

-- --------------------------------------------------------

--
-- Table structure for table `rtcp_capture`
--

CREATE TABLE IF NOT EXISTS `rtcp_capture` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `micro_ts` bigint(18) NOT NULL DEFAULT '0',
  `correlation_id` varchar(256) NOT NULL DEFAULT '',
  `source_ip` varchar(60) NOT NULL DEFAULT '',
  `source_port` int(10) NOT NULL DEFAULT 0,
  `destination_ip` varchar(60) NOT NULL DEFAULT '',
  `destination_port` int(10) NOT NULL DEFAULT 0,
  `proto` int(5) NOT NULL DEFAULT 0,
  `family` int(1) DEFAULT NULL,
  `type` int(2) NOT NULL DEFAULT 0,
  `node` varchar(125) NOT NULL DEFAULT '',
  `msg` varchar(1500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`date`),
  KEY `date` (`date`),
  KEY `correlationid` (`correlation_id`(255))
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`date`))
(PARTITION p2013082901 VALUES LESS THAN (1377734400) ENGINE = InnoDB,
 PARTITION p2013090821 VALUES LESS THAN (1378670400) ENGINE = InnoDB,
 PARTITION p2013090822 VALUES LESS THAN (1378674000) ENGINE = InnoDB,
 PARTITION p2013090823 VALUES LESS THAN (1378677600) ENGINE = InnoDB,
 PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */ ;

-- --------------------------------------------------------

--
-- Table structure for table `sip_capture_call_20150407`
--

CREATE TABLE IF NOT EXISTS `sip_capture_call_20150407` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `micro_ts` bigint(18) NOT NULL DEFAULT '0',
  `method` varchar(50) NOT NULL DEFAULT '',
  `reply_reason` varchar(100) NOT NULL DEFAULT '',
  `ruri` varchar(200) NOT NULL DEFAULT '',
  `ruri_user` varchar(100) NOT NULL DEFAULT '',
  `ruri_domain` varchar(150) NOT NULL DEFAULT '',
  `from_user` varchar(100) NOT NULL DEFAULT '',
  `from_domain` varchar(150) NOT NULL DEFAULT '',
  `from_tag` varchar(64) NOT NULL DEFAULT '',
  `to_user` varchar(100) NOT NULL DEFAULT '',
  `to_domain` varchar(150) NOT NULL DEFAULT '',
  `to_tag` varchar(64) NOT NULL DEFAULT '',
  `pid_user` varchar(100) NOT NULL DEFAULT '',
  `contact_user` varchar(120) NOT NULL DEFAULT '',
  `auth_user` varchar(120) NOT NULL DEFAULT '',
  `callid` varchar(120) NOT NULL DEFAULT '',
  `callid_aleg` varchar(120) NOT NULL DEFAULT '',
  `via_1` varchar(256) NOT NULL DEFAULT '',
  `via_1_branch` varchar(80) NOT NULL DEFAULT '',
  `cseq` varchar(25) NOT NULL DEFAULT '',
  `diversion` varchar(256) NOT NULL DEFAULT '',
  `reason` varchar(200) NOT NULL DEFAULT '',
  `content_type` varchar(256) NOT NULL DEFAULT '',
  `auth` varchar(256) NOT NULL DEFAULT '',
  `user_agent` varchar(256) NOT NULL DEFAULT '',
  `source_ip` varchar(60) NOT NULL DEFAULT '',
  `source_port` int(10) NOT NULL DEFAULT 0,
  `destination_ip` varchar(60) NOT NULL DEFAULT '',
  `destination_port` int(10) NOT NULL DEFAULT 0,
  `contact_ip` varchar(60) NOT NULL DEFAULT '',
  `contact_port` int(10) NOT NULL DEFAULT 0,
  `originator_ip` varchar(60) NOT NULL DEFAULT '',
  `originator_port` int(10) NOT NULL DEFAULT 0,
  `correlation_id` varchar(256) NOT NULL DEFAULT '',
  `custom_field1` varchar(120) NOT NULL DEFAULT '',
  `custom_field2` varchar(120) NOT NULL DEFAULT '',
  `custom_field3` varchar(120) NOT NULL DEFAULT '',
  `proto` int(5) NOT NULL DEFAULT 0,
  `family` int(1) DEFAULT NULL,
  `rtp_stat` varchar(256) NOT NULL DEFAULT '',
  `type` int(2) NOT NULL DEFAULT 0,
  `node` varchar(125) NOT NULL DEFAULT '',
  `msg` varchar(1500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`date`),
  KEY `ruri_user` (`ruri_user`),
  KEY `from_user` (`from_user`),
  KEY `to_user` (`to_user`),
  KEY `pid_user` (`pid_user`),
  KEY `auth_user` (`auth_user`),
  KEY `callid_aleg` (`callid_aleg`),
  KEY `date` (`date`),
  KEY `callid` (`callid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8 COMMENT='20150407'
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`date`))
(PARTITION p2013082901 VALUES LESS THAN (1377734400) ENGINE = InnoDB,
 PARTITION p2013090822 VALUES LESS THAN (1378674000) ENGINE = InnoDB,
 PARTITION p2013090823 VALUES LESS THAN (1378677600) ENGINE = InnoDB,
 PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */  ;

-- --------------------------------------------------------

--
-- Table structure for table `sip_capture_registration_20150407`
--

CREATE TABLE IF NOT EXISTS `sip_capture_registration_20150407` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `micro_ts` bigint(18) NOT NULL DEFAULT '0',
  `method` varchar(50) NOT NULL DEFAULT '',
  `reply_reason` varchar(100) NOT NULL DEFAULT '',
  `ruri` varchar(200) NOT NULL DEFAULT '',
  `ruri_user` varchar(100) NOT NULL DEFAULT '',
  `ruri_domain` varchar(150) NOT NULL DEFAULT '',
  `from_user` varchar(100) NOT NULL DEFAULT '',
  `from_domain` varchar(150) NOT NULL DEFAULT '',
  `from_tag` varchar(64) NOT NULL DEFAULT '',
  `to_user` varchar(100) NOT NULL DEFAULT '',
  `to_domain` varchar(150) NOT NULL DEFAULT '',
  `to_tag` varchar(64) NOT NULL DEFAULT '',
  `pid_user` varchar(100) NOT NULL DEFAULT '',
  `contact_user` varchar(120) NOT NULL DEFAULT '',
  `auth_user` varchar(120) NOT NULL DEFAULT '',
  `callid` varchar(120) NOT NULL DEFAULT '',
  `callid_aleg` varchar(120) NOT NULL DEFAULT '',
  `via_1` varchar(256) NOT NULL DEFAULT '',
  `via_1_branch` varchar(80) NOT NULL DEFAULT '',
  `cseq` varchar(25) NOT NULL DEFAULT '',
  `diversion` varchar(256) NOT NULL DEFAULT '',
  `reason` varchar(200) NOT NULL DEFAULT '',
  `content_type` varchar(256) NOT NULL DEFAULT '',
  `auth` varchar(256) NOT NULL DEFAULT '',
  `user_agent` varchar(256) NOT NULL DEFAULT '',
  `source_ip` varchar(60) NOT NULL DEFAULT '',
  `source_port` int(10) NOT NULL DEFAULT 0,
  `destination_ip` varchar(60) NOT NULL DEFAULT '',
  `destination_port` int(10) NOT NULL DEFAULT 0,
  `contact_ip` varchar(60) NOT NULL DEFAULT '',
  `contact_port` int(10) NOT NULL DEFAULT 0,
  `originator_ip` varchar(60) NOT NULL DEFAULT '',
  `originator_port` int(10) NOT NULL DEFAULT 0,
  `correlation_id` varchar(256) NOT NULL DEFAULT '',
  `custom_field1` varchar(120) NOT NULL DEFAULT '',
  `custom_field2` varchar(120) NOT NULL DEFAULT '',
  `custom_field3` varchar(120) NOT NULL DEFAULT '',
  `proto` int(5) NOT NULL DEFAULT 0,
  `family` int(1) DEFAULT NULL,
  `rtp_stat` varchar(256) NOT NULL DEFAULT '',
  `type` int(2) NOT NULL DEFAULT 0,
  `node` varchar(125) NOT NULL DEFAULT '',
  `msg` varchar(1500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`date`),
  KEY `ruri_user` (`ruri_user`),
  KEY `from_user` (`from_user`),
  KEY `to_user` (`to_user`),
  KEY `pid_user` (`pid_user`),
  KEY `auth_user` (`auth_user`),
  KEY `callid_aleg` (`callid_aleg`),
  KEY `date` (`date`),
  KEY `callid` (`callid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8 COMMENT='20150407'
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`date`))
(PARTITION p2013082901 VALUES LESS THAN (1377734400) ENGINE = InnoDB,
 PARTITION p2013090822 VALUES LESS THAN (1378674000) ENGINE = InnoDB,
 PARTITION p2013090823 VALUES LESS THAN (1378677600) ENGINE = InnoDB,
 PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */  ;

-- --------------------------------------------------------

--
-- Table structure for table `sip_capture_rest_20150407`
--

CREATE TABLE IF NOT EXISTS `sip_capture_rest_20150407` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `micro_ts` bigint(18) NOT NULL DEFAULT '0',
  `method` varchar(50) NOT NULL DEFAULT '',
  `reply_reason` varchar(100) NOT NULL DEFAULT '',
  `ruri` varchar(200) NOT NULL DEFAULT '',
  `ruri_user` varchar(100) NOT NULL DEFAULT '',
  `ruri_domain` varchar(150) NOT NULL DEFAULT '',
  `from_user` varchar(100) NOT NULL DEFAULT '',
  `from_domain` varchar(150) NOT NULL DEFAULT '',
  `from_tag` varchar(64) NOT NULL DEFAULT '',
  `to_user` varchar(100) NOT NULL DEFAULT '',
  `to_domain` varchar(150) NOT NULL DEFAULT '',
  `to_tag` varchar(64) NOT NULL DEFAULT '',
  `pid_user` varchar(100) NOT NULL DEFAULT '',
  `contact_user` varchar(120) NOT NULL DEFAULT '',
  `auth_user` varchar(120) NOT NULL DEFAULT '',
  `callid` varchar(120) NOT NULL DEFAULT '',
  `callid_aleg` varchar(120) NOT NULL DEFAULT '',
  `via_1` varchar(256) NOT NULL DEFAULT '',
  `via_1_branch` varchar(80) NOT NULL DEFAULT '',
  `cseq` varchar(25) NOT NULL DEFAULT '',
  `diversion` varchar(256) NOT NULL DEFAULT '',
  `reason` varchar(200) NOT NULL DEFAULT '',
  `content_type` varchar(256) NOT NULL DEFAULT '',
  `auth` varchar(256) NOT NULL DEFAULT '',
  `user_agent` varchar(256) NOT NULL DEFAULT '',
  `source_ip` varchar(60) NOT NULL DEFAULT '',
  `source_port` int(10) NOT NULL DEFAULT 0,
  `destination_ip` varchar(60) NOT NULL DEFAULT '',
  `destination_port` int(10) NOT NULL DEFAULT 0,
  `contact_ip` varchar(60) NOT NULL DEFAULT '',
  `contact_port` int(10) NOT NULL DEFAULT 0,
  `originator_ip` varchar(60) NOT NULL DEFAULT '',
  `originator_port` int(10) NOT NULL DEFAULT 0,
  `correlation_id` varchar(256) NOT NULL DEFAULT '',
  `custom_field1` varchar(120) NOT NULL DEFAULT '',
  `custom_field2` varchar(120) NOT NULL DEFAULT '',
  `custom_field3` varchar(120) NOT NULL DEFAULT '',
  `proto` int(5) NOT NULL DEFAULT 0,
  `family` int(1) DEFAULT NULL,
  `rtp_stat` varchar(256) NOT NULL DEFAULT '',
  `type` int(2) NOT NULL DEFAULT 0,
  `node` varchar(125) NOT NULL DEFAULT '',
  `msg` varchar(1500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`date`),
  KEY `ruri_user` (`ruri_user`),
  KEY `from_user` (`from_user`),
  KEY `to_user` (`to_user`),
  KEY `pid_user` (`pid_user`),
  KEY `auth_user` (`auth_user`),
  KEY `callid_aleg` (`callid_aleg`),
  KEY `date` (`date`),
  KEY `callid` (`callid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8 COMMENT='20150407'
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`date`))
(PARTITION p2013082901 VALUES LESS THAN (1377734400) ENGINE = InnoDB,
 PARTITION p2013090822 VALUES LESS THAN (1378674000) ENGINE = InnoDB,
 PARTITION p2013090823 VALUES LESS THAN (1378677600) ENGINE = InnoDB,
 PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */  ;

USE homer_statistic;

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `homer_statistic`
--

-- --------------------------------------------------------

--
-- Table structure for table `alarm_config`
--

CREATE TABLE IF NOT EXISTS `alarm_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `startdate` datetime NOT NULL,
  `stopdate` datetime NOT NULL,
  `type` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `value` int(5) NOT NULL DEFAULT 0,
  `notify` tinyint(1) NOT NULL DEFAULT '1',
  `email` varchar(200) NOT NULL DEFAULT '',
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1  ;

-- --------------------------------------------------------

--
-- Table structure for table `alarm_data`
--

CREATE TABLE IF NOT EXISTS `alarm_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` varchar(50) NOT NULL DEFAULT '',
  `total` int(20) NOT NULL DEFAULT 0,
  `source_ip` varchar(150) NOT NULL DEFAULT '0.0.0.0',
  `description` varchar(256) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`create_date`),
  KEY `to_date` (`create_date`),
  KEY `method` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`create_date`))
(PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;

-- --------------------------------------------------------

--
-- Table structure for table `alarm_data_mem`
--

CREATE TABLE IF NOT EXISTS `alarm_data_mem` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` varchar(50) NOT NULL DEFAULT '',
  `total` int(20) NOT NULL DEFAULT 0,
  `source_ip` varchar(150) NOT NULL DEFAULT '0.0.0.0',
  `description` varchar(256) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`source_ip`),
  KEY `to_date` (`create_date`),
  KEY `method` (`type`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1  ;

-- --------------------------------------------------------

--
-- Table structure for table `stats_data`
--

CREATE TABLE IF NOT EXISTS `stats_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `type` varchar(50) NOT NULL DEFAULT '',
  `total` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`from_date`),
  UNIQUE KEY `datemethod` (`from_date`,`to_date`,`type`),
  KEY `from_date` (`from_date`),
  KEY `to_date` (`to_date`),
  KEY `method` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`from_date`))
(PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */ ;

-- --------------------------------------------------------

--
-- Table structure for table `stats_ip`
--

CREATE TABLE IF NOT EXISTS `stats_ip` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `method` varchar(50) NOT NULL DEFAULT '',
  `source_ip` varchar(255) NOT NULL DEFAULT '0.0.0.0',
  `total` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`from_date`),
  UNIQUE KEY `datemethod` (`from_date`,`to_date`,`method`,`source_ip`),
  KEY `from_date` (`from_date`),
  KEY `to_date` (`to_date`),
  KEY `method` (`method`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`from_date`))
(PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */ ;

-- --------------------------------------------------------

--
-- Table structure for table `stats_ip_mem`
--

CREATE TABLE IF NOT EXISTS `stats_ip_mem` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `method` varchar(50) NOT NULL DEFAULT '',
  `source_ip` varchar(255) NOT NULL DEFAULT '0.0.0.0',
  `total` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `datemethod` (`method`,`source_ip`)
) ENGINE=MEMORY  DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Table structure for table `stats_geo_mem`
--

CREATE TABLE IF NOT EXISTS `stats_geo_mem` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT ,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `method` varchar(50) NOT NULL DEFAULT '',
  `country` varchar(255) NOT NULL DEFAULT 'UN',
  `lat` float NOT NULL DEFAULT '0',
  `lon` float NOT NULL DEFAULT '0',
  `total` int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `datemethod` (`method`,`country`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Table structure for table `stats_geo`
--

CREATE TABLE IF NOT EXISTS `stats_geo` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `method` varchar(50) NOT NULL DEFAULT '',
  `country` varchar(255) NOT NULL DEFAULT 'UN',
  `lat` float NOT NULL DEFAULT '0',
  `lon` float NOT NULL DEFAULT '0',
  `total` int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`from_date`),
  UNIQUE KEY `datemethod` (`from_date`,`to_date`,`method`,`country`),
  KEY `from_date` (`from_date`),
  KEY `to_date` (`to_date`),
  KEY `method` (`method`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`from_date`))
(PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */ ;

-- --------------------------------------------------------

--
-- Table structure for table `stats_method`
--

CREATE TABLE IF NOT EXISTS `stats_method` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `method` varchar(50) NOT NULL DEFAULT '',
  `auth` tinyint(1) NOT NULL DEFAULT '0',
  `cseq` varchar(100) NOT NULL DEFAULT '',
  `totag` tinyint(1) NOT NULL DEFAULT 0,
  `total` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`from_date`),
  UNIQUE KEY `datemethod` (`from_date`,`to_date`,`method`,`auth`,`totag`,`cseq`),
  KEY `from_date` (`from_date`),
  KEY `to_date` (`to_date`),
  KEY `method` (`method`),
  KEY `completed` (`cseq`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`from_date`))
(PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */ ;

-- --------------------------------------------------------

--
-- Table structure for table `stats_method_mem`
--

CREATE TABLE IF NOT EXISTS `stats_method_mem` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `method` varchar(50) NOT NULL DEFAULT '',
  `auth` tinyint(1) NOT NULL DEFAULT '0',
  `cseq` varchar(100) NOT NULL DEFAULT '',
  `totag` tinyint(1) NOT NULL DEFAULT 0,
  `total` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `datemethod` (`method`,`auth`,`totag`,`cseq`),
  KEY `from_date` (`create_date`),
  KEY `method` (`method`),
  KEY `completed` (`cseq`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1  ;

-- --------------------------------------------------------

--
-- Table structure for table `stats_useragent`
--

CREATE TABLE IF NOT EXISTS `stats_useragent` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `useragent` varchar(100) NOT NULL DEFAULT '',
  `method` varchar(50) NOT NULL DEFAULT '',
  `total` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`from_date`),
  UNIQUE KEY `datemethodua` (`from_date`,`to_date`,`method`,`useragent`),
  KEY `from_date` (`from_date`),
  KEY `to_date` (`to_date`),
  KEY `useragent` (`useragent`),
  KEY `method` (`method`),
  KEY `total` (`total`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`from_date`))
(PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;

-- --------------------------------------------------------

--
-- Table structure for table `stats_useragent_mem`
--

CREATE TABLE IF NOT EXISTS `stats_useragent_mem` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `useragent` varchar(100) NOT NULL DEFAULT '',
  `method` varchar(50) NOT NULL DEFAULT '',
  `total` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `useragent` (`useragent`,`method`)
) ENGINE=MEMORY  DEFAULT CHARSET=latin1  ;


CREATE TABLE IF NOT EXISTS `stats_generic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `to_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `type` varchar(50) NOT NULL DEFAULT '',
  `total` int(20) NOT NULL,
  PRIMARY KEY (`id`,`from_date`),
  UNIQUE KEY `datemethod` (`from_date`,`to_date`,`type`),
  KEY `from_date` (`from_date`),
  KEY `to_date` (`to_date`),
  KEY `method` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8
/*!50100 PARTITION BY RANGE ( UNIX_TIMESTAMP(`from_date`))
(PARTITION pmax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;
